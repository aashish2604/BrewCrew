import 'package:brew_crew/model/brew_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>?>(context);
    
    brews!.forEach((element) {
      print(element.name);
      print(element.sugar);
      print(element.strength);
    });

    //building a list view for all the entries received in brews via the BrewModel class
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.only(top: 2),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(radius: 20,backgroundColor: Colors.brown[brews[index].strength],),
                title: Text(brews[index].name),
                subtitle: Text('You prefer ${brews[index].sugar} teaspoons of sugar'),
              ),
            ),

          );
        }
    );
  }
}
