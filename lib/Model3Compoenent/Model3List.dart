// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model3.dart';
import 'package:sqflite/sqflite.dart';

import 'Model3Add.dart';

class Model3List extends StatefulWidget {
  @override
  _Model3ListState createState() => _Model3ListState();
}

class _Model3ListState extends State<Model3List> {
  DBHelper dbHelper = DBHelper();
  List<Model3> model3List =<Model3>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (model3List == null) {
      model3List = <Model3>[];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model 3'),
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
                        return Model3Add(model3List[position], "Edit");
                      },
                    ),
                  );
                },
                leading: Text(model3List[position].id.toString()),
                title: Text(model3List[position].model3Name.toString() +
                    "\n M1id: " +
                    model3List[position].model1Id.toString() +
                    ", M2id: " +
                    model3List[position].model2Id.toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _delete(context, model3List[position]);
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
                return Model3Add(Model3("", 0, 0), "Add");
              },
            ),
          );
        },
        tooltip: 'Add Model 2',
        child: const Icon(Icons.add),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initailizeDB();
    dbFuture.then((db) {
      Future<List<Model3>> model3ListFuture = dbHelper.getModel3List();
      model3ListFuture.then((model3List) {
        setState(() {
          this.model3List = model3List;
          count = model3List.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Model3 model1) async {
    int result = await dbHelper.deleteModel2(model1.id);
    if (result != 0) {
      _showSnackBar(context, 'Model 2 Deleted Successfully!');
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
