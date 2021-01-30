import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mytoolbag/todbhelper.dart';
import 'package:mytoolbag/todo.dart';

import 'todbhelper.dart';

DbHelper helper = DbHelper();

class TodoDetail extends StatefulWidget {
  final Todo todo;

  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() {
    return TodoDetailState(todo);
  }
}

class TodoDetailState extends State {
  final Todo todo;

  TodoDetailState(this.todo);

  TextEditingController subController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  DateTime _date = DateTime.now();
  TextEditingController dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat("dd MMM, yyyy");
  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    );
    dateController.text = _dateFormatter.format(date);
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    subController.text = todo.subject;
    bodyController.text = todo.body;
    dateController.text = todo.date;

    var textStyle = Theme.of(context).textTheme.caption;

    return Scaffold(
        appBar: AppBar(
          title: Text('To Do App'),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    TextField(
                      controller: subController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hoverColor: Colors.blueAccent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        labelText: 'Subject',
                        fillColor: Colors.blueAccent,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: bodyController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hoverColor: Colors.blueAccent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        labelText: 'Body',
                        fillColor: Colors.blueAccent,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: dateController,
                        onTap: _handleDatePicker,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Date",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)))),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: Text(todo.id == null ? 'Add' : 'Update'),
                        onPressed: () {
                          save();
                        },
                      ),
                    ),
                    todo.id != null
                        ? Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              child: Text("delete"),
                              onPressed: () {
                                delete();
                              },
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void delete() async {
    Navigator.pop(context, true);

    int result;
    result = await helper.deleteTodoList(todo.id);
    if (result != 0) {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Delete Todo"),
        content: Text("The Todo has been deleted"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void save() {
    todo.subject = subController.text;
    todo.body = bodyController.text;
    todo.date = dateController.text;
    if (todo.id != null) {
      helper.updateTodoList(todo);
    } else {
      helper.insertTodoList(todo);
    }
    Navigator.pop(context, true);
    showAlert(todo.id != null);
  }

  void showAlert(bool isUpdate) {
    AlertDialog alertDialog;
    if (isUpdate) {
      alertDialog = AlertDialog(
        title: Text("Update Todo"),
        content: Text("The Todo has been updated"),
      );
    } else {
      alertDialog = AlertDialog(
        title: Text("Insert Todo"),
        content: Text("The Todo has been inserted"),
      );
    }
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
