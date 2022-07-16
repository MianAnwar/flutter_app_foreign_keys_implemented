// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model4.dart';
import 'package:sqflite/sqflite.dart';

import 'Model4Add.dart';

class Model4List extends StatefulWidget {
  @override
  _Model4ListState createState() => _Model4ListState();
}

class _Model4ListState extends State<Model4List> {
  DBHelper dbHelper = DBHelper();
  List<Model4> model4List =<Model4>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (model4List == null) {
      model4List = <Model4>[];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model 4'),
        centerTitle: true,
        actions: [
          IconButton(
              icon:const Icon(Icons.refresh),
              onPressed: () {
                updateListView();
              })
        ],
      ),
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Model4Add(model4List[position], "Edit");
                      },
                    ),
                  );
                },
                leading: Text(model4List[position].id.toString()),
                title: Text(model4List[position].model4Name.toString() +
                    "\nM1id: " +
                    model4List[position].model1Id.toString() +
                    ", M2id: " +
                    model4List[position].model2Id.toString() +
                    ", M3id: " +
                    model4List[position].model3Id.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _delete(context, model4List[position]);
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Model4Add(Model4("", 0, 0, 0), "Add");
              },
            ),
          );
        },
        tooltip: 'Add Model 2',
        child:const Icon(Icons.add),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initailizeDB();
    dbFuture.then((db) {
      Future<List<Model4>> model4ListFuture = dbHelper.getModel4List();
      model4ListFuture.then((model4List) {
        setState(() {
          this.model4List = model4List;
          count = model4List.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Model4 model1) async {
    int result = await dbHelper.deleteModel2(model1.id);
    if (result != 0) {
      _showSnackBar(context, 'Model 4 Deleted Successfully!');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
