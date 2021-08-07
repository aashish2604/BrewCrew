import 'package:brew_crew/model/brew_model.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugar,String name,int strength)async{
      return await brewCollection.doc(uid).set({
        'sugar': sugar,
        'name': name,
        'strength': strength,
      });
  }

  // brew list from snapshot
  List<BrewModel>? _brewListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      return BrewModel(
          sugar: doc.get('sugar')?? '0',
          strength: doc.get('strength')?? 0,
          name: doc.get('name')?? '');
    }).toList();
  }

  // get the brew stream from firebase
  Stream<List<BrewModel>?> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

}