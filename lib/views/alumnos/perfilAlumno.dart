import 'dart:convert';

import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/models/curso.dart';
import 'package:chimbi/reusable/configs.dart';
import 'package:chimbi/services/googleServices.dart';
import 'package:chimbi/views/alumnos/cursoVista.dart';
import 'package:chimbi/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class PerfilAlumno extends StatefulWidget {
  const PerfilAlumno({Key? key}) : super(key: key);

  @override
  _PerfilAlumnoState createState() => _PerfilAlumnoState();
}

class _PerfilAlumnoState extends State<PerfilAlumno> {
  List<Curso> cursos = [];
  GoogleSignInAccount? _currentUser;
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

  checkIsiPad() async {
    bool checkSize = await Config().isIpad();
    setState(() {
      isiPad = checkSize;
    });
  }

  getCursos({required GoogleSignInAccount? user}) async {
    List<Curso> resp = await getTeacherCourses(user: user);
    setState(() {
      cursos = resp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsiPad();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        getCursos(user: _currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  Widget mobileProfile() {
    return ListView(
      children: [Text(email), Text(displayName), Image.network(photoUrl)],
    );
  }

  Widget ipadProfile() {
    return ListView(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://static.wixstatic.com/media/c40e72_a006870cc3b043e3b4fe5e8b7bdb6272~mv2.jpg/v1/fill/w_1080,h_589,al_c,q_85/c40e72_a006870cc3b043e3b4fe5e8b7bdb6272~mv2.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.grey[900]!.withOpacity(0.6), BlendMode.darken),
            ),
          ),
//              color: Colors.grey[900],
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: photoUrl.isNotEmpty,
                child: Container(
                  // width:200,
                  margin: EdgeInsets.all(3),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: lightGreyChimbi,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  displayName.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Dense',
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  role.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Dense',
                      color: Colors.grey[300],
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 700,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CursoVista(curso: cursos[index]),
                        ));
                  },
                  child: ListTile(
                    title: Text(cursos[index].name.toUpperCase()),
                    subtitle: Text(cursos[index].section.toUpperCase()),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: lightGreyChimbi,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Future<void> _handleSignOut() => _googleSignIn.signOut();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: CupertinoPageScaffold(
          child: GestureDetector(
            child: isiPad ? ipadProfile() : mobileProfile(),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
          backgroundColor: Colors.grey[100],
          navigationBar: CupertinoNavigationBar(
            backgroundColor: blueChimbi,
            leading: Container(),
            trailing: Material(
              color: Colors.transparent,
              child: GestureDetector(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () {
                  _handleSignOut();
                  setState(() {
                    displayName = "";
                    email = "";
                    photoUrl = "";
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
