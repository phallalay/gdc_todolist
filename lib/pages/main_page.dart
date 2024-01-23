import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdc_todolist/common/app_colors.dart';
import 'package:gdc_todolist/pages/all_list.dart';
import 'package:gdc_todolist/pages/done_list.dart';
import 'package:gdc_todolist/services/todo_service.dart';

import '../event/events.dart';
import '../model/todo.dart';
import 'home.dart';

class MainPage extends StatefulWidget {
  late int currentIndex;
  MainPage({super.key, required this.currentIndex});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late TextEditingController todoTitleController;
  late TextEditingController toDescriptionController;

  var containerKey = GlobalKey();
  var tapPosition = const Offset(0, 0);

  var currentMenuIndex = 0;

  final List<Widget> _childPages = <Widget>[];
  final homePage = const HomePage();
  final allListPage = const AllListPage();
  final doneListPage = const DoneListPage();

  double get width => MediaQuery.of(context).size.width;

  @override
  void initState() {
    _childPages.add(homePage);
    _childPages.add(allListPage);
    _childPages.add(doneListPage);

    menuIndexNotifier.value = widget.currentIndex;

    super.initState();

    todoTitleController = TextEditingController();
    toDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    todoTitleController.dispose();
    toDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.primary(),
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text(
          'My ToDo List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: IndexedStack(index: currentMenuIndex, children: _childPages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appColors.primary(),
        currentIndex: currentMenuIndex,
        selectedItemColor: appColors.secondary(),
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_sharp),
            label: 'Active',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_sharp),
            label: 'Complete',
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentMenuIndex = index;
            menuIndexNotifier.value = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColors.primary(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  _addTodo() {
    final dialogWidth = width > 340.0 ? 340.0 : width - 20;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            titlePadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 30),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "New Todo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Container(
                width: dialogWidth,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Title'),
                      CupertinoTextField(
                        controller: todoTitleController,
                        placeholder: 'Todo...',
                      ),
                      const SizedBox(height: 10),
                      const Text('Description'),
                      CupertinoTextField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 4,
                        controller: toDescriptionController,
                        placeholder: '',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        appColors.primary())),
                            child: const Text('Create'),
                            onPressed: () async {
                              String timeStamp =
                                  DateTime.now().toIso8601String();
                              final todo = Todo(
                                  title: todoTitleController.text,
                                  description: toDescriptionController.text,
                                  status: TodoStatus.NEW,
                                  createdAt: timeStamp,
                                  updatedAt: timeStamp);
                              await TodoService().insertTodo(todo);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MainPage(currentIndex: 0)));

                              const snackBar = SnackBar(
                                content: Text("Task Created"),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          ),
                        ],
                      ),
                    ])),
          );
        });
  }
}
