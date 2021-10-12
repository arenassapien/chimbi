import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/animationRoutes.dart';
import 'package:chimbi/views/register/phoneScreen.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  final bool isColaborator;
  const EmailScreen({Key? key,required this.isColaborator}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {

  TextEditingController emailController= TextEditingController();

  bool existsEmail=false;
  bool validEmail=false;

  @override
  void initState() {
    print(widget.isColaborator);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async{
          return false;
        },
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
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0,left: 40,right:40),
                        child: Center(
                          child: TextField(
                            controller: emailController,
                            onChanged: (text){
                              setState(() {
                                if(text.isNotEmpty){
                                  existsEmail=true;
                                }else{
                                  existsEmail=false;
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
                                hintText: 'Correo electrónico',
                            ),
                          )
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 15),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if(emailController.text.isNotEmpty){
                                   Navigator.push(context, FadeRoute(page: PhoneScreen(isColaborator:widget.isColaborator)));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14,horizontal: 100),
                                decoration: BoxDecoration(
                                  color: existsEmail?Colors.black:mediumGreyChimbi,
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
      ),
    );
  }
}
