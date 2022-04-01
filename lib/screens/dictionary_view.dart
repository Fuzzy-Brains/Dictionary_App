import 'dart:convert';

import 'package:dictionary_app/models/word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class DictionaryView extends StatefulWidget {
  const DictionaryView({Key? key}) : super(key: key);

  @override
  _DictionaryViewState createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  final TextEditingController _controller = TextEditingController();
  List<Word> Words = [];

  submit() async{
    String keywords = _controller.text.toString().replaceAll(' ', '+');
    String url = 'https://api.datamuse.com/words?ml=' + keywords;

    var res = await http.get(
      Uri.parse(url),
    );

    List responses = jsonDecode(res.body);
    List<Word> words = [];
    for(var x in responses){
      Word w = Word.fromJson(x);
      words.add(w);
    }

    setState(() {
      Words = words;
    });

    // for(Word w in Words){
    //   print(w.toJson());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Color(0xFFF3F3F3),
            height: 220,
            child: Column(
              children: [
                Container(
                  child: Text('Enter keywords to search',
                    style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, color: Colors.black ),),
                ),
                SizedBox(height: 14,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: primaryColor,
                    // onChanged: _onChanged,
                    controller: _controller,
                    decoration: InputDecoration(
                        labelStyle: GoogleFonts.lato(fontSize: 16, ),
                        hintText: 'Enter some keywords (separated by spaces)',
                        hintStyle: GoogleFonts.lato(fontSize: 14, ),
                        contentPadding: EdgeInsets.only(left: 24),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 14,),
                MaterialButton(onPressed: (){
                  submit();
                },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Text('Submit', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic, color: Colors.white ),),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (c,i){
              return ListTileWidget(listItem: Words[i]);
            },
            itemCount: Words.length,
          )
        ],
      ),
    );
  }
}

class ListTileWidget extends StatefulWidget {
  final Word listItem;
  const ListTileWidget({Key? key, required this.listItem}) : super(key: key);

  @override
  _ListTileWidgetState createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // height: 300,
      color: Color(0xFFF3F3F3),
      child: ListTile(
        title: Text(widget.listItem.word, style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic, color: Colors.black ),),
        trailing: Text('Score : ${widget.listItem.score.toInt()}', style: GoogleFonts.lato(fontSize: 18,
            fontStyle: FontStyle.italic, color: Colors.black ),),
        // subtitle: Text(widget.listItem.meanings[0].definitions[0].definition, style: GoogleFonts.lato(fontSize: 20,
        //     fontStyle: FontStyle.italic, color: Colors.black ),),
      ),
    );
  }
}
