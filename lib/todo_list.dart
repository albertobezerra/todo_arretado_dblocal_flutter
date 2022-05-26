import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

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
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Divider(),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle),
                    ),
                    title: Text(
                      'Tarefa',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              )
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
                title: Row(
                  children: [
                    Text('Add ToDo'),
                    Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                children: [
                  TextField(
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.pink,
                    ),
                    decoration: InputDecoration(
                        hintText: "Escreva aqui!",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('add'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
