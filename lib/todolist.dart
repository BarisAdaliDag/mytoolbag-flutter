import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytoolbag/todbhelper.dart';
import 'package:mytoolbag/todo.dart';
import 'package:mytoolbag/todoDetail.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = [];
      getData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Todo("", ""));
        },
        tooltip: 'Add New Todo',
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) => Card(
          color: Colors.white,
          elevation: 10.0,
          child: ListTile(
            title: Text(
              this.todos[index].subject,
              style: TextStyle(fontSize: 40.0, color: Colors.black),
            ),
            subtitle: Text(
              '${this.todos[index].body}      -       ${this.todos[index].date} ',
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
            isThreeLine: true,
            onTap: () {
              navigateToDetail(this.todos[index]);
            },
          ),
        ),
      ),
    );
  }

  void navigateToDetail(Todo todo) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoDetail(todo)));
    if (result == true) {
      getData();
    }
  }

  void getData() {
    final todosFuture = helper.getTodoLists();
    todosFuture.then(
      (result) => {
        setState(() {
          todos = result;
          count = todos.length;
        })
      },
    );
  }
}
//////////////////////
///*
///
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytoolbag/todbhelper.dart';
import 'package:mytoolbag/todo.dart';
import 'package:mytoolbag/todoDetail.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = [];
      getData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Todo("", ""));
        },
        tooltip: 'Add New Todo',
        child: Icon(Icons.add),
      ),
      body: todoListItems(),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) => Card(
            color: Colors.white,
            elevation: 10.0,
            child: ListTile(
              title: Text(
                this.todos[index].subject,
                style: TextStyle(fontSize: 40.0, color: Colors.black),
              ),
              subtitle: Text(
                '${this.todos[index].body}      -       ${this.todos[index].date} ',
                style: TextStyle(fontSize: 25.0, color: Colors.black),
              ),
              isThreeLine: true,
              onTap: () {
                navigateToDetail(this.todos[index]);
              },
            )));
  }

  void navigateToDetail(Todo todo) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoDetail(todo)));
    if (result == true) {
      getData();
    }
  }

  void getData() {
    final todosFuture = helper.getTodoLists();
    todosFuture.then(
      (result) => {
        setState(() {
          todos = result;
          count = todos.length;
        })
      },
    );
  }
}
*/
