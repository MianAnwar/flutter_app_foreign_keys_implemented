import 'package:flutter/material.dart';
import 'package:flutter_app/Utility/dB_helper.dart';
import 'package:flutter_app/models/model4.dart';

class Model4Add extends StatefulWidget {
  Model4 model4;
  String msg;
  Model4Add(this.model4, this.msg);
  @override
  _Model4AddState createState() => _Model4AddState();
}

class _Model4AddState extends State<Model4Add> {
  DBHelper dbHelper = DBHelper();
  TextEditingController model1Id = TextEditingController();
  TextEditingController model2Id = TextEditingController();
  TextEditingController model3Id = TextEditingController();
  TextEditingController model4Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    model1Id.text = widget.model4.model1Id.toString();
    model2Id.text = widget.model4.model2Id.toString();
    model3Id.text = widget.model4.model3Id.toString();
    model4Name.text = widget.model4.model4Name.toString();

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
                decoration:const InputDecoration(
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
              padding: const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: model3Id,
                decoration:const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Model 3 ID",
                  icon: Icon(
                    Icons.perm_device_information_rounded,
                    color: Colors.black12,
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: "sofia"),
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.all(15),
              child: TextField(
                controller: model4Name,
                decoration: const InputDecoration(
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
            // ignore: deprecated_member_use
            RaisedButton(
              child:const Text('Save'),
              onPressed: () {
                widget.model4.model4Name = model4Name.text;
                widget.model4.model1Id = int.parse(model1Id.text);
                widget.model4.model2Id = int.parse(model2Id.text);
                widget.model4.model3Id = int.parse(model3Id.text);
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
    if (widget.model4.id != 0) {
      result = await dbHelper.updateModel4(widget.model4);
    } else {
      result = await dbHelper.insertModel4(widget.model4);
    }

    if (result != 0) {
      _showAlterDialog('Status', 'Model 4 Saved Successfully');
    } else {
      _showAlterDialog('Status', 'Not Saved');
    }
  }
}
