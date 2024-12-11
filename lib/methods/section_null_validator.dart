import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '../main.dart';

sectionNullValidation(){
  if(headerSectionController.document.isEmpty())
  {
    headerSectionController.document.insert(0, "");
    delta_header = headerSectionController.document.toDelta();
    headerHtml = QuillDeltaToHtmlConverter(delta_header.toJson()).convert();
  }

  if(primarySectionController.document.isEmpty())
  {
    primarySectionController.document.insert(0, "");
    delta_primary_section = primarySectionController.document.toDelta();
    primarySectionHtml = QuillDeltaToHtmlConverter(delta_primary_section.toJson()).convert();
  }


  if(secondarySectionController.document.isEmpty())
  {
    secondarySectionController.document.insert(0, "");
    delta_secondary_section = secondarySectionController.document.toDelta();
    secondarySectionHtml = QuillDeltaToHtmlConverter(delta_secondary_section.toJson()).convert();
  }



  if(nameController.document.isEmpty())
  {
    nameController.document.insert(0, "");
    delta_name = nameController.document.toDelta();
    nameHtml = QuillDeltaToHtmlConverter(delta_name.toJson()).convert();
  }
}