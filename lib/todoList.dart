import 'dart:math';

import 'package:flutter/material.dart';

import 'StatefulCheckbox.dart';

class ListItem {
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck);
}

// List<ListItem> widgetList = [];

class TodoList extends StatefulWidget {
  TodoList({
    Key? key,
    required this.title,
    required this.listItems,
    required this.clearSelected,
    required this.clearAll,
    required this.removeItem,
    required this.reorderItem,
    required this.addItem,
    required this.toggleItemSelection,
    required this.deleteList,
  }) : super(key: key);
  final title;
  final listItems;
  final clearSelected;
  final clearAll;
  final removeItem;
  final reorderItem;
  final addItem;
  final toggleItemSelection;
  final deleteList;

  @override
  TodoListState createState() {
    return TodoListState(
      title: title,
      listItems: listItems,
      clearAll: clearAll,
      clearSelected: clearSelected,
      removeItem: removeItem,
      reorderItem: reorderItem,
      addItem: addItem,
      toggleItemSelection: toggleItemSelection,
      deleteList: deleteList,
    );
  }
}

class TodoListState extends State<TodoList> {
  TodoListState({
    Key? key,
    required this.title,
    required this.listItems,
    required this.clearSelected,
    required this.clearAll,
    required this.removeItem,
    required this.reorderItem,
    required this.addItem,
    required this.toggleItemSelection,
    required this.deleteList,
  });
  final title;
  final listItems;
  final clearSelected;
  final clearAll;
  final removeItem;
  final reorderItem;
  final addItem;
  final toggleItemSelection;
  final deleteList;

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        key: Key(Random(5).toString()),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          title,
                          key: Key(Random(5).toString()),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        key: Key('title'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          child: Text("Delete Todo List"),
                          onPressed: () {
                            setState(() {
                              deleteList();
                            });
                          },
                          key: Key('submit todo button'),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Enter Todo Text Here"),
                  style: TextStyle(
                    fontSize: 22.0,
                    //color: Theme.of(context).accentColor,
                  ),
                  controller: textController,
                  cursorWidth: 5.0,
                  autocorrect: true,
                  autofocus: true,
                ),
                key: Key('Todo input field'),
              ),
              Container(
                key: Key('buttons'),
                child: Row(
                  children: [
                    Container(
                      child: ElevatedButton(
                        child: Text("Add Todo"),
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            addItem(new ListItem(textController.text, false));
                            textController.clear();
                          }
                        },
                        key: Key('submit todo button'),
                      ),
                      margin: const EdgeInsets.all(4),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text("Clear selected todos"),
                        onPressed: () {
                          setState(() {
                            clearSelected();
                          });
                        },
                        key: Key('remove selected todo button'),
                      ),
                      margin: const EdgeInsets.all(4),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text("Clear ALL todos"),
                        onPressed: () {
                          clearAll();
                        },
                        key: Key('remove all todos button'),
                      ),
                      margin: const EdgeInsets.all(4),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Expanded(
                  child: ReorderableListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ReorderableDragStartListener(
                        index: index,
                        child: StatefulCheckbox(
                            isSelected: listItems[index].todoCheck,
                            label: listItems[index].todoText,
                            onDelete: (_index) {
                              setState(() {
                                removeItem(_index);
                              });
                            },
                            index: index,
                            onSelection: (_index) {
                              print({_index, '_'});
                              print({index, 'index'});
                              setState(() {
                                toggleItemSelection(index);
                              });
                            }),
                        key: Key(listItems[index].todoText + index.toString()),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listItems.length,
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        reorderItem(oldIndex, newIndex);
                      });
                    },
                    buildDefaultDragHandles: false,
                  ),
                  key: Key('expanded'))
            ]));
  }
}
