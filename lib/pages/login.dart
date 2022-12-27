import 'dart:convert';

import 'package:blog_hanan/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/elements/globals.dart' as globals;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerMenu(),
      appBar: AppBar(title: Text("Login"),),
      body: _form(),
    );
  }

  _form(){
    final _formKey = GlobalKey<FormState>();

    var email = "" ;
    var password = "" ;

    return Form(
      key: _formKey,
      child:
      Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        child:   ListView(
        children: [
          SizedBox(height: 20,),
          Text("Email"),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              email = value ;
              return null;
            },
          ),
          SizedBox(height: 20,),
          Text("Password"),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              password = value ;
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  print(" email $email , pass $password}");

                  apiLogin(email,password) ;
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
      )
    );
  }

  Future apiLogin (mail , pass) async{
    final Uri url = Uri.parse("${globals.URL}api/login");

    Map<String, String> params = Map();
    params['email'] = mail;
    params['password'] = pass;

    final response =  await http.post(url , body: params);
    final finalReponse = json.decode(response.body) ;
    var msg = finalReponse["blog"]["msg"];

    if(response.statusCode == 200){

      globals.Token = finalReponse["blog"]["data"]["token"];

      // Create storage
      final storage = new FlutterSecureStorage();
      // Write value
      await storage.write(key: "Token", value: finalReponse["blog"]["data"]["token"]);

      //redirect to home
      Navigator.pushNamed(context, '/Homepage');
    }


    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("$msg")),
    );
  }
}
