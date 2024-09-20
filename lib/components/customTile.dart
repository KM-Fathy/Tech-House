import 'package:flutter/material.dart';

Widget CustomTile(String text, IconData icon, Function() f) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    child: Card(
      color: const Color(0xff242832),
      child: ListTile(
        splashColor: Colors.transparent,
          leading: Icon(
            icon,
            color: const Color(0xff48bde9),
          ),
          onTap: f,
          title: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    ),
  );
}
