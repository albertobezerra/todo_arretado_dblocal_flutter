import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_arretado_dblocal/todo_list.dart';

class Spalsh extends StatelessWidget {
  const Spalsh({Key? key}) : super(key: key);

  void requeridoPermissao() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var status2 = await Permission.manageExternalStorage.status;
    if (!status2.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2020/04/02/22/05/home-office-4996834_960_720.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 64, 255, 182).withOpacity(.9),
                Color.fromARGB(255, 64, 255, 182).withOpacity(.8),
                Color.fromARGB(255, 64, 255, 182).withOpacity(.2),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    'Uma lista de tarefa mal humorada!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fugazOne(
                      color: Colors.white,
                      fontSize: 37,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      requeridoPermissao();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => TodoList()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Clica logo!".toUpperCase(),
                        style: GoogleFonts.fugazOne(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
