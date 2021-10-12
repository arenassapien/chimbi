import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/animationRoutes.dart';
import 'package:flutter/material.dart';

class LastNameScreen extends StatefulWidget {
  const LastNameScreen({Key? key}) : super(key: key);

  @override
  _LastNameScreenState createState() => _LastNameScreenState();
}

class _LastNameScreenState extends State<LastNameScreen> {
  TextEditingController lastNameController= TextEditingController();
  bool existName=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
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
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0,left: 40,right:40),
                      child: Center(
                        child: TextField(
                          controller: lastNameController,
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
                              hintText: 'Apellidos',
                          ),
                        )
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 15),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if(lastNameController.text.isNotEmpty){
                                 //Navigator.push(context, FadeRoute(page: NameScreen()));
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
                    Spacer(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
