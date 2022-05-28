import 'package:flutter/material.dart';
import 'package:todo_arretado_dblocal/todo_list.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoList(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 64, 255, 182),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}
