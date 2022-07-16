import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model2.dart';
import 'package:sqflite/sqflite.dart';

import 'Model2Add.dart';

class Model2List extends StatefulWidget {
  @override
  _Model2ListState createState() => _Model2ListState();
}

class _Model2ListState extends State<Model2List> {
  DBHelper dbHelper = DBHelper();
  List<Model2> model2List=<Model2>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (model2List == null) {
      model2List = <Model2>[];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title:const Text('Model 2'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
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
                        return Model2Add(model2List[position], "Edit");
                      },
                    ),
                  );
                },
                leading: Text(model2List[position].id.toString()),
                title: Text(model2List[position].model2Name.toString() +
                    "\n M1id: " +
                    model2List[position].model1Id.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _delete(context, model2List[position]);
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
                return Model2Add(Model2("", 0), "Add");
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
      Future<List<Model2>> model1ListFuture = dbHelper.getModel2List();
      model1ListFuture.then((model1List) {
        setState(() {
          model2List = model1List;
          count = model1List.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Model2 model1) async {
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
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
