import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
            height: 300,
            child: Column(
              children: [
                Text('Word of the Day', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic, color: Colors.black ),)
              ],
            ),
          )

        ],
      ),
    );
  }
}
