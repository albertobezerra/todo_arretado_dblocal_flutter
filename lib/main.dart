import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:todo_arretado_dblocal/splash.dart';

String get bannerAdUnitId {
  /// Always test with test ads
  if (kDebugMode) {
    return MobileAds.bannerAdTestUnitId;
  } else {
    return 'ca-app-pub-7979689703488774/3276055906';
  }
}

// Para atualizar o readme

Future<void> main() async {
  await MobileAds.initialize(
    bannerAdUnitId: bannerAdUnitId,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Spalsh(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 64, 255, 182),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}
