class Model1 {
  // data members
  int _id=0;
  String? model1Name;

  // constructors
  Model1(this.model1Name);
  Model1.withID(this._id, this.model1Name);

  // getters and setters
  int get id => _id;

  // to and from :: mapper converters
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = _id;
    map['model1Name'] = model1Name;

    return map;
  }

  Model1.fromMapObj(Map<String, dynamic> map) {
    _id = map['id'];
    model1Name = map['model1Name'];
  }
}
