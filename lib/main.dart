// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:caterpillar/todoList.dart';
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todos', home: App());
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class TodoListInstance {
  late String listTitle;
  late List<ListItem> listItems;
  TodoListInstance(this.listTitle, this.listItems);
}

List<TodoListInstance> todoLists = [];

var textController = TextEditingController();

class AppState extends State<App> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos:"),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: "Enter Todo List name"),
                      style: TextStyle(
                        fontSize: 22.0,
                        //color: Theme.of(context).accentColor,
                      ),
                      controller: textController,
                      cursorWidth: 5.0,
                      autocorrect: true,
                      autofocus: true,
                    ),
                    key: Key('Todo list name field'),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text("Add List"),
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          setState(() {
                            todoLists
                                .add(TodoListInstance(textController.text, []));
                            textController.clear();
                          });
                        }
                      },
                      key: Key('add new todo list'),
                    ),
                    margin: const EdgeInsets.all(4),
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 500,
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 40,
                          maxCrossAxisExtent: 500,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: todoLists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TodoList(
                              key: UniqueKey(),
                              title: todoLists[index].listTitle,
                              listItems: todoLists[index].listItems,
                              addItem: (ListItem listItem) {
                                setState(() {
                                  todoLists[index]
                                      .listItems
                                      .insert(0, listItem);
                                });
                              },
                              toggleItemSelection: (int _index) {
                                setState(() {
                                  ListItem item =
                                      todoLists[index].listItems[_index];
                                  item.todoCheck = !item.todoCheck;
                                });
                              },
                              clearSelected: () {
                                setState(() {
                                  List<ListItem> unselected = todoLists[index]
                                      .listItems
                                      .where((item) => !item.todoCheck)
                                      .toList();
                                  print(unselected);
                                  todoLists[index].listItems = unselected;
                                });
                              },
                              clearAll: () {
                                setState(() {
                                  todoLists[index].listItems = [];
                                });
                              },
                              removeItem: (int itemIndex) {
                                setState(() {
                                  todoLists[index]
                                      .listItems
                                      .removeAt(itemIndex);
                                });
                              },
                              reorderItem: (int oldIndex, int newIndex) {
                                setState(() {
                                  if (newIndex > oldIndex) {
                                    newIndex -= 1;
                                  }
                                  final item = todoLists[index]
                                      .listItems
                                      .removeAt(oldIndex);
                                  todoLists[index]
                                      .listItems
                                      .insert(newIndex, item);
                                });
                              },
                              deleteList: () {
                                setState(() {
                                  List<TodoListInstance> newList =
                                      List.from(todoLists);
                                  newList.removeAt(index);
                                  todoLists = newList;
                                });
                              });
                        }),
                  )
                ])));
  }
}
