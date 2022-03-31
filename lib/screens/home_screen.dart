import 'dart:async';
import 'dart:convert';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;

import 'package:dictionary_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  StreamController? _streamController;
  Stream? _stream;

  final String _url = 'https://owlbot.info/api/v4/dictionary/';
  final String _token = '485c8dde628df764c6d8ceecd3deb1c553a58257';

  @override
  initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController!.stream;
  }

  _onChanged(String text) async {
    if (text.isEmpty) {
      _streamController!.add(null);
    }

    String word = text.toString().trim();

    Response response = await http.get(Uri.parse(_url + word),
        headers: {'Authorization': 'Token ' + _token});

    if (response.statusCode == 404) {
      _streamController!.add(null);
      return;
    }

    _streamController!.add(json.decode(response.body));
  }

  _search() async {
    if (_controller.text.isEmpty) {
      _streamController!.add(null);
    }

    String word = _controller.text.toString().trim();

    Response response = await http.get(Uri.parse(_url + word),
        headers: {'Authorization': 'Token ' + _token});
    _streamController!.add(json.decode(response.body));
  }

  List<String> codes = ['SELECT', 'ENGLISH', 'HINDI', 'CHHATTISGARI'];

  var dropdownValue = "ENGLISH";

  print1() {
    print(dropdownValue);
    print(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2c0834),
        elevation: 0,
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text(
          'Dictionary App',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: TextFormField(
                    onChanged: _onChanged,
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: 'Search for a word',
                        contentPadding: EdgeInsets.only(left: 24),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Expanded(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: DropDown<String>(
                          showUnderline: false,
                          dropDownType: DropDownType.Button,
                          hint: Text('Select Language'),
                          items: codes,
                          initialValue: dropdownValue,
                          onChanged: (language) {
                            setState(() {
                              dropdownValue = language!;
                            });
                            print1();
                          },
                        )),
                  ))
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      )),
      // body: StreamBuilder(
      //   stream: _stream,
      //   builder: (context, AsyncSnapshot snapshot){
      //     if(snapshot.data == null){
      //       return const Center(
      //         child: Text('Enter a valid word to search..'),
      //       );
      //     }
      //
      //     return ListView.builder(
      //       itemCount: snapshot.data['definitions'].length,
      //         itemBuilder: (context, index){
      //           return ListBody(
      //             children: [
      //               Container(
      //                 color: Colors.grey[300],
      //                 child: ListTile(
      //                   leading: snapshot.data['definitions'][index]['image_url']==null ? null : CircleAvatar(
      //                     backgroundImage: NetworkImage(snapshot.data['definitions'][index]['image_url']),
      //                   ),
      //                   title: Text(
      //                       snapshot.data['word'] + '(${snapshot.data['definitions'][index]['type']})'
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.all(8),
      //                   child: Text(snapshot.data['definitions'][index]['definition']))
      //             ],
      //           );
      //         }
      //     );
      //   },
      // ),
    );
  }
}
