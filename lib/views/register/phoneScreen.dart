import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/animationRoutes.dart';
import 'package:chimbi/views/register/emailScreen.dart';
import 'package:chimbi/views/register/nameScreen.dart';
import 'package:chimbi/views/register/successRegister.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  final bool isColaborator;
  const PhoneScreen({Key? key,required this.isColaborator}) : super(key: key);

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController extController = TextEditingController();
  bool existsPhone = false;
  @override
  void initState() {
    print(widget.isColaborator);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
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
                  children: [
                    Spacer(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 40, right: 40),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              onChanged: (text) {
                                setState(() {
                                  if (text.isNotEmpty) {
                                    existsPhone = true;
                                  } else {
                                    existsPhone = false;
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
                                hintText: 'Teléfono',
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: extController,
                              onChanged: (text) {
                                setState(() {
                                  if (text.isNotEmpty) {
                                    existsPhone = true;
                                  } else {
                                    existsPhone = false;
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
                                hintText: 'Extensión',
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (phoneController.text.isNotEmpty ) {
                                if(!widget.isColaborator){
                                  Navigator.push(
                                      context, FadeRoute(page: NameScreen(isColaborator: true,)));
                                }else{
                                  Navigator.push(
                                      context, FadeRoute(page: SuccessRegister(isColaborator: widget.isColaborator,)));
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 100),
                              decoration: BoxDecoration(
                                color: existsPhone
                                    ? Colors.black
                                    : mediumGreyChimbi,
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
    );
  }
}
