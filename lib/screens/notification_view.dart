import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dictionary_app/backend.dart';
import 'package:dictionary_app/models/response1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../InternetChecker.dart';
import '../constants.dart';
import '../models/response2.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  // String _word = 'word';
  Response2? response2;
  bool _loading = true;

  @override
  initState() {
    super.initState();
    InternetChecker().checkConnection(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    InternetChecker().listener.cancel();
  }

  init() async{
    var response = await get(Uri.parse('https://dictionary-api-fuzzy-brains.herokuapp.com/api/getAllWords'));

    List responses = jsonDecode(response.body)['result'];

    List<Response1> results = [];
    for(var x in responses){
      Response1 r= Response1.fromJson(x);
      results.add(r);
    }

    Random random = Random();
    int index = random.nextInt(results.length);

    Response1 result = results[index];

    Response2? res = await apiCall(result.english, 'en');
    setState(() {
      response2 = res;
      _loading = false;
      // _language = result.languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Color(0xFFF3F3F3),
            // height: 200,
            child: _loading ? Center(
                child: Column(
                  children: [
                    Text('Loading..Please wait...', style: GoogleFonts.lato(fontSize: 17,
                        fontWeight: FontWeight.bold, color: primaryColor ),),
                    SizedBox(height: 8,),
                    CircularProgressIndicator(color: primaryColor,)
                  ],
                ),
            ) : response2==null ? Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Something went wrong. Please try again later.',
                  style: GoogleFonts.lato(fontSize: 20, fontStyle: FontStyle.italic,
                      color: primaryColor, fontWeight: FontWeight.bold),),
              ),
            ) :  Column(
              children: [
                Text('Word of the Day', style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic, color: Colors.black ),),
                SizedBox(height: 20,),
                ListTile(
                  title: Text('Description of the word', style:
                  GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic, color: Colors.black ),),

                  subtitle: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('English (en) : ${response2!.english}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Hindi (hi) : ${response2!.hindi}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Chhattisgarhi (cg) : ${response2!.chhattisgarhi}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Part of speech : ${response2!.partOfSpeech}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Meaning : ${response2!.meaning}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
