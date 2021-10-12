import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralConfig extends StatefulWidget {
  const GeneralConfig({Key? key}) : super(key: key);

  @override
  _GeneralConfigState createState() => _GeneralConfigState();
}

class _GeneralConfigState extends State<GeneralConfig> {
  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS
          ? WillPopScope(
      onWillPop: () async{
        return true;
      },
            child: Scaffold(
                body: Container()),
          )
          : Scaffold( );
  }
}
