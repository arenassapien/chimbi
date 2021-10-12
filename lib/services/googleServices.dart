import 'dart:convert';

import 'package:chimbi/models/alumno.dart';
import 'package:chimbi/models/curso.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

Future<List<Curso>> getTeacherCourses({required GoogleSignInAccount? user})  async {
  late List<Curso> resp;
  final http.Response response = await http.get(
    Uri.parse(
        'https://classroom.googleapis.com/v1/courses?courseStates=ACTIVE&teacherId=me'),
    headers: await user!.authHeaders,
  );
  if (response.statusCode != 200) {
    print('People API ${response.statusCode} response: ${response.body}');
    return [];
  }
  try{
    final Map<String, dynamic> data = json.decode(response.body);
   resp = (data["courses"] as List)
        .map((p) => Curso.fromJson(p))
        .toList();

  }catch(e){
    print(e);
    resp=[];
  }
  return resp;
}

Future<List<Alumno>> getStudentsFromCourse({required int courseId,required GoogleSignInAccount? user})  async {
  late List<Alumno> resp;
  final http.Response response = await http.get(
    Uri.parse(
        'https://classroom.googleapis.com/v1/courses/'+courseId.toString()+'/students'),
    headers: await user!.authHeaders,
  );
  if (response.statusCode != 200) {
    print('People API ${response.statusCode} response: ${response.body}');
    return [];
  }
  try{
    final Map<String, dynamic> data = json.decode(response.body);
    //print(data);
    resp = (data["students"] as List)
        .map((p) => Alumno.fromJson(p))
        .toList();

  }catch(e){
    print(e);
    resp=[];
  }
  return resp;
}