import 'package:dictionary_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix_icons/flutter_remix_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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

            child: Column(
              children: [
                Container(
                  child: Text(
                  'Fuzzy Brains', style:  GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic, color: Colors.black ),
                ),),
                SizedBox(height: 14,),
                Container(
                  child: Text(
                  'We are a group of three passionate developers, '
                      'aiming to create some beneficial products which would be helpful for the society.',
                  style:  GoogleFonts.lato(fontSize: 18,
                    fontStyle: FontStyle.italic, color: Colors.black ),
                    textAlign: TextAlign.center,
                ), ),
                SizedBox(height: 28,),
                Container(
                  child: Text(
                    'We have built this dictionary app for the purpose of helping users know '
                        'meanings of regional words as well.'
                        'Currently we are collecting data and adding them in our database to make our application'
                        ' more efficient. ',
                    style:  GoogleFonts.lato(fontSize: 18,
                        fontStyle: FontStyle.italic, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ), ),

                SizedBox(height: 28,),
                Container(
                  child: Text(
                    'We have developed this application as our Minor Project of 6th semester under the guidance of '
                        'our project guide ',
                    style:  GoogleFonts.lato(fontSize: 18,
                        fontStyle: FontStyle.italic, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ), ),

                SizedBox(height: 28,),
                Container(
                  child: Text(
                    'Dr Manish Srivastava Sir',
                    style:  GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ), ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Associate Professor Dept Of Computer Science & Engineering',
                    style:  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ), ),

                SizedBox(height: 28,),
                Container(
                  child: Text(
                    'Meet the Developers',
                    style:  GoogleFonts.lato(fontSize: 20,
                        fontStyle: FontStyle.italic, color: Colors.black ),
                    textAlign: TextAlign.center,
                  ), ),

                SizedBox(height: 16,),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (c, i){
                    return ListTile(
                      title: Text(
                        developers[i]['name'],
                        style:  GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic, color: Colors.black ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        '${developers[i]['branch']} ${developers[i]['year']}',
                        style:  GoogleFonts.lato(fontSize: 18,
                            fontStyle: FontStyle.italic, color: Colors.black ),
                        textAlign: TextAlign.center,
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          launch(developers[i]['linkedin'], forceWebView: false);
                        },
                        icon: Icon(RemixIcons.linkedinFill, size: 28, color: primaryColor,),
                      ),
                    );
                  },
                  itemCount: developers.length,
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  List developers = [
    {
      'name' : 'Suraj Patel',
      'branch' : 'CSE',
      'year' : '3rd year',
      'linkedin' : 'https://www.linkedin.com/in/suraj-patel7564/'
    },
    {
      'name' : 'Sushil Kumar',
      'branch' : 'CSE',
      'year' : '3rd year',
      'linkedin' : 'https://www.linkedin.com/in/sushil-kumar-bh20/'
    },
    {
      'name' : 'Yuvraj Singh',
      'branch' : 'CSE',
      'year' : '3rd year',
      'linkedin' : 'https://linkedin.com/in/yuvraj-2503'
    },
  ];
}
