class ListItem {
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck);
}

class TodoList {
  late String listTitle;
  late List<ListItem> listItems;
}

List<ListItem> widgetList = [];

List<TodoList> todoLists = [];
