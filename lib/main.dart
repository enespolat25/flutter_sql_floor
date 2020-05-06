import 'db/dao/StudentDao.dart';
import 'db/database.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';
void main() async{

    WidgetsFlutterBinding.ensureInitialized();

    final studentDatabase = await $FloorStudentDatabase
        .databaseBuilder('student.db')
        .build();

    final studentDao = studentDatabase.studentDao;
    runApp(MyApp(studentDao));

  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final StudentDao studentDao;
  const MyApp(this.studentDao);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomeScreen(studentDao),
    );
  }
}


