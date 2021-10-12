import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/animationRoutes.dart';
import 'package:chimbi/views/register/emailScreen.dart';
import 'package:chimbi/views/register/lastNameScreen.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  final bool isColaborator;
  const NameScreen({Key? key,required this.isColaborator}) : super(key: key);

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController= TextEditingController();
  bool existName=false;

  @override
  void initState() {
    print(widget.isColaborator);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: GestureDetector(
            onTap: (){
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
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isColaborator?Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                        child: GestureDetector(child: Icon(Icons.arrow_back,color: darkGreyChimbi,size: 30,),onTap: (){
                          Navigator.pop(context);
                        },),
                      ):Spacer(),
                      widget.isColaborator?Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("INGRESA A TU\nCOLABORADOR",style: TextStyle(
                            fontFamily: 'Dense',
                            color: darkGreyChimbi,
                            fontSize: 45,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2),textAlign: TextAlign.left,),
                      ):Container(height: 10,),
                      widget.isColaborator?Spacer():Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0,left: 40,right:40),
                        child: Center(
                          child: TextField(
                            controller: nameController,
                            onChanged: (text){
                              setState(() {
                                if(text.isNotEmpty){
                                  existName=true;
                                }else{
                                  existName=false;
                                }
                              });
                            },
                            style: TextStyle(
                                fontFamily: 'Dense',
                                color: darkGreyChimbi,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                            decoration: InputDecoration(
                                focusColor: blueChimbi,
                                hintText: 'Nombre',
                            ),
                          )
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 40,left: 15,right: 15),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if(nameController.text.isNotEmpty){
                                   Navigator.push(context, FadeRoute(page: EmailScreen(isColaborator: widget.isColaborator,)));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14,horizontal: 100),
                                decoration: BoxDecoration(
                                  color: existName?Colors.black:mediumGreyChimbi,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text("SIGUIENTE",style: TextStyle(
                                    fontFamily: 'Dense',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2),
                                  textAlign: TextAlign.center,
                                ),),
                            ),
                          )
                      ),
                      widget.isColaborator?Padding(
                          padding: EdgeInsets.only(top: 10,left: 15,right: 15),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14,horizontal: 110),
                                decoration: BoxDecoration(
                                  color: blueChimbi,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text("OMITIR",style: TextStyle(
                                    fontFamily: 'Dense',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2),
                                  textAlign: TextAlign.center,
                                ),),
                            ),
                          )
                      ):Container(),
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
