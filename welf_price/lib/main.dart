import 'package:welf_price/View/CallSk.dart';
import 'package:welf_price/View/io.dart';
import 'package:welf_price/View/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IO(),
      //home: WebsocketDemo(),
      theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(),
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 47)),
    );
  }
}
