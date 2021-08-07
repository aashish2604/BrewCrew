import 'dart:ffi';

import 'package:brew_crew/model/brew_model.dart';
import 'package:brew_crew/model/user_model.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    //This is responsible for displaying the bottom Sheet on clicking the settings button
    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.all(20),
          child: FormSettings(),
        );
      });
    }

    return StreamProvider<List<BrewModel>?>.value(
      catchError: (_,__) => null,
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
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
        body: BrewList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showSettingPanel();
          },
          backgroundColor: Colors.brown[900],
          child:Icon(Icons.settings),

        ),
      ),
    );
  }
}
