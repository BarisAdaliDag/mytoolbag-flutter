class Todo {
  int _id;
  String _subject;
  String _body;
  String _date;

  Todo(this._subject, this._date, [this._body]);
  Todo.withId(this._id, this._subject, this._date, [this._body]);

  int get id => _id;
  String get subject => _subject;
  String get body => _body;

  String get date => _date;

  set subject(String newTitle) {
    if (newTitle.length <= 255) {
      _subject = newTitle;
    }
  }

  set body(String newD) {
    if (newD.length <= 255) {
      _body = newD;
    }
  }

  set date(String newD) {
    _date = newD;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["subject"] = _subject;
    map["body"] = _body;
    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Todo.fromObject(dynamic a) {
    this._id = a["id"];
    this._subject = a["subject"];
    this._body = a["body"];
    //this._priority = a["priority"];
    this._date = a["date"];
  }
}
