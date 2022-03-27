import 'package:flutter/material.dart';

PreferredSizeWidget appBarMain(String title){
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Center(
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)),
  );
}