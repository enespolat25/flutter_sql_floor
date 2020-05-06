import 'package:floor/floor.dart';
import 'db/database.dart';
import 'model/Student.dart';
import 'package:flutter/material.dart';
import 'db/dao/StudentDao.dart';



class HomeScreen extends StatefulWidget {
  final StudentDao studentDao;
  HomeScreen(this.studentDao);

  @override
  _HomeScreenState createState() => _HomeScreenState(studentDao);
}

class _HomeScreenState extends State<HomeScreen> {

   String _name;

   String _school;

   Student student;

   List<Student> listStudent;

   final formKey = GlobalKey<FormState>();

   StudentDatabase  studentDatabase;
   StudentDao studentDao;

  _HomeScreenState(this.studentDao);



   builder()async{
     studentDatabase =  await $FloorStudentDatabase.databaseBuilder('student.db').build();

     setState(() {

       studentDao = studentDatabase.studentDao;

     });

   }
   @override
  void initState() {
    super.initState();
    builder();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor SQL Kütüphanesi'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blueAccent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))
                      ),
                      labelText: 'İsminizi yazınız',
                      fillColor: Colors.blueAccent,
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'İsminiz',
                    ),
                    onSaved: (input) => _name=input,
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blueAccent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))
                      ),
                      labelText: 'Okulunuzu belirtiniz',
                      fillColor: Colors.blueAccent,
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Okulunuz',
                    ),
                    onSaved: (input) => _school =input,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onDoubleTap: (){
              listStudent.removeLast();
            },
            child: RaisedButton(
              color: Colors.blueAccent,
              child: Text('Kaydet',style: TextStyle(color: Colors.white),),
              onPressed: ()  {
                formKey.currentState.save();
                String name =  _name;
                String school = _school;
                print(listStudent);

                var patient = Student(name: name, school: school);
                studentDao.insertStudent(patient);
                 formKey.currentState.reset();

              },
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder<List<Student>>(
                stream: studentDao.findAllStudentsAsStream(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return Container();

                final students = snapshot.data;
                print(snapshot.data);

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(students[index].name),
                      subtitle: Text(students[index].school),
                      onLongPress: (){
                        int id = students[index].id;
                        var patient = Student(id: id);
                        print(students[index].name);
                        studentDao.deleteStudent(patient);
                      },
                    );
                  },
                );
              },
          ),
          ),
        ],
      ),
    );
  }
}
