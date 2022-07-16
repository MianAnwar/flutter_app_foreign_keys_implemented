// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model2.dart';

class Model2Add extends StatefulWidget {
  Model2 model2;
  String msg;
  Model2Add(this.model2, this.msg, {Key? key}) : super(key: key);
  @override
  _Model2AddState createState() => _Model2AddState();
}

class _Model2AddState extends State<Model2Add> {
  DBHelper dbHelper = DBHelper();
  TextEditingController model1Id = TextEditingController();
  TextEditingController model2Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    model1Id.text = widget.model2.model1Id.toString();
    model2Name.text = widget.model2.model2Name.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg + ' Model 2'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding:const  EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: model1Id,
                decoration:const  InputDecoration(
                  border: InputBorder.none,
                  hintText: "Model 1 ID",
                  icon: Icon(
                    Icons.perm_device_information_rounded,
                    color: Colors.black12,
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: "sofia"),
                ),
              ),
            ),
            Container(
              padding:const  EdgeInsets.all(15),
              child: TextField(
                controller: model2Name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Model 2 Name",
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
                widget.model2.model2Name = model2Name.text;
                widget.model2.model1Id = int.parse(model1Id.text);
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
    if (widget.model2.id != 0) {
      result = await dbHelper.updateModel2(widget.model2);
    } else {
      result = await dbHelper.insertModel2(widget.model2);
    }

    if (result != 0) {
      _showAlterDialog('Status', 'Model 2 Saved Successfully');
    } else {
      _showAlterDialog('Status', 'Not Saved');
    }
  }
}
