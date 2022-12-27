import 'dart:convert';

import 'package:blog_hanan/copy/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;

class LoginCopy2 extends StatefulWidget {
  const LoginCopy2({Key? key}) : super(key: key);

  @override
  State<LoginCopy2> createState() => _LoginCopy2State();
}

class _LoginCopy2State extends State<LoginCopy2> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        drawer: DrawerClass2(),
        appBar: AppBar(title: Text("Login"),),
        body: _loginForm(_formKey)
    );
  }

  _loginForm(_formKey){
    String email = "";
    String pass = "";

    return
      Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top:20),
        child:
      ListView(
      children : [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email"),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  email = value ;
                  return null;
                },
              ),
              SizedBox(height: 30,),
              Text("Password"),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  }
                  pass = value ;
                  return null;
                },
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {

                      loginApi(pass,email);
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      print("${ "pass $pass email $email" }");

                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        )
      ]
    ) );
  }

  ///api
  Future loginApi(pass,mail) async{
    final Uri url = Uri.parse("${globals.URL}api/login");

    var map = new Map<String, dynamic>();
    map['password'] = pass;
    map['email'] = mail;

    final response = await http.post(url , body: map );
    final getResult = json.decode(response.body);
    final msg = getResult["blog"]["msg"];
    if(response.statusCode == 200){
      globals.Token = getResult["blog"]["data"]["token"] ;

      // Create storage
      final storage = new FlutterSecureStorage();
      // Write value
      await storage.write(key: "Token", value: getResult["blog"]["data"]["token"]);

      Navigator.pushNamed(context, '/Homepage');
    }

    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(msg)),
    );
  }

}
