class Classe {
  //attributes = fields in table
  int _id;
  String _name;
  int _average;
  Classe(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _average = obj['average'];
  }
  Classe.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _average = data['average'];
  }
  Map<String, dynamic> toMap() =>
      {'id': _id, 'name': _name, 'average': _average};

  int get id => _id;
  String get name => _name;
  int get average => _average;
}
