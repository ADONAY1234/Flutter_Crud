import 'package:crud_prueba/controllers/student_controller.dart';
import 'package:crud_prueba/models/student_model.dart';
import 'package:crud_prueba/screens/students.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../components/myinputextfield.dart';

class Add_Edit_Student extends StatefulWidget {
  final studentModel? studentmodel;
  final index;

  const Add_Edit_Student({this.studentmodel, this.index});

  @override
  State<Add_Edit_Student> createState() => _Add_Edit_StudentState();
}

class _Add_Edit_StudentState extends State<Add_Edit_Student> {
  bool isEdited_mode = false;

  final _form_key = GlobalKey<FormState>();
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController id = TextEditingController();

  AddStudent(studentModel studentModel) async{
    await StudentController().addStudent(studentModel).then((Success) => {

      //Con esto siguiente podré mostrar un pequeño mensaje que el 
      //estudiante fue creado con éxito
      FlutterToastr.show("El Estudiante fue creado", context,
      duration: FlutterToastr.lengthLong,
      position: FlutterToastr.center,
      backgroundColor: Colors.green
      ),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => StudentsPage()))),
    });
  }


  UpdateStudent(studentModel studentModel) async {
    await StudentController().UpdateStudent( studentModel).then((Success) => {

      //Con esto siguiente podré mostrar un pequeño mensaje que el 
      //estudiante fue creado con éxito
      FlutterToastr.show("El Estudiante fue actualizado", context,
      duration: FlutterToastr.lengthLong,
      position: FlutterToastr.center,
      backgroundColor: Colors.green
      ),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => StudentsPage()))),
    })
    .onError((error, stackTrace) => {
       FlutterToastr.show("Estudiante No Actualizado", context, 
      duration: FlutterToastr.lengthLong,
      position: FlutterToastr.center,
      backgroundColor: Colors.red
       )
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.index != null) {
      isEdited_mode = true;
      Name.text=widget.studentmodel?.Name;
      Email.text=widget.studentmodel?.Email;
      Address.text=widget.studentmodel?.Address;
      id.text=widget.studentmodel?.id;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        isEdited_mode ? "Actualizar Usuario" : "Agregar Usuario"), centerTitle: true,
      ),
      body: SingleChildScrollView(child: Column(children: [
        SizedBox(height: 30.0),

        Center(
          child: Text(
            "Registrar Usuario",
            style: TextStyle(fontSize: 30.0),
          ),
        ),

        SizedBox(height: 30.0),

        Form(
          key: _form_key,
          child: Column(children: [
         MyTextFields(hintedtext: "Full Name", labeltext: "Name", Inputcontroller: Name),
          SizedBox(height: 10.0,),
         MyTextFields(hintedtext: "Example@gmail.com", labeltext: "Email", Inputcontroller: Email),
          SizedBox(height: 10.0,),
         MyTextFields(hintedtext: "Col. example, casa #...", labeltext: "Address", Inputcontroller: Address),
          SizedBox(height: 10.0,),
         ],
          )),

          ElevatedButton(
            
            style: ElevatedButton.styleFrom(fixedSize: Size(300.0, 60),
            elevation: 20.0,
            ),
            onPressed: () {

              if(isEdited_mode == true){
                if(_form_key.currentState!.validate()) {
                studentModel studenModel = studentModel(
                  id: id.text,
                  Name: Name.text,
                  Email: Email.text,
                  Address: Address.text
                );
                UpdateStudent(studenModel);
                Name.clear();
                Email.clear();
                Address.clear();
              }

            } else {
              if(_form_key.currentState!.validate()) {
                studentModel studenModel = studentModel(
                  Name: Name.text,
                  Email: Email.text,
                  Address: Address.text
                );
                AddStudent(studenModel);
                Name.clear();
                Email.clear();
                Address.clear();
              }
            }
          },
           child: Text(
        isEdited_mode ? " Actualizar" : "Agregar"))
        ],
      )),
    );
  }
}