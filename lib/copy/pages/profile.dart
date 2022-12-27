import 'dart:convert';
import 'dart:ffi';

import 'package:blog_hanan/copy/elements/drawer_class.dart';
import 'package:blog_hanan/copy/models/profile.dart';
import 'package:blog_hanan/copy/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog_hanan/copy/elements/globals.dart' as globals;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  Data ? profileInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const drawerClass(),
      appBar: AppBar(title: const Text("Profile Page"),),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        child:Container(
        color: Colors.white,
        child:
        FutureBuilder<ProfileModel>(
          future: profileApi(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data = snapshot.data;
                  return Column(
                    children: [
                      const ListTile(
                          title :  Text("Profile Info"),
                      ),
                      ListTile(
                          leading: const Icon(
                            Icons.face,
                            size: 25,
                          ),
                          title :const Text("Username: "),
                          subtitle : Text(data!.blog.data.username),
                        ),
                      const SizedBox(height: 25,),
                       Container(height: 1,color: Colors.black45),
                      const SizedBox(height: 25,),
                       ListTile(
                          leading: const Icon(
                            Icons.email,
                            size: 25,
                          ),
                          title :const Text("Email: "),
                          subtitle : Text(data!.blog.data.email),
                        ),
                      const SizedBox(height: 25,),
                      Container(height: 1.4,color: Colors.black45),



                    ],
                  );
                }
            }

          },
        )
          ,
      )
        ,
      ),
    );
  }

  profile(){
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                title: const Text("username"),
                subtitle: Text("${profileInfo!.username}"),
              ),
              ListTile(
                title: const Text("email"),
                subtitle: Text("${profileInfo!.email}"),
              ),
            ],
          ) ,
        );

  }

  ///api
  Future<ProfileModel> profileApi() async{
    final Uri url = Uri.parse("${globals.URL}api/profile");
    //body
    var map = new Map<String, dynamic>();
    map['token'] = globals.Token;

    final response = await http.post(url , body:map);
    //final getResult = json.decode(response.body) ;

    final getResult = profileModelFromJson(response.body);

    //categories.addAll(getResult.blog.data.categories);

    if(response.statusCode == 200){
      profileInfo = getResult.blog.data;
    }
    return ProfileModel.fromJson(jsonDecode(response.body));
  }
}
