import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new ListApp());

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new ListState();
}

class ListState extends State<TodoList> {
  List<String> _listItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _listItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _listItems.removeAt(index));
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _listItems.length) {
          return _buildTodoItem(_listItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText), onTap: () => _promptRemoveTodoItem(index));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: new AppBar(
        title: new Text('DSC Task-1 To do List App'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed:
              _pushAddTodoScreen, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Text('Add')),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          backgroundColor: Colors.tealAccent,
          appBar: new AppBar(
            title: new Text('New Task'),
            backgroundColor: Colors.blueGrey,
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Type Task',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
              title: new Text('Mark "${_listItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
