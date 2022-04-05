import 'dart:async';
import 'package:flutter/material.dart';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_settings/open_settings.dart';

import 'constants.dart';

class InternetChecker{
  late StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";


  void _showDialog(String title,String content ,BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title, style: GoogleFonts.lato(
                  fontSize: 20, fontStyle: FontStyle.italic,
                  color: primaryColor, fontWeight: FontWeight.bold),),
              content: Text(content, style: GoogleFonts.lato(
                  fontSize: 16, fontStyle: FontStyle.italic,
                  color: primaryColor),),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      OpenSettings.openMainSetting();
                    },
                    child: Text(
                      "OPEN SETTINGS", style: GoogleFonts.lato(fontSize: 16,
                        color: primaryColor, fontWeight: FontWeight.bold),))
              ]
          );
        }
    );
  }

  checkConnection(BuildContext context) async{
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        // case DataConnectionStatus.connected:
        //   InternetStatus = "Connected to the Internet";
        //   contentmessage = "Connected to the Internet";
        //   _showDialog(InternetStatus,contentmessage,context);
        //   break;
        case DataConnectionStatus.disconnected:
          InternetStatus = "You are disconnected from the Internet. ";
          contentmessage = "Please check your internet connection";
          _showDialog(InternetStatus,contentmessage,context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}