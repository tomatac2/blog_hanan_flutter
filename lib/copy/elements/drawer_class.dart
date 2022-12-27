import 'package:flutter/material.dart';
import 'package:blog_hanan/copy/elements/globals.dart' as globals;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class drawerClass extends StatelessWidget {
  const drawerClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            ListTile(
              title: Text("Home"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Home');
              },
              shape: const Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
              ),
            ),
            ListTile(
              title: Text("Videos"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Videos');
              },
              shape: const Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
              ),
            ),
            ListTile(
              title: Text("Sports"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Sports');
              },
              shape: const Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
              ),
            ),
            ListTile(
              title: Text("Technology"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Technology');
              },
              shape: const Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
              ),
            ),
            ListTile(
              title: Text("Learning"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Learning');
              },
              shape: const Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
              ),
            ),
            ListTile(
              title: Text("News"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/News');
              },
              shape: const Border(
              bottom: BorderSide(color: Colors.black38, width: 1),
              ),
            ),
            globals.Token.isEmpty ? _registerLink(context) : _profileLink(context),
            globals.Token.isEmpty ? _loginLink(context) : Container(),
            globals.Token.isNotEmpty ? _logoutLink(context) : Container(),
          ],
        ),
      ),
    );

  }

  _loginLink(context){
    return ListTile(
      title: Text("Login"),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Login');
      },
      shape: const Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }
  _registerLink(context){
    return ListTile(
      title: Text("Register"),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Register');
      },
      shape: const Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }
  _profileLink(context){
    return ListTile(
      title: Text("Profile"),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Profile');
      },
      shape: const Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }
  _logoutLink(context){
    return ListTile(
      title: Text("Logout"),
      onTap: (){
        _createTokenFromStorage();
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Home');
      },
      shape: const Border(
        bottom: BorderSide(color: Colors.black38, width: 1),
      ),
    );
  }

  Future<void> _createTokenFromStorage() async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'Token', value: "" );
    globals.Token = "";
    //setState(() { });
  }




}
