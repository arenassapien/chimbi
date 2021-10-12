import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/animationRoutes.dart';
import 'package:chimbi/views/register/nameScreen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            color: blueChimbi,
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  "images/appLogos/logo_bw.png",
                  height: 200,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 15, right: 15),
                  child: Center(
                    child: Text(
                      "!BIENVENIDO!",
                      style: TextStyle(
                          fontFamily: 'Dense',
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            FadeRoute(page: NameScreen(isColaborator: false))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 35),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "COMENZAR CONFIGURACIÓN",
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
    );
  }
}
