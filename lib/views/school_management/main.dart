import 'dart:io';

import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/animationRoutes.dart';
import 'package:chimbi/views/school_management/generalConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum icons {
  config,
  semestres,
  grupos,
  estadiscticas,
  evaluacion,
  horarios,
  entregables,
  formulario
}

class MainManagement extends StatefulWidget {
  const MainManagement({Key? key}) : super(key: key);

  @override
  _MainManagementState createState() => _MainManagementState();
}

class _MainManagementState extends State<MainManagement> {
  List menuOptions = [
    "Configuración General",
    "Configuración de semestres",
    "CONFIGURACIÓN DE GRUPOS",
    "LISTAS Y ESTADÍSTICAS",
    "EVALUACIÓN DE DOCENTES",
    "HORARIOS",
    "ENTREGABLES",
    "FORMULARIO DE INFORME/ADMISIÓN"
  ];

int lastOptionSelected=-1;
bool gridView = true;


  IconMenu(int index,double size){
    String enumName = icons.values[index].toString();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ImageIcon(AssetImage("images/icons/${getIconName(enumName)}.png"),size:size, color: index==lastOptionSelected?blueChimbi:Colors.black,),
    );
  }
  
  String getIconName(String iconName){
    return iconName.substring(iconName.indexOf('.')+1,iconName.length);
  }

  listMenu(){

    return [

    ];
  }
  selectOption(int index){
    setState(() {
      lastOptionSelected=index;
    });

    switch(index){
      case 0:
        Navigator.push(context,MaterialPageRoute(builder: (_) => const GeneralConfig()));
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
        ),
            child: Material(
              child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15),
                                  child: GestureDetector(
                                    child: Icon(Icons.supervised_user_circle_outlined),
                                ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15),
                                  child: ImageIcon(
                                    AssetImage("images/icons/logo.png"),
                                    size: 90,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15),
                                  child: GestureDetector(
                                      onTap: (){
                                          setState(() {
                                            gridView=!gridView;
                                          });
                                      },
                                    child: ImageIcon(
                                      gridView?AssetImage("images/icons/menu lista.png"):AssetImage("images/icons/menu iconos.png"),
                                      color: blueChimbi,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 10,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                                child: gridView?GridView.count(
                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisCount: 2,
                                  shrinkWrap: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1.25,
                                  // Generate 100 widgets that display their index in the List.
                                  children:
                                      List.generate(menuOptions.length, (index) {
                                    return GestureDetector(
                                      onTap: (){
                                        selectOption(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color:mediumGreyChimbi)
                                        ),
                                        child: Column(
                                          children: [
                                            IconMenu(index,50),
                                            Text(
                                              menuOptions
                                                  .elementAt(index)
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontFamily: 'Dense',
                                                  color: darkGreyChimbi,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ):ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: menuOptions.length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return  GestureDetector(
                                        onTap: (){
                                          selectOption(index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: mediumGreyChimbi, width: 1)),
                                          ),
                                          child: Row(
                                            children: [
                                              IconMenu(index,25),
                                              SizedBox(width: 10,),
                                              Flexible(
                                                child: Text(
                                                  menuOptions
                                                      .elementAt(index)
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: 'Dense',
                                                      color: mediumGreyChimbi,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 1),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ),
                          ),
                          Spacer(),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
          );
  }
}
