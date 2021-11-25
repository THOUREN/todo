import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  String enteredData = '';
  List todoList = [
    'G',
    'S',
    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  ];
  Color orColor = Colors.blueAccent;
  List colors = [Colors.blueAccent, Colors.blueAccent, Colors.blueAccent];
  final c = Color.fromARGB(Random().nextInt(256), Random().nextInt(256),
      Random().nextInt(256), Random().nextInt(256));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: Scrollbar(
          isAlwaysShown: true,
          child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(todoList[index]),
                  child: Card(
                    child: cont(index),
                    /*child: ListTile(
                      title: Text(todoList[index]),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            todoList.removeAt(index);
                            colors.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ),*/
                    color: colors[index],
                  ),
                  background: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 50,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    color: Colors.green,
                  ),
                  onDismissed: (direction) {
                    //if (direction == DismissDirection.startToEnd)
                    Color col = colors[index];
                    setState(() {
                      todoList.removeAt(index);
                      colors.removeAt(index);
                    });
                  },
                );
                /*Padding(
                    padding: const EdgeInsets.all(15.0), child: cont(index));*/
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Добавить заметку'),
                  content: TextFormField(
                      autofocus: true,
                      onChanged: (String value) {
                        enteredData = value;
                      }),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (enteredData != '') {
                              todoList.add(enteredData);
                              colors.add(Color.fromARGB(
                                  150,
                                  0 + Random().nextInt(156),
                                  100 + Random().nextInt(156),
                                  255));
                            }
                            enteredData = '';
                          });

                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.check)),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cont(_index) {
    return FlatButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Добавить заметку'),
                  content: TextFormField(
                      initialValue: todoList[_index],
                      autofocus: true,
                      onChanged: (String value) {
                        enteredData = value;
                      }),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (enteredData != '') {
                              todoList[_index] = enteredData;
                            }
                            enteredData = '';
                          });

                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.check)),
                  ],
                );
              });
        },
        child: Container(
            height: 100,
            color: colors[_index],
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                todoList[_index],
                                style: TextStyle(fontSize: 30),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ]),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  todoList.removeAt(_index);
                                  colors.removeAt(_index);
                                });
                              },
                              child: Icon(Icons.delete),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ))));
  }
}
