import 'package:final_project/main.dart';
import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import '../methods/footer_button_style.dart';

import '../methods/section_null_validator.dart';


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

  generatePDFCache()async{

    setState(() {
      loadingState = false;
    });


    sectionNullValidation();

    nameHtml = nameHtml?.replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("<br/>", "");

    final appDirectory=await getApplicationCacheDirectory();

    setState(() {
       fileName = 'preview';
       pdfPath = '${appDirectory.path}';
       pathToOpenPdf = '${appDirectory.path}/$fileName.pdf';
    });


    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0, width=device-width">
    <title>Poultry Consultancy</title>
    <style>
        body {
            font-family: DM Sans, DM Sans;
            margin: 2%;
            padding: 0;
            background-color: #ffffff;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        .top-div {
            width: 100%;
            height: 10vh;
            border: 3px dotted #D9D9D9;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            font-size: 24px;
            margin-top: 20px;
        }
        .space {
            height: 3vh;
        }
        .horizontal-divs {
            display: flex;
            justify-content: space-between;
            width: 100%;
            height: 20%;
        }
        .horizontal-div {
            width: 49%;
            height: auto;
            border: 3px dotted #D9D9D9;
            display: flex;
            align-items: center;
            padding-left: 10px;
            font-size: 18px; 
        }
        .horizontal-div2 {
            width: 1%;
            height: 20vh;
            display: flex;
            align-items: center;
            padding-left: 10px;
        }
        
        .divider {
            border: 1px solid #000;
            width: 100%;
        }
        .two-columns {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }
        .column {
            width: 48%;
            font-size: 16px;
            padding: 10px;
        }
        /* Updated for the layout */
        .column-div-left {
            width: 37%;
            border-top: 2px solid #000;
            border-right: 2px solid #000;
            padding: 10px;
        }
        .column-div-right {
            width: 63%;
            border-top: 2px solid #000;
            padding: 10px;
        }
        .vertical-divider-container {
            display: flex;
            align-items: flex-start;
            width: 100%;
        }
        .vertical-divider {
            border-left: 2px solid #000;
            height: 100vh;
            margin-left: 20px;
            margin-right: 20px;
        }
        .complaints-section {
            margin-bottom: 20px;
        }
        .complaint-text {
            margin-bottom: 20px;
        }
        .complaint-title {
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Top Div -->
    <div class="top-div">
        $headerHtml
    </div>

    <!-- Space -->
    <div class="space"></div>

    <!-- Horizontal Divs -->
    <div class="horizontal-divs">
        <div class="horizontal-div">
            $primarySectionHtml
        </div>
        <div class="horizontal-div2">
            
        </div>
        <div class="horizontal-div">
            $secondarySectionHtml
        </div>
    </div>

    <!-- Space Below Horizontal Divs -->
    <div class="space"></div>

    <!-- Divider -->
    <div class="divider"></div>



    <!-- Columns with Name, Age, Date, Gender -->
    <div class="two-columns">
        <div class="column">
            <div>Name: $nameHtml</div>
            <div>Age: ${ageController.text.toString()}</div>
        </div>
        <div class="column">
            <div>Date: $formattedDate</div>
            <div>Gender: ${selectedGender.toString()}</div>
        </div>
    </div>
    
    
    <!-- Vertical Divider Section -->
    <div class="vertical-divider-container">

        <!-- Left Column (First Column with Borders) -->
        <div class="column-div-left">
            <div class="complaints-section">
            <div class="complaint-text">
                <div class="complaint-title">Owner's Complaint</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Complaint</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Remarks</div>
            </div>
        </div>

        <!-- Repeat the complaints section for the second and third sets -->
        <div class="complaints-section">
            <div class="complaint-text">
                <div class="complaint-title">Clinical Finding</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Clinical Findings</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Remarks</div>
            </div>
        </div>

        <div class="complaints-section">
            <div class="complaint-text">
                <div class="complaint-title">Diagnosis</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Diagnosis</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Remarks</div>
            </div>
        </div>
    </div>
    
     <div class="column-div-right">
            <div class="complaints-section">
            <div class="complaint-text">
                <div class="complaint-title">RX</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Medicines</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Remarks</div>
            </div>
        </div>

        <!-- Repeat the complaints section for the second and third sets -->
        <div class="complaints-section">
            <div class="complaint-text">
                <div class="complaint-title">Advice</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Advice</div>
            </div>
            <div class="complaint-text" style="padding-left: 4%;">
                <div class="complaint-title">Demo Remarks</div>
            </div>
        </div>
    </div>
        </div>

        </div>

</body>
</html>
""",
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

    /*Fluttertoast.showToast(
        msg: "Saved to $pdfPath as $fileName",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: loadingState==false?Center(child: CircularProgressIndicator(),):PdfViewer.openFile(pathToOpenPdf.toString()!)
        ),
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
