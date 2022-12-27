import 'dart:convert';
import 'dart:ffi';

import 'package:blog_hanan/copy/elements/drawer_class.dart';
import 'package:blog_hanan/copy/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String msg = "" ;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          drawer: const drawerClass(),
          appBar: AppBar(title: Text("Login"),),
          body:
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            child: _form() ,
          )
    );
  }

  _form(){
    var email = "";
    var password = "";

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Text("email"),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }else{
                email = value ;
              }
              return null;
            },
          ),
          SizedBox(height: 40,),
          Text("password"),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }else{
                password = value ;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {

                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  loginApi(email , password);
                }
              },
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }


  ///api
  Future loginApi(email , password) async{
    final Uri url = Uri.parse("${globals.URL}api/login");
    //body
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;

    final response = await http.post(url , body:map);
    final getResult = json.decode(response.body) ;

    if(response.statusCode == 200){

      final storage = new FlutterSecureStorage();
      await storage.write(key: "Token", value: getResult["blog"]["data"]["token"]);
      globals.Token = getResult["blog"]["data"]["token"] ;
      //Done
      msg = getResult["blog"]["msg"] ;

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      //setState(() { status = true ;  });
     } else{
      msg = getResult["blog"]["msg"] ;

    }

    return  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$msg')),
    );
  }
}
