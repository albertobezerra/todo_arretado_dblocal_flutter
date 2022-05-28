import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _toDoController = TextEditingController();
  List _toDoList = [];
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;

  bool validacao = true;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data!);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = _toDoController.text;
      _toDoController.text = '';
      newToDo['ok'] = false;
      _toDoList.add(newToDo);
      if (_toDoController.text.isNotEmpty) {}
      _refresh();
      _saveData();
      Navigator.pop(context);
    });
  }

  Future<Null> _refresh() async {
    // await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a['ok'] && !b['ok'])
          return 1;
        else if (!a['ok'] && b['ok'])
          return -1;
        else
          return 0;
      });
      _saveData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vai te ocupar!',
                style: GoogleFonts.fugazOne(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              Text(
                'Porque em terra de pobre, o que cai do ceú é chuva e bosta de passarinho! E isso não paga as contas!',
                style: GoogleFonts.fugazOne(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  // padding: EdgeInsets.only(top: 10),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem,
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.black87,
                title: Row(
                  children: [
                    Text(
                      'Tá olhando o que?',
                      style: GoogleFonts.fugazOne(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.cancel,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                children: [
                  TextField(
                    controller: _toDoController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: Colors.pink,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.pink),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Digita logo, antes que esqueça!',
                      labelStyle: TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Tem que apertar aqui!'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.black,
                        onPressed: () {
                          if (_toDoController.text.isEmpty) {
                            setState(() {
                              validacao = false;
                            });
                          } else {
                            _addToDo();
                          }
                        }),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      background: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(top: 10),
        color: Color(0xFF838383),
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(top: 10),
        color: Theme.of(context).primaryColor,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(
        //     color: Theme.of(context).primaryColor,
        //     width: 2,
        //   ),
        // ),
        child: CheckboxListTile(
          title: Text(
            _toDoList[index]['title'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          value: _toDoList[index]['ok'],
          // secondary: CircleAvatar(
          //   backgroundColor: Theme.of(context).primaryColor,
          //   child: Icon(
          //     _toDoList[index]['ok'] ? Icons.check : Icons.error,
          //     color: Colors.white,
          //   ),
          // ),
          onChanged: (bool? c) {
            setState(() {
              _toDoList[index]['ok'] = c;
              _refresh();
              _saveData();
            });
          },

          checkColor: Colors.white,
          side: BorderSide(
            color: Colors.white,
          ),
          activeColor: Colors.pink,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content:
                Text('Terminasse isso \'${_lastRemoved['title']}\' mesmo?'),
            action: SnackBarAction(
                label: 'Terminei não',
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
