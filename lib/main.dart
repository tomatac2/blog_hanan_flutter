//copy
// import 'package:blog_hanan/copy/pages/details.dart';
// import 'package:blog_hanan/copy/pages/Home.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'copy/pages/videos.dart';
// import 'package:blog_hanan/copy/pages/register.dart';
// import 'package:blog_hanan/copy/pages/profile.dart';
// import 'package:blog_hanan/copy/pages2/login.dart';
// import 'package:blog_hanan/copy/pages2/profile.dart';
// import 'package:blog_hanan/copy/pages2/register.dart';

import 'package:blog_hanan/pages/login.dart';
import 'package:blog_hanan/pages/profile.dart';
import 'package:blog_hanan/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:blog_hanan/elements/globals.dart' as globals;

//blog
import 'package:blog_hanan/elements/video_list.dart';
import 'package:blog_hanan/pages/article_details.dart';
import 'package:blog_hanan/pages/homepage.dart';
import 'package:blog_hanan/pages/videos.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        initialRoute: '/Profile',
        routes: {
          '/Homepage': (context) =>  Homepage(),
          '/Videos': (context) =>  VideoList(),
          '/Sports': (context) =>  Homepage(catID: 1,),
          '/Technology': (context) =>  Homepage(catID: 2,),
          '/Learning': (context) =>  Homepage(catID: 3,),
          '/News': (context) =>  Homepage(catID: 4,),
          '/Register': (context) =>  Register(),
          '/Login': (context) =>  Login(),
          '/Profile': (context) =>  Profile(),
        },

      );
  }



}
