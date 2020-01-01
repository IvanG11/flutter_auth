import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/auth/Signin.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth/auth/Auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auth')),
      body: Container(),
      drawer: Drawer(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.loggedIn) {
              return ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(auth.user.name),
                    accountEmail: Text(auth.user.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(auth.user.avatar),
                    ),
                  ),
                  ListTile(
                    title: Text('Sign Out'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Provider.of<Auth>(context).signout(success: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('You have been signed out')));
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              );
            } else {
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Sign in'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
