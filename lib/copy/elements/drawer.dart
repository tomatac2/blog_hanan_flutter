import 'package:flutter/material.dart';
import 'package:blog_hanan/copy/elements/globals.dart' as globals;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DrawerClass2 extends StatelessWidget {
  const DrawerClass2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              _listTile(context ,"Homepage" ),
              _listTile(context ,"Videos" ),
              _listTile(context ,"Sports" ),
              _listTile(context ,"Technology" ),
              _listTile(context ,"Learning" ),
              _listTile(context ,"News" ),
              globals.Token.isNotEmpty ? Container() : _listTile(context ,"Register" ) ,
              globals.Token.isNotEmpty ? Container() : _listTile(context ,"Login" ) ,
              globals.Token.isNotEmpty ? _listTile(context,"Profile") :Container()  ,
              SizedBox(height: 20,),
              globals.Token.isNotEmpty ? _listTileLogout(context) :Container()  ,
            ],
          ),
        ),
    );

  }
  _listTileLogout(context){
    return  ListTile(
      title: Text("logout" , style: TextStyle(color: Colors.redAccent),),
      onTap: () async {
        globals.Token = "" ;
        final storage = new FlutterSecureStorage();
        // Delete value
        await storage.delete(key: "Token");
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Homepage');
      },
    );
  }
  _listTile(context ,pageName  ){
    return  ListTile(
      title: Text("$pageName"),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, '/$pageName');
      },
      shape: const Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }
}
