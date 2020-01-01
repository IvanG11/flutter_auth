import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/Auth.dart';
import 'package:flutter_auth/screens/Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      child: MyApp(),
      create: (context) => Auth(),
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();

  void _tryToAuthenticate() async {
    String token = await storage.read(key: 'token');

    Provider.of<Auth>(context).attempt(token: token);
  }

  @override
  void initState() {
    _tryToAuthenticate();
    super.initState();
  }

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
