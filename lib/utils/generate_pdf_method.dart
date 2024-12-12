import 'dart:io';
import 'package:final_project/utils/htmlFormat.dart';
import 'package:final_project/utils/section_null_validator.dart';
import 'package:final_project/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';

import 'package:fluttertoast/fluttertoast.dart';
Future<void> generatePdf(context) async {

  sectionNullValidation();

  nameHtml = nameHtml?.replaceAll("<p>", "")
      .replaceAll("</p>", "")
      .replaceAll("<br/>", "");

  DateTime now = DateTime.now();
  try {
    final downloadsDir = Directory("/storage/emulated/0/Download");
    if (!downloadsDir.existsSync()) {
      throw Exception("Downloads folder not found!");
    }

    final targetPath = downloadsDir.path;
    final targetFileName = "prescripton_${now.day}_${now.hour}_${now.minute}_${now.second}";

    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: htmlFormat(headerHtml,primarySectionHtml,secondarySectionHtml,nameHtml,ageController.text.toString(),selectedGender.toString()),
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: targetPath,
        targetName: targetFileName,
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Portrait,
      ),
    );

    Fluttertoast.showToast(
        msg: "Saved to $targetPath as $targetFileName",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}
