import 'package:flutter_quill/flutter_quill.dart';

toolbarOptions(){
  return const QuillSimpleToolbarConfigurations(
      showFontFamily: false,
      showAlignmentButtons: false,
      showCenterAlignment: false,
      showUndo: false,
      showRedo: false,
      showFontSize: false,
      showStrikeThrough: false,
      showInlineCode: false,
      showSubscript: false,
      showSuperscript: false,
      showBackgroundColorButton: false,
      showClearFormat: false,
      showColorButton: false,
      showHeaderStyle: false,
      showListNumbers: false,
      showSearchButton: false,
      showClipboardCut: false,
      showClipboardCopy: false,
      showClipboardPaste: false,
      showLink: false,
      showDividers: false,
      showListBullets: false,
      showQuote: false);
}