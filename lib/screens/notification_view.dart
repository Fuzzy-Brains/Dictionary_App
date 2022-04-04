import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dictionary_app/models/response1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  String _word = 'word';
  String _definition = 'definition';
  String _language = 'language';
  String _partOfSpeech = 'noun';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async{
    var response = await get(Uri.parse('https://dictionary-api-fuzzy-brains.herokuapp.com/api/getAllWords'));

    List responses = jsonDecode(response.body)['result'];

    List<Result> results = [];
    for(var x in responses){
      Result r= Result.fromJson(x);
      results.add(r);
    }

    Random random = Random.secure();
    int index = random.nextInt(results.length);

    Result result = results[index];
    setState(() {
      _word = result.word;
      _partOfSpeech = result.partOfSpeech;
      _definition = result.definition;
      _language = result.languageCode;
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
            child: Column(
              children: [
                Text('Word of the Day', style: GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic, color: Colors.black ),),
                SizedBox(height: 14,),
                ListTile(
                  title: Row(
                    children: [
                      Text(_word, style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic, color: Colors.black ),),
                      SizedBox(width: 16,),
                      AutoSizeText('($_language)', style: GoogleFonts.lato(fontSize: 18,
                           color: Colors.black ), maxLines: 2,)
                    ],
                  ),
                  trailing: Text(_partOfSpeech, style: GoogleFonts.lato(fontSize: 22,
                      fontStyle: FontStyle.italic, color: Colors.black ),),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_definition, style: GoogleFonts.lato(fontSize: 20,
                        fontStyle: FontStyle.italic, color: Colors.black ),),
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
