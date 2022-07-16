// ignore_for_file: unnecessary_getters_setters

class Model2 {
  // data members
  int _id=0;
  String? model2Name;

  int _model1Id=0;

  // constructors
  Model2(this.model2Name, this._model1Id);
  Model2.withID(this._id, this.model2Name, this._model1Id);

  // getters and setters
  int get id => _id;
  int get model1Id => _model1Id;

  set model1Id(int model1Id){
    _model1Id = model1Id;
  }


  // to and from :: mapper converters
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = _id;
    map['model2Name'] = model2Name;
    map['model1Id'] = _model1Id;

    return map;
  }

  Model2.fromMapObj(Map<String, dynamic> map) {
    _id = map['id'];
    model2Name = map['model2Name'];
    _model1Id = map['model1Id'];
  }
}
