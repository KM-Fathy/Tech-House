import 'package:flutter/material.dart';

Widget CustomField(TextEditingController controller, String text,
    String? Function(String?) f, bool b, int? num) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, bottom: 16, right: 15),
    child: TextFormField(
      maxLines: num,
      obscureText: b,
      controller: controller,
      style: const TextStyle(color: Color(0xff777777), fontSize: 20),
      validator: f,
      cursorColor: const Color(0xff777777),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff242832),
        hintText: text,
        hintStyle: const TextStyle(
            color: Color(0xff777777),
            fontSize: 18,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xff242832),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xff242832))),
      ),
    ),
  );
}
