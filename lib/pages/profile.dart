import 'dart:convert';

import 'package:blog_hanan/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/elements/globals.dart' as globals;

import '../models/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Data ? profileInfo  ;

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      drawer: drawerMenu(),
      appBar: AppBar(title: Text("Profile"),),
      body: FutureBuilder<ProfileModel>(
        future: apiProfile(), // async work
        builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Text('Loading....');
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return _profile();
          }
        },
      ),
    );
  }

  _profile(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.numbers),
            title: Text("id:"),
            subtitle: Text("${profileInfo!.userId}"),
            shape: Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
            ),
          ),
          ListTile(
            leading: Icon(Icons.title),
            title: Text("username:"),
            subtitle: Text("${profileInfo!.username}"),
            shape: Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("email:"),
            subtitle: Text("${profileInfo?.email}"),
            shape: Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
            ),
          ),
        ],
      ),
    );
  }

  Future<ProfileModel> apiProfile () async{

    final Uri url = Uri.parse("${globals.URL}api/profile");
    Map<String, String> params = Map();
    params['token'] = globals.Token;


    final response =  await http.post(url , body: params);
    if(response.statusCode == 200){
      final finalReponse = profileModelFromJson(response.body) ;
      profileInfo = finalReponse.blog.data ;
    }

    return  ProfileModel.fromJson(json.decode(response.body)) ;
  }

}
