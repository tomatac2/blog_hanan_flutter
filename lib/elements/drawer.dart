import 'package:flutter/material.dart';
import 'package:blog_hanan/elements/globals.dart' as globals;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class drawerMenu extends StatelessWidget {
  const drawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _listTile(context , "Homepage" , Icon(Icons.home) ),
            _listTile(context , "Videos" , Icon(Icons.video_camera_back_outlined) ),
            _listTile(context , "Sports" , Icon(Icons.category_outlined) ),
            _listTile(context , "Technology" , Icon(Icons.category_outlined) ),
            _listTile(context , "Learning" , Icon(Icons.category_outlined) ),
            _listTile(context , "News" , Icon(Icons.category_outlined) ),
            globals.Token.isEmpty ? _listTile(context , "Register" , Icon(Icons.app_registration) ) : Container(),
            globals.Token.isEmpty ?  _listTile(context , "Login" , Icon(Icons.login) ) : _listTile(context, "Profile", Icon(Icons.person)),
            globals.Token.isNotEmpty ?  _listTileLogout(context) :  Container(),
          ],
        ),
      ),
    );
  }

  _listTileLogout(context  ){
    return  ListTile(
      leading: Icon(Icons.logout) ,
      title: Text("Logout" , style: TextStyle(color: Colors.redAccent),),
      onTap: () async {
        // Create storage
        final storage = new FlutterSecureStorage();
        // Delete value
        await storage.delete(key: "Token");
        //Delete from local
        globals.Token = "" ;

        Navigator.pushNamed(context, "/Homepage");
      },
      shape: Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }

  _listTile(context , pageName , icon ){
    return  ListTile(
      leading: icon,
      title: Text("$pageName"),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, "/$pageName");
      },
      shape: Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }
}
