import 'package:final_project/screens/prescription_page/prescription_home.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'DM',
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: PrescriptionHome()),
    );
  }
}
