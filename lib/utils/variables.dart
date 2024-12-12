import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

int primarySectionState = 0;
var headerSectionController = QuillController.basic();
var primarySectionController = QuillController.basic();
var secondarySectionController = QuillController.basic();
var nameController = QuillController.basic();

String? headerHtml;
String? primarySectionHtml;
String? secondarySectionHtml;
var ageController = TextEditingController();

String? nameHtml;
String? selectedGender = "";
int? age;
var delta_header;
var delta_primary_section;
var delta_secondary_section;
var delta_name;

DateTime now = DateTime.now();
String formattedDate = "";
