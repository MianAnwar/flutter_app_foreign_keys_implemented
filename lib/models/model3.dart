// ignore_for_file: unnecessary_getters_setters

class Model3 {
  // data members
  int _id=0;
  String? model3Name;

  int _model1Id=0;
  int _model2Id=0;

  // constructors
  Model3(this.model3Name, this._model1Id, this._model2Id);
  Model3.withID(this._id, this.model3Name, this._model1Id, this._model2Id);

  // getters and setters
  int get id => _id;
  int get model1Id => _model1Id;
  int get model2Id => _model2Id;

  set model1Id(int model1Id){
    _model1Id = model1Id;
  }

   set model2Id(int model2Id){
    _model2Id = model2Id;
  }

  // to and from :: mapper converters
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    
    map['id'] = _id;
    map['model3Name'] = model3Name;

    map['model1Id'] = _model1Id;
    map['model2Id'] = _model2Id;

    return map;
  }

  Model3.fromMapObj(Map<String, dynamic> map) {
    _id = map['id'];
    model3Name = map['model3Name'];

    _model1Id = map['model1Id'];
    _model2Id = map['model2Id'];
  }
}