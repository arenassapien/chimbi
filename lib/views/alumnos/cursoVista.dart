import 'dart:io';

import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/models/curso.dart';
import 'package:chimbi/views/alumnos/alumnosClase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CursoVista extends StatefulWidget {
  final Curso curso;
  const CursoVista({Key? key, required this.curso}) : super(key: key);

  @override
  _CursoVistaState createState() => _CursoVistaState();
}

class _CursoVistaState extends State<CursoVista> {
  int currentTabIndex = 0;

  Widget getTab(int indexTab) {
    if (indexTab == 0) {
      return AlumnoClase(curso: widget.curso);
    } else {
      return Container(
        child: Center(
          child: Text("CONFIGURACIÓN"),
        ),
      );
    }
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  Widget mobileCourse() {
    return ListView(
      children: [Text(email), Text(displayName), Image.network(photoUrl)],
    );
  }

  Widget ipadCourse() {
    return ListView(
      children: [
        Container(
//              color: Colors.grey[900],
          padding: EdgeInsets.symmetric(vertical: 20),
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.curso
                  .name.toString(),
              style: TextStyle(
                  fontFamily: 'Dense',
                  color: Colors.grey[300],
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Material(
          child: CupertinoTabScaffold(

              tabBar: CupertinoTabBar(items: [

                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_3_fill), label: "Alumnos",),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings), label: "Configuración"),
              ]),
              tabBuilder: (context, indice) {
                return getTab(indice);
              },
            ),
        )
        : Scaffold(
            appBar: AppBar(
              title: Text("Alumnos"),
            ),
            // Body Where the content will be shown of each page index
            body: getTab(currentTabIndex),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentTabIndex,
                onTap: onTapped,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_3_fill), label: "Alumnos"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.settings), label: "Configuración"),
                ]),
          );
  }
}
