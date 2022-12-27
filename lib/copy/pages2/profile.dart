import 'package:blog_hanan/copy/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;

import '../models/profile2.dart';

class ProfileCopy2 extends StatefulWidget {
  const ProfileCopy2({Key? key}) : super(key: key);

  @override
  State<ProfileCopy2> createState() => _ProfileCopy2State();
}

class _ProfileCopy2State extends State<ProfileCopy2> {
      Data ? profileInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerClass2(),
        appBar: AppBar(title: Text("Profile"),),
        body: _profile()
    );
  }

  _profile(){
    return
      FutureBuilder<ProfileModel>(
        future: profileApi(), // async work
        builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Text('Loading....');
            default:
              if (snapshot.hasError)
                return Text('please login');
              else
                return _proInfo();
          }
        },
      ) ;
  }

  _proInfo(){
    return   Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("profile info"),
          SizedBox(height: 20,),
          ListTile(
            title: Text("username:"),
            subtitle: Text(profileInfo!.username),
            leading: const Icon(Icons.face),
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text("email:"),
            subtitle: Text(profileInfo!.email),
            leading: const Icon(Icons.email),
          ),
        ],
      ),
    );
  }

  ///api
  Future<ProfileModel> profileApi() async{
    final Uri url = Uri.parse("${globals.URL}api/profile");

    var map = new Map<String, dynamic>();
    map['token'] = globals.Token;

    final response = await http.post(url , body: map);

     if(response.statusCode == 200){
       final getResult = profileModelFromJson(response.body);
        profileInfo = getResult.blog.data;
     }
    return profileModelFromJson(response.body);
  }
}
