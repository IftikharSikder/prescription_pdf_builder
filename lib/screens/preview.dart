import 'package:final_project/utils/footer_button_style.dart';
import 'package:final_project/utils/htmlFormat.dart';
import 'package:final_project/utils/section_null_validator.dart';
import 'package:final_project/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

String? fileName;
String? pdfPath;
String? pathToOpenPdf;

bool? loadingState;

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generatePDFCache();
  }

  generatePDFCache() async {
    setState(() {
      loadingState = false;
    });

    sectionNullValidation();

    nameHtml = nameHtml?.replaceAll("<p>", "").replaceAll("</p>", "").replaceAll("<br/>", "");

    final appDirectory = await getApplicationCacheDirectory();

    setState(() {
      fileName = 'preview';
      pdfPath = '${appDirectory.path}';
      pathToOpenPdf = '${appDirectory.path}/$fileName.pdf';
    });

    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: htmlFormat(headerHtml, primarySectionHtml, secondarySectionHtml, nameHtml,
          ageController.text.toString(), selectedGender.toString()),
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: pdfPath.toString(),
        targetName: fileName.toString(),
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Portrait,
      ),
    );
    setState(() {
      loadingState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: loadingState == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PdfViewer.openFile(pathToOpenPdf.toString())),
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: button(context, Icons.arrow_back, "Cancel", "0xFFFFFFFF", "0xFF737373", "back"),
                onTap: () {
                  setState(() {
                    loadingState = false;
                  });
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .019,
              ),
              button(context, Icons.save, "Save", "0xFF358666", "0xFFFFFFFF", "download"),
            ],
          ),
        ),
      ),
    );
  }
}
