import 'dart:io';

import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/models/alumno.dart';
import 'package:chimbi/models/curso.dart';
import 'package:chimbi/services/googleServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AlumnoClase extends StatefulWidget {
  final Curso curso;
  const AlumnoClase({Key? key, required this.curso}) : super(key: key);

  @override
  _AlumnoClaseState createState() => _AlumnoClaseState();
}

class _AlumnoClaseState extends State<AlumnoClase> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/classroom.courses',
      'https://www.googleapis.com/auth/classroom.coursework.me',
      'https://www.googleapis.com/auth/classroom.coursework.students',
      'https://www.googleapis.com/auth/classroom.profile.emails',
      'https://www.googleapis.com/auth/classroom.student-submissions.me.readonly',
      'https://www.googleapis.com/auth/classroom.rosters',
      'https://www.googleapis.com/auth/classroom.rosters.readonly',
      'https://www.googleapis.com/auth/classroom.profile.emails',
      'https://www.googleapis.com/auth/classroom.profile.photos'
    ],
  );
  List<Alumno> alumnos = [];
  GoogleSignInAccount? _currentUser;

  obtenerAlumnos({required int courseId}) async {
    List<Alumno> resp =
        await getStudentsFromCourse(courseId: courseId, user: _currentUser);
    setState(() {
      alumnos = resp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.courseId);
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        obtenerAlumnos(courseId: widget.curso.id);
      }
    });
    _googleSignIn.signInSilently();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: blueChimbi,
          previousPageTitle: "Clases",
          middle: Text(
            widget.curso.name.toString() + " - " + widget.curso.section,
            style: TextStyle(color: Colors.white),
          ),
        ),
        child: alumnos.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: alumnos.length,
                itemBuilder: (context, index) {
                 
                 bool hasphoto = !alumnos[index].profile.photoUrl.contains("photo.jpg");
      //print(hasphoto);

                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      leading: Container(
                        // width:200,
                        margin: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: blueChimbi,
                          child: CircleAvatar(
                            radius: 20,
                            child: hasphoto?Container(width: 0,):Image.asset("images/appLogos/chimbi_profile.png"),
                            backgroundImage:hasphoto?NetworkImage("https:"+alumnos[index].profile.photoUrl):null
                          ),
                        ),
                      ),
                      title:
                          Text(alumnos[index].profile.fullName.toUpperCase()),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: lightGreyChimbi,
                      ),
                    ),
                  );
                })
            : Container(
                child: Center(
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator(
                            radius: 20,
                          )
                        : CircularProgressIndicator(
                            color: lightGreyChimbi,
                          )),
              ));
  }
}
