import 'package:chimbi/models/permission.dart';
import 'package:chimbi/reusable/Constants.dart';
import 'package:flutter/material.dart';

class SuccessRegister extends StatefulWidget {
  final isColaborator;
  const SuccessRegister({Key? key, required this.isColaborator})
      : super(key: key);

  @override
  _SuccessRegisterState createState() => _SuccessRegisterState();
}

class _SuccessRegisterState extends State<SuccessRegister> {
  List<Permission> permission = [];
  List<bool> arraySelected=[];

  getPermissions() async {
    List<Permission> permissionTmp = [
      Permission(permissionModule: "Configuración de semestres", permissions: [
        "Dar de alta las materias que llevan en cada semestre",
        "Determinar el número de horas por clase por semana para cada materia",
        "Seleccionar si la calificación se promedia o no",
        "Seleccionar si la materia es obligatoria, optativa, opcional o extracurricular",
        "Salen los niveles de inglés para que los palomees los que van en el semestre específico"
      ],
      ),
      Permission(permissionModule: "Configuración de grupos", permissions: [

      ]),
      Permission(permissionModule: "Listas y estadisticas", permissions: [

      ]),
      Permission(permissionModule: "Evaluación de docentes", permissions: [

      ]),
      Permission(permissionModule: "Horarios", permissions: [

      ]),
      Permission(permissionModule: "Entregables", permissions: [

      ]),
      Permission(permissionModule: "Formularios de informe/admisión", permissions: [

      ]),
    ];

    setState(() {
      permission = permissionTmp;
    });

  }

  List<Widget> optionsModule(int module){
    List<Widget> array=[];

    for(String perm in permission[module].permissions){
      arraySelected.add(false);
      var listTile= GestureDetector(onTap:(){
        setState(() {
          arraySelected[permission[module].permissions.indexOf(perm)]= !arraySelected[permission[module].permissions.indexOf(perm)];
        });
      },child: ListTile(
        leading: !arraySelected[permission[module].permissions.indexOf(perm)]?Icon(Icons.radio_button_unchecked,color: blueChimbi,):Icon(Icons.check_circle,color: blueChimbi,),
        title: Text(perm, style: TextStyle(
            fontFamily: 'Dense',
            color: darkGreyChimbi,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2),textAlign: TextAlign.left,),
      ));
      array.add(listTile);
    }

    return array;
  }

  @override
  void initState() {
    // TODO: implement initState

    getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: darkGreyChimbi,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "ACCESOS\nPERMITIDOS",
                          style: TextStyle(
                              fontFamily: 'Dense',
                              color: darkGreyChimbi,
                              fontSize: 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ExpansionTile(
                        backgroundColor: lightGreyChimbi,
                        collapsedTextColor: darkGreyChimbi,
                        textColor: darkGreyChimbi,
                        collapsedBackgroundColor: lightGreyChimbi,

                        tilePadding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                        title: Text(
                          permission[0].permissionModule,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w800,color: darkGreyChimbi),
                        ),
                        children: optionsModule(0)
                      ),
                      Spacer(),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 100),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "SIGUIENTE",
                                  style: TextStyle(
                                      fontFamily: 'Dense',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 2),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
