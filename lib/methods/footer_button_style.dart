
import 'package:final_project/methods/generate_pdf_method.dart';
import 'package:flutter/material.dart';


button(context, iconData, iconName, buttonBackgroundColor, buttonIconTextColor, returnPage) {
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: (iconName=="Reset")?Colors.transparent:Color(int.parse(buttonBackgroundColor)),
          fixedSize: Size(MediaQuery.of(context).size.width * .35, MediaQuery.of(context).size.height * .07),
          side: const BorderSide(color: Color(0xFFD9D9D9)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () async{

        if(returnPage=="download")
          {
            await generatePdf(context);
          }
        else if(returnPage=="back")
        {
          Navigator.of(context).pop();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Icon(
            iconData,
            color: Color(int.parse(buttonIconTextColor)),
          )),
          Center(
              child: Text(
                iconName,
            style: TextStyle(color: Color(int.parse(buttonIconTextColor))),
          )),
        ],
      ));
}
