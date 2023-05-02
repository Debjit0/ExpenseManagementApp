import 'package:flutter/material.dart';
import 'package:mini_proj_expense_2/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './pages/splash.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(const MyApp());
}
//gjgjgjgjg

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
    );
  }
}




//8611
