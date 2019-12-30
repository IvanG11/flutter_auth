import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/Auth.dart';
import 'package:flutter_auth/screens/Home.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      child: MyApp(),
      create: (context) => Auth(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
