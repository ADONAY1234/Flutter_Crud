import 'dart:async';

import 'package:crud_prueba/screens/add_or_edit_student.dart';
import 'package:flutter/material.dart';
import 'package:crud_prueba/models/student_model.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import '../controllers/student_controller.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {

  List<studentModel> studentlist = [];

  StreamController _streamController = StreamController();

  Future getAllStudents() async {
    studentlist = await StudentController().getStudents();

    _streamController.sink.add(studentlist);
  }

//delete student
  deleteStudent(studentModel studentModel) async{
    await StudentController().DeleteStudent(studentModel).then((Success) => {
      FlutterToastr.show("Estudiante Eliminado", context, 
      duration: FlutterToastr.lengthLong,
      position: FlutterToastr.center,
      backgroundColor: Colors.green
      )
    })
    
    .onError((error, stackTrace) => {
       FlutterToastr.show("Estudiante No Eliminado", context, 
      duration: FlutterToastr.lengthLong,
      position: FlutterToastr.center,
      backgroundColor: Colors.red
       )
    });
  }


  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      getAllStudents();
     });
     super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton( onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Add_Edit_Student())));
      }, child: Icon(Icons.add),),
      appBar: AppBar(title: Text("Flutter Aplication")),
      body: SafeArea(
          child: StreamBuilder(stream: _streamController.stream,
          builder: (context, snapshots){

              if(snapshots.hasData) {
                 return ListView.builder(
                  itemCount: studentlist.length,
                  
                  itemBuilder: ((context, index) { 
                  studentModel student = studentlist[index];
                  return ListTile(
                    onTap:() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Add_Edit_Student(
                        studentmodel: student,
                        index: index,
                      )))); 
                      
                    },
                    leading: CircleAvatar(child: Text(student.Name[0])),
                    title: Text(student.Name),
                    subtitle: Text(student.Email),
                    trailing: IconButton(onPressed: (){
                      deleteStudent(student);
                    },
                     icon: Icon(Icons.delete_outline, color: Colors.red,),),
                  );
                 
              }));
              }
                  return Center(
                    child: CircularProgressIndicator(),
              );
           
          },
        ),
      ),
    );
  }
}