import 'package:final_project/screens/prescription_page/user_details_bottom_sheet.dart';
import 'package:final_project/utils/footer_button_style.dart';
import 'package:final_project/utils/report_format_editor.dart';
import 'package:final_project/utils/toolBarConfiguration.dart';
import 'package:final_project/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/preview.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _HomePageState();
}

class _HomePageState extends State<PrescriptionPage> {
  var headerEditorController = QuillController.basic();
  int primarySectionState = 0;
  int secondarySectionState = 0;
  var primaryEditorController = QuillController.basic();
  QuillController secondaryEditorController = QuillController.basic();

  sectionEditor(context, sectionNumber) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal()),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Update Text",
                            style: TextStyle(fontSize: 22),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.cancel)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 3, right: 0),
                      child: DottedBorder(
                        dashPattern: const [4, 3],
                        color: const Color(0xFFD9D9D9),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: QuillEditor(
                              controller: (sectionNumber == 0)
                                  ? headerEditorController
                                  : (sectionNumber == 1)
                                      ? primaryEditorController
                                      : secondaryEditorController,
                              focusNode: FocusNode(),
                              scrollController: ScrollController(),
                              configurations: QuillEditorConfigurations(
                                  minHeight: (sectionNumber == 0) ? 20 : 120,
                                  placeholder: (sectionNumber == 0) ? "Type Header Here..." : ""),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    QuillToolbar.simple(
                        controller: (sectionNumber == 0)
                            ? headerEditorController
                            : (sectionNumber == 1)
                                ? primaryEditorController
                                : secondaryEditorController,
                        configurations: toolbarOptions()),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                              onPressed: () {
                                /*setState(() {
                                  if (sectionNumber == 0) {
                                    headerEditorController.document = Document();
                                    headerSectionController.document = Document();
                                  } else if (sectionNumber == 1) {
                                    primarySectionController.document = Document();
                                    primaryEditorController.document = Document();

                                    primarySectionState = 0;
                                  } else if (sectionNumber == 2) {
                                    secondaryEditorController.document = Document();
                                    secondarySectionController.document = Document();

                                    secondarySectionState = 0;
                                  }
                                });*/

                                setState(() {
                                  //headerEditorController.document.delete(0, headerEditorController.document.length);

                                  if (sectionNumber == 0) {
                                    headerEditorController.document.delete(0, headerEditorController.document.length);
                                    headerSectionController.document.delete(0, headerSectionController.document.length);
                                  } else if (sectionNumber == 1) {
                                    primarySectionController.document
                                        .delete(0, primarySectionController.document.length);
                                    primaryEditorController.document.delete(0, primaryEditorController.document.length);

                                    primarySectionState = 0;
                                  } else if (sectionNumber == 2) {
                                    secondaryEditorController.document
                                        .delete(0, secondaryEditorController.document.length);
                                    secondarySectionController.document
                                        .delete(0, secondarySectionController.document.length);
                                    secondarySectionState = 0;
                                  }
                                });

                                Navigator.of(context).pop();
                              },
                              child: const Row(
                                children: [Icon(Icons.refresh), Text("Reset")],
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF358666),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                              onPressed: () {
                                setState(() {
                                  if (sectionNumber == 1 && (primaryEditorController.document.length - 1) >= 1) {
                                    primarySectionState = 1;

                                    delta_primary_section = primarySectionController.document.toDelta();
                                    setState(() {
                                      primarySectionHtml =
                                          QuillDeltaToHtmlConverter(delta_primary_section.toJson()).convert();
                                    });
                                  } else if (sectionNumber == 2 &&
                                      (secondaryEditorController.document.length - 1) >= 1) {
                                    secondarySectionState = 1;

                                    delta_secondary_section = secondarySectionController.document.toDelta();
                                    setState(() {
                                      secondarySectionHtml =
                                          QuillDeltaToHtmlConverter(delta_secondary_section.toJson()).convert();
                                    });
                                  } else if (sectionNumber == 0) {
                                    delta_header = headerSectionController.document.toDelta();
                                    setState(() {
                                      headerHtml = QuillDeltaToHtmlConverter(delta_header.toJson()).convert();
                                    });
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
              child: GestureDetector(
                child: DottedBorder(
                  color: const Color(0xFFD9D9D9),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .07,
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .56,
                        child: QuillEditor(
                          controller: headerSectionController,
                          focusNode: FocusNode(),
                          configurations: QuillEditorConfigurations(
                            enableInteractiveSelection: false,
                            placeholder: "Type Header Here...",
                          ),
                          scrollController: ScrollController(),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    headerEditorController = QuillController(
                        document: headerSectionController.document, selection: headerSectionController.selection);
                  });
                  sectionEditor(context, 0);
                },
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                child: DottedBorder(
                  color: const Color(0xFFD9D9D9),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * .13,
                      width: MediaQuery.of(context).size.width * .463,
                      child: Center(
                          child: (primarySectionState == 0)
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 40,
                                    ),
                                    Text("Add Primary Section")
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      QuillEditor(
                                          controller: primarySectionController,
                                          focusNode: FocusNode(),
                                          configurations:
                                          const QuillEditorConfigurations(enableInteractiveSelection: false),
                                          scrollController: ScrollController())
                                    ],
                                  ),
                                ))),
                ),
                onTap: () {
                  setState(() {
                    primaryEditorController = QuillController(
                        document: primarySectionController.document, selection: primarySectionController.selection);
                  });
                  sectionEditor(context, 1);
                },
              ),
              GestureDetector(
                child: DottedBorder(
                  color: const Color(0xFFD9D9D9),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .13,
                    width: MediaQuery.of(context).size.width * .463,
                    child: Center(
                      child: (secondarySectionState == 0)
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                                Text("Add Secondary Section")
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  QuillEditor(
                                      controller: secondarySectionController,
                                      focusNode: FocusNode(),
                                      configurations: const QuillEditorConfigurations(enableInteractiveSelection: false),
                                      scrollController: ScrollController())
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    secondaryEditorController = QuillController(
                        document: secondarySectionController.document, selection: secondarySectionController.selection);
                  });
                  sectionEditor(context, 2);
                },
              ),
            ]),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          GestureDetector(
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 4),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                        width: MediaQuery.of(context).size.width * .463,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Name: "),
                                  Flexible(
                                    child: QuillEditor(
                                      controller: nameController,
                                      focusNode: FocusNode(),
                                      scrollController: ScrollController(),
                                      configurations:
                                          const QuillEditorConfigurations(enableInteractiveSelection: false),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Age : "),
                                  Flexible(
                                    child: Text(ageController.text == null ? "" : ageController.text.toString()),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 4),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .463,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Date: "),
                                Text(
                                  formattedDate,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Gender : "),
                                Flexible(
                                  child: Text(selectedGender == null ? " " : selectedGender.toString()),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            onTap: () {
              userDetailsBottomSheet(context).then((_) {
                setState(() {
                  selectedGender;
                });
              });
            },
          ),
          SizedBox(
            height: 0.02,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * .42,
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    )),
                    height: MediaQuery.of(context).size.height * .40,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          children: [
                            report_text_h1("Owners Compliant"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012,
                            ),
                            report_text_h2("Demo Compliant"),
                            report_text_h3("Demo Remarks"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            //--------------------------------------------
                            report_text_h1("Clinical Finding"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012,
                            ),
                            report_text_h2("Demo Clinical Findings"),
                            report_text_h3("Demo Remarks"),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            //-------------------------------------
                            report_text_h1("Diagnosis"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012,
                            ),
                            report_text_h2("Demo Diagnosis"),
                            report_text_h3("Demo Remarks"),

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(color: Colors.black),
                  )),
                  width: MediaQuery.of(context).size.width * .58,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Rx",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.003,
                          ),
                          report_text_h2("Demo Medicine"),
                          report_text_h3("Demo Remarks"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          //----------------------------
                          report_text_h1("Advice"),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.012,
                          ),

                          report_text_h2("Demo Advice"),
                          report_text_h3("Demo Remarks"),

                          const SizedBox(
                            height: 38,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Image.network("https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "ডাক্তারের পরামর্শ ব্যতীত কোনো ওষুধ পরিবর্তণ যোগ্য নহে*",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * .18, MediaQuery.of(context).size.height * .07),
                    side: const BorderSide(color: Color(0xFFD9D9D9)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Preview()));
                },
                child: const Center(
                    child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.black,
                ))),
            SizedBox(
              width: MediaQuery.of(context).size.width * .019,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    //backgroundColor: Color(0xFFFFFFFF),
                    fixedSize: Size(MediaQuery.of(context).size.width * .35, MediaQuery.of(context).size.height * .07),
                    side: const BorderSide(color: Color(0xFFD9D9D9)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  setState(() {
                    primarySectionState = 0;
                    secondarySectionState = 0;
                    headerEditorController.document = Document();
                    headerSectionController.document = Document();

                    primaryEditorController.document = Document();
                    primarySectionController.document = Document();

                    secondaryEditorController.document = Document();
                    secondarySectionController.document = Document();

                    nameController.document = Document();
                    formattedDate = "";
                    ageController.text = "";
                    selectedGender = "";
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Icon(
                      Icons.refresh,
                      color: Color(0xFF737373),
                    )),
                    Center(
                        child: Text(
                      "Reset",
                      style: TextStyle(color: Color(0xFF737373)),
                    )),
                  ],
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * .019,
            ),
            GestureDetector(
              child: button(context, Icons.save, "Save", "0xFF358666", "0xFFFFFFFF", "download"),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
