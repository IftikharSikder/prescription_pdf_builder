import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;


class EditorPage2 extends StatefulWidget {
  const EditorPage2({super.key});

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage2> {
  final quill.QuillController _controller = quill.QuillController.basic();

  bool isHeading1Active = false;
  bool isHeading2Active = false;
  bool isBoldActive = false;
  bool isItalicActive = false;
  bool isUnderlineActive = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quill Editor'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              quill.QuillToolbarCustomButton(
                controller: _controller,
                options: quill.QuillToolbarCustomButtonOptions(
                  icon: Icon(Icons.store_mall_directory,color: isHeading1Active==true ? Colors.blue: Colors.black),
                  tooltip: 'Header 1',
                  onPressed: () {
                    setState(() {
                      if(isHeading1Active==false){
                        isHeading1Active = true;
                      }
                      else if(isHeading1Active==true){
                        isHeading1Active = false;
                      }
                        isHeading2Active = false;
                    });
                    final currentSelection = _controller.getSelectionStyle();
                    if (currentSelection.containsKey(quill.Attribute.h1.key)) {
                      _controller.formatSelection(quill.Attribute.clone(quill.Attribute.h1, null));
                    } else {
                      _controller.formatSelection(quill.Attribute.h1);
                    }
                  },
                ),
              ),



              quill.QuillToolbarCustomButton(
                controller: _controller,
                options: quill.QuillToolbarCustomButtonOptions(
                  icon: Icon(Icons.title,color: isHeading2Active==true ? Colors.blue: Colors.black),
                  tooltip: 'Header 2',
                  onPressed: () {

                    setState(() {
                      if(isHeading2Active==false){
                        isHeading2Active = true;
                      }
                      else if(isHeading2Active==true){
                        isHeading2Active = false;
                      }

                      if(isHeading1Active==false){
                        isHeading1Active = true;
                      }
                      if(isHeading1Active==true){
                        isHeading1Active = false;
                      }
                    });

                    final currentSelection = _controller.getSelectionStyle();
                    if (currentSelection.containsKey(quill.Attribute.h2.key)) {
                      _controller.formatSelection(quill.Attribute.clone(quill.Attribute.h2, null));
                    } else {
                      _controller.formatSelection(quill.Attribute.h2);
                    }
                  },
                ),
              ),

              quill.QuillToolbarCustomButton(
                controller: _controller,
                options: quill.QuillToolbarCustomButtonOptions(
                  icon: Icon(Icons.format_bold, color: isBoldActive==true ? Colors.blue: Colors.black),
                  tooltip: 'Bold',
                  onPressed: () {
                    final currentSelection = _controller.getSelectionStyle();
                    if (currentSelection.containsKey(quill.Attribute.bold.key)) {
                      _controller.formatSelection(quill.Attribute.clone(quill.Attribute.bold, null));
                    } else {
                      _controller.formatSelection(quill.Attribute.bold);
                    }

                  },
                ),
              ),



              quill.QuillToolbarCustomButton(
                controller: _controller,
                options: quill.QuillToolbarCustomButtonOptions(
                  icon: Icon(Icons.format_italic),
                  tooltip: 'Italic',
                  onPressed: () {
                    final currentSelection = _controller.getSelectionStyle();
                    if (currentSelection.containsKey(quill.Attribute.italic.key)) {
                      _controller.formatSelection(quill.Attribute.clone(quill.Attribute.italic, null));
                    } else {

                      _controller.formatSelection(quill.Attribute.italic);
                    }
                  },
                ),
              ),


              quill.QuillToolbarCustomButton(
                controller: _controller,
                options: quill.QuillToolbarCustomButtonOptions(
                  icon: Icon(Icons.align_vertical_bottom),
                  tooltip: 'Underline',
                  onPressed: () {
                    final currentSelection = _controller.getSelectionStyle();
                    if (currentSelection.containsKey(quill.Attribute.underline.key)) {
                      _controller.formatSelection(quill.Attribute.clone(quill.Attribute.underline, null));
                    } else {
                      _controller.formatSelection(quill.Attribute.underline);
                    }
                  },
                ),
              ),

            ],
          ),

          // The Quill Editor itself
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: quill.QuillEditor(
                controller: _controller,
                focusNode: FocusNode(),
                scrollController: ScrollController(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


