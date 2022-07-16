// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model1.dart';

class Model1Add extends StatefulWidget {
  Model1 model1;
  String msg;
  Model1Add(this.model1, this.msg, {Key? key}) : super(key: key);
  @override
  _Model1AddState createState() => _Model1AddState();
}

class _Model1AddState extends State<Model1Add> {
  DBHelper dbHelper = DBHelper();
  TextEditingController model1Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    model1Name.text = widget.model1.model1Name.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg + " Model 1"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: model1Name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Model 1 Name",
                  icon: Icon(
                    Icons.padding,
                    color: Colors.black12,
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: "sofia"),
                ),
              ),
            ),
            RaisedButton(
              child: const Text('Save'),
              onPressed: () {
                widget.model1.model1Name = model1Name.text;
                _save();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAlterDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _save() async {
    Navigator.pop(context);
    int result;
    if (widget.model1.id != 0) {
      result = await dbHelper.updateModel1(widget.model1);
    } else {
      result = await dbHelper.insertModel1(widget.model1);
    }

    if (result != 0) {
      _showAlterDialog('Status', 'Model 1 Saved Successfully');
    } else {
      _showAlterDialog('Status', 'Not Saved');
    }
  }
}
