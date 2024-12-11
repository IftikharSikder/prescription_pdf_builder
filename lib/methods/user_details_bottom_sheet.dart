import 'package:dotted_border/dotted_border.dart';
import 'package:final_project/main.dart';
import 'package:final_project/methods/toolBarConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

userDetailsDropDown(context) {
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
                            child: Column(
                              children: [
                                QuillEditor(
                                  controller: nameController,
                                  focusNode: FocusNode(),
                                  scrollController: ScrollController(),
                                  configurations: QuillEditorConfigurations(placeholder: "Name"),
                                ),
                                Divider(),
                                TextFormField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Age",
                                  ),
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: (selectedGender == "") ? "Gender" : selectedGender,
                                    // border: OutlineInputBorder(),
                                  ),
                                  items: ['Male', 'Female']
                                      .map((gender) => DropdownMenuItem<String>(
                                            value: gender,
                                            child: Text(gender),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectedGender = value;
                                  },
                                  validator: (value) => value == null ? "Select your gender" : null,
                                ),
                                QuillToolbar.simple(controller: nameController, configurations: toolbarOptions()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                                        onPressed: () {
                                          selectedGender = "";
                                          nameController.document = Document();
                                          formattedDate = "";
                                          ageController.text = "";
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
                                          DateTime now = DateTime.now();
                                          formattedDate = "${now.year}:${now.month}:${now.day}";
                                          delta_name = nameController.document.toDelta();
                                          nameHtml = QuillDeltaToHtmlConverter(delta_name.toJson()).convert();
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
                                        ))
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
