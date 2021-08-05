import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService{

  late final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugar,String name,int strength)async{
      return await brewCollection.doc(uid).set({
        'sugar': sugar,
        'name': name,
        'strength': strength,
      });
  }
}