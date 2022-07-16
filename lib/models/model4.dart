// ignore_for_file: unnecessary_getters_setters

class Model4 {
  // data members
  int _id=0;
  String? model4Name;

  int _model1Id=0;
  int _model2Id=0;
  int _model3Id=0;

  // constructors
  Model4(this.model4Name, this._model1Id, this._model2Id, this._model3Id);
  Model4.withID(this._id, this.model4Name, this._model1Id, this._model2Id, this._model3Id);

// getters and setters
  int get id => _id;
  int get model1Id => _model1Id;
  int get model2Id => _model2Id;
  int get model3Id => _model3Id;

  set model1Id(int model1Id){
    _model1Id = model1Id;
  }

   set model2Id(int model2Id){
    _model2Id = model2Id;
  }

  set model3Id(int model3Id){
    _model3Id = model3Id;
  }

  // to and from :: mapper converters
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    
    map['id'] = _id;
    map['model4Name'] = model4Name;

    map['model1Id'] = _model1Id;
    map['model2Id'] = _model2Id;
    map['model3Id'] = _model3Id;

    return map;
  }

  Model4.fromMapObj(Map<String, dynamic> map) {
    _id = map['id'];
    model4Name = map['model4Name'];

    _model1Id = map['model1Id'];
    _model2Id = map['model2Id'];
    _model3Id = map['model3Id'];
  }
}