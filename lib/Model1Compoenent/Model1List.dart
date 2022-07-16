import 'package:flutter/material.dart';
import 'package:flutter_app/Model1Compoenent/Model1Add.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model1.dart';
import 'package:sqflite/sqflite.dart';

class Model1List extends StatefulWidget {
  @override
  _Model1ListState createState() => _Model1ListState();
}

class _Model1ListState extends State<Model1List> {
  DBHelper dbHelper = DBHelper();
  List<Model1> model1List=<Model1>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (model1List == null) {
      model1List = <Model1>[];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Model 1'),
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
                        return Model1Add(model1List[position], "Edit");
                      },
                    ),
                  );
                },
                leading: Text(model1List[position].id.toString()),
                title: Text(model1List[position].model1Name.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _delete(context, model1List[position]);
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
                return Model1Add(Model1(""), "Add");
              },
            ),
          );
        },
        tooltip: 'Add Model 1',
        child: const Icon(Icons.add),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initailizeDB();
    dbFuture.then((db) {
      Future<List<Model1>> model1ListFuture = dbHelper.getModel1List();
      model1ListFuture.then((model1List) {
        setState(() {
          this.model1List = model1List;
          count = model1List.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Model1 model1) async {
    int result = await dbHelper.deleteModel1(model1.id);
    if (result != 0) {
      _showSnackBar(context, 'Model 1 Deleted Successfully!');
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
