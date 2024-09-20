import 'package:flutter/material.dart';

Widget CustomContainer(String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      width: 330,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color(0xff48bde9)),
          color: const Color(0xff242832),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                text1,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Text(
                ": ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff48bde9)),
              ),
              Text(
                text2,
                style: const TextStyle(color: Color(0xffBDBBBB), fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
