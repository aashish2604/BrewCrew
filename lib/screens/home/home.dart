import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCC7C0),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.brown[800],
        actions: [
          TextButton.icon(onPressed: ()async{
            await _auth.signOut();
          },
              icon: Icon(Icons.power_settings_new, color: Colors.white,),
              label: Text('Logout',style: TextStyle(color: Colors.white),)
          ),
        ],
      ),
    );
  }
}
