// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model3.dart';

class Model3Add extends StatefulWidget {
  Model3 model3;
  String msg;
  Model3Add(this.model3, this.msg, {Key? key}) : super(key: key);
  @override
  _Model3AddState createState() => _Model3AddState();
}

class _Model3AddState extends State<Model3Add> {
  DBHelper dbHelper = DBHelper();
  TextEditingController model1Id = TextEditingController();
  TextEditingController model2Id = TextEditingController();
  TextEditingController model3Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    model1Id.text = widget.model3.model1Id.toString();
    model2Id.text = widget.model3.model2Id.toString();
    model3Name.text = widget.model3.model3Name.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg + ' Model 3'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding:const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: model1Id,
                decoration: const InputDecoration(
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
              padding: const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: model2Id,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Model 2 ID",
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
                controller: model3Name,
                decoration:const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Model 3 Name",
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
                widget.model3.model3Name = model3Name.text;
                widget.model3.model1Id = int.parse(model1Id.text);
                widget.model3.model2Id = int.parse(model2Id.text);
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
    if (widget.model3.id != 0) {
      result = await dbHelper.updateModel3(widget.model3);
    } else {
      result = await dbHelper.insertModel3(widget.model3);
    }

    if (result != 0) {
      _showAlterDialog('Status', 'Model 3 Saved Successfully');
    } else {
      _showAlterDialog('Status', 'Not Saved');
    }
  }
}
