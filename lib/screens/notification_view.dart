import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dictionary_app/backend.dart';
import 'package:dictionary_app/models/response1.dart';
import 'package:dictionary_app/models/response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../InternetChecker.dart';
import '../constants.dart';
import '../models/response.dart';
import '../models/response.dart';
import '../models/response.dart';
import '../models/response2.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  // String _word = 'word';
  Response2? Result = Response2(english: '', hindi: '', chhattisgarhi: '',
      partOfSpeech: '', meaning: '');
  bool _loading = false;
  Timer? timer;
  SharedPreferences? s;

  @override
  initState() {
    super.initState();
    init();
    // InternetChecker().checkConnection(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // InternetChecker().listener.cancel();
  }

  init() async{
    var response = await http.get(Uri.parse('https://dictionary-api-fuzzy-brains.herokuapp.com/api/getRandomWord'));
    print(response);
    List responses = jsonDecode(response.body)['result'];
    print(responses);

    Response1 result = Response1.fromJson(responses[0]);
    print(result.toJson());

    Response2? res;

    var response2 = await http.get(
      Uri.parse(BASE_URL + 'en' +  '/' + result.english),
    );

    try{
      List responseFromApi2 = jsonDecode(response2.body);
      List<Response> responseList2 = [];
      for(var x in responseFromApi2){
        Response r = Response.fromJson(x);
        responseList2.add(r);
      }

      Response r = responseList2[0];
      res = Response2(
          english: result.english, hindi: result.hindi, chhattisgarhi: result.chhattisgarhi,
          partOfSpeech: r.meanings[0].partOfSpeech, meaning: r.meanings[0].definitions[0].definition);

      // setState(() {
      //   Responses = Responses1;
      //   Responses2 = responses2;
      //   _loading = false;
      //   Results.clear();
      // });
    }catch(e){
      res = Response2(
          english: result.english, hindi: result.hindi, chhattisgarhi: result.chhattisgarhi,
          partOfSpeech: '', meaning: '');
    }

    setState(() {
      _loading = false;
      Result = res;
      // _language = result.languageCode;
    });
  }

  @override
  void didUpdateWidget(covariant NotificationView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

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
            ) : Result==null ? Center(
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
                        child: Text('English (en) : ${Result!.english}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Hindi (hi) : ${Result!.hindi}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Chhattisgarhi (cg) : ${Result!.chhattisgarhi}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Part of speech : ${Result!.partOfSpeech}',
                          style: GoogleFonts.lato(fontSize: 20,
                              fontStyle: FontStyle.italic, color: Colors.black ),),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Meaning : ${Result!.meaning}',
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
