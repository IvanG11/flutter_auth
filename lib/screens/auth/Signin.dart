import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/Auth.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: SignInForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _submit() {
    Provider.of<Auth>(context).signin(
        data: {
          'email': emailController.text,
          'password': passwordController.text
        },
        success: () {
          Navigator.of(context).pop();
        },
        error: () {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Invalid credentials')));
        });
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'you@example.com', labelText: 'Email address'),
            ),
            TextFormField(
              controller: passwordController,
              decoration:
                  InputDecoration(hintText: 'Password', labelText: 'Password'),
            ),
            Container(
              width: screenSize.width,
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _submit(),
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
