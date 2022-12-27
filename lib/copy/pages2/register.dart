import 'dart:convert';

import 'package:blog_hanan/copy/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;

class RegisterCopy2 extends StatefulWidget {
  const RegisterCopy2({Key? key}) : super(key: key);

  @override
  State<RegisterCopy2> createState() => _RegisterCopy2State();
}

class _RegisterCopy2State extends State<RegisterCopy2> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        drawer: DrawerClass2(),
        appBar: AppBar(title: Text("Register"),),
        body: _registerForm(_formKey)
    );
  }

  _registerForm(_formKey){
    String username = "";
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
              Text("Username"),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  username = value ;
                  return null;
                },
              ),
              SizedBox(height: 30,),
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

                      registerApi(username,pass,email);
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      print("${ "username $username pass $pass email $email" }");

                    }
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        )
      ]
    ) );
  }

  ///api
  Future registerApi(user,pass,mail) async{
    final Uri url = Uri.parse("${globals.URL}api/register");

    var map = new Map<String, dynamic>();
    map['username'] = user;
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
