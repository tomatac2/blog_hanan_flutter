import 'dart:convert';

import 'package:blog_hanan/copy/elements/drawer_class.dart';
import 'package:blog_hanan/copy/models/register.dart';
import 'package:blog_hanan/copy/pages/Home.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create a Form widget.
class RegisterCopy extends StatefulWidget {
  const RegisterCopy({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<RegisterCopy> {

  final _formKey = GlobalKey<FormState>();
  Blog ? registerObj ;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return
      Scaffold(
        drawer: const drawerClass(),
        appBar: AppBar(title: Text("Register"),),
        body:
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          child: _form() ,
        )

      )
    ;
  }

  _form(){

    var user = "";
    var email = "" ;
    var pass ="";

    return
      Form(
        key: _formKey,
        child: ListView(
          children: [
            Text("Username"),
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }else{
                  user = value! ;
                }
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
                }else{
                  email = value! ;
                }
                return null;
              },
            ),
            SizedBox(height: 30,),
            Text("password"),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {

                  return 'Please enter password';
                }else{
                  pass = value! ;
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                    //api
                    register(user,email,pass);

                  }
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      );
  }

  Future register(username , email , password) async{
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;

    var msg = "";

    final Uri url = Uri.parse("${globals.URL}api/register");
    final response = await http.post(url , body: map);

    if(response.statusCode == 200 ){
      final getResult = registerModelFromJson(response.body);
      msg = getResult.blog.msg;
      print("Token not NUl ${getResult.blog.data.token}");
      setState(() { _createTokenFromStorage(getResult.blog.data.token); });
      //redirect to home if registred
       redirectToHome() ;
    }else{
      final resErrData = json.decode(response.body) ;
      print("resErrData $resErrData");
      msg = resErrData["blog"]["msg"];
    }

    //show err msg

    return  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$msg"),)
      );

  }


  Future<void> _createTokenFromStorage(token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'Token', value: token );
    globals.Token = token ;
    setState(() { });
  }


  Future<void> redirectToHome() async {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
    });
  }

}