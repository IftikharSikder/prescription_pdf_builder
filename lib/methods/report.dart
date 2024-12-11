import 'package:flutter/material.dart';

report_text_h1(text){
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}


report_text_h2(text){
  return  Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 13,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}


report_text_h3(text){
  return  Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    ],
  );
}