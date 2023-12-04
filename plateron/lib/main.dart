import 'package:flutter/material.dart';
import 'package:plateron/providers/screen1_provider.dart';
import 'package:plateron/screens/screen1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => Screen1Provider()),
      ], child: const Screen1())
    );
  }
}
