
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crud_prueba/models/student_model.dart';


class StudentController{


      static const VIEW_URL = "http://192.168.0.5/students%20api/view.php";
      static const CREATE_URL = "http://192.168.0.5/students%20api/create.php";
      static const DELETE_URL = "http://192.168.0.5/students%20api/delete.php";
      static const UPDATE_URL = "http://192.168.0.5/students%20api/update.php";


  List<studentModel> studentsFromJson(String jsonstring) {
    final data = json.decode(jsonstring);

    return List<studentModel>.from(data.map((item)=> studentModel.fromJson(item) ));
  }

  Future<List<studentModel>> getStudents()  async{
    String view_ip = "http://192.168.0.5/students%20api/view.php";
    final response = await http.get(Uri.parse(VIEW_URL));
    if(response.statusCode == 200){
      List<studentModel> list =studentsFromJson(response.body);
      return list;

    }else{
      return <studentModel>[];
    }
  }

// Agregar Estudiante
  Future<String> addStudent(studentModel studentModel) async{
    final response = await http.post(Uri.parse(CREATE_URL), body: studentModel.toJsonAdd());
    if(response.statusCode == 200){
      return response.body;
    } else {
      return "Error";
    }
  }

// Editar Estudiante
  Future<String> UpdateStudent(studentModel studentModel) async {
    final response = await http.post(Uri.parse(UPDATE_URL), body: studentModel.toJsonDelete_and_update());
     if(response.statusCode == 200){
      return response.body;
    } else {
      return "Error";
    }

  }

// Eliminar Estudiante
  Future<String> DeleteStudent(studentModel studentModel) async {
    final response = await http.post(Uri.parse(DELETE_URL), body: studentModel.toJsonDelete_and_update());
     if(response.statusCode == 200){
      return response.body;
    } else {
      return "Error";
    }

  }

}
