import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/response.dart';
import 'models/response1.dart';
import 'models/response2.dart';

const String BASE_URL = 'https://api.dictionaryapi.dev/api/v2/entries/';

Future<Response2?> apiCall(String word, String languageCode) async{
  Response2 res;
  var response = await http.post(
      Uri.parse('https://dictionary-api-fuzzy-brains.herokuapp.com/api/fetchDefinitionByWord'),
      body: {
        'word': word,
        'languageCode': languageCode
      }
  );

  // print(response.body);
  List responseFromApi = jsonDecode(response.body)['result'];
  List<Response1> responseList = [];
  for(var x in responseFromApi){
    Response1 r= Response1.fromJson(x);
    responseList.add(r);
  }

  if(responseList.isEmpty){
    return null;
  }else{
    Response1 rr = responseList[0];
    var response2 = await http.get(
      Uri.parse(BASE_URL + 'en' +  '/' + rr.english),
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
          english: rr.english, hindi: rr.hindi, chhattisgarhi: rr.chhattisgarhi,
          partOfSpeech: r.meanings[0].partOfSpeech, meaning: r.meanings[0].definitions[0].definition);

      // setState(() {
      //   Responses = Responses1;
      //   Responses2 = responses2;
      //   _loading = false;
      //   Results.clear();
      // });
    }catch(e){
      return Response2(
          english: rr.english, hindi: rr.hindi, chhattisgarhi: rr.chhattisgarhi,
          partOfSpeech: '', meaning: '');
    }

    return res;
  }


  // setState(() {
  //   Responses2 = responses2;
  //   Results = Results1;
  //   _loading = false;
  //   Responses.clear();
  // });
}