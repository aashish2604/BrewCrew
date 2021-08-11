// import 'package:brew_crew/model/user_model.dart';
// import 'package:brew_crew/services/database.dart';
// import 'package:brew_crew/services/loading.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
// class FormSettings extends StatefulWidget {
//   const FormSettings({Key? key}) : super(key: key);
//
//   @override
//   _FormSettingsState createState() => _FormSettingsState();
// }
//
// class _FormSettingsState extends State<FormSettings> {
//
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugar = ['0','1','2','3','4','5'];
//
//   //entries in the form
//    String? _currentName;
//    int? _currentStrength;
//    String? _currentSugar;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final user = Provider.of<UserModel>(context);
//     CollectionReference collectionReference = FirebaseFirestore.instance.collection(user.uid);
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: collectionReference.snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         print(user.uid);
//
//         if(snapshot.hasData){
//           return Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//
//                   //heading
//                   Text('Update your profile',style: TextStyle(fontSize: 20),),
//                   SizedBox(height: 20),
//
//                   //Name entry
//                   TextFormField(
//                     initialValue: snapshot.data!.docs[0]['name'],
//                     validator: (val) => val!.isEmpty? 'Please enter your name' : null,
//                     onChanged: (val){
//                       _currentName = val;
//                     },
//                   ),
//                   SizedBox(height: 20),
//
//                   //dropdown menu for sugar
//                   DropdownButtonFormField(
//                     value: _currentSugar??snapshot.data!.docs[0]['sugar'],
//                     items: sugar.map((sugars){
//                       return DropdownMenuItem(
//                         value: sugars,
//                         child: Text('$sugars sugars'),
//                       );
//                     }).toList(),
//                     onChanged: (val){
//                       setState(() {
//                         _currentSugar = val.toString();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 20),
//
//
//                   //Slider for strength
//                   Slider(
//                       value: (_currentStrength??snapshot.data!.docs[0]['strength']).toDouble() ,
//                       activeColor: Colors.brown[_currentStrength??snapshot.data!.docs[0]['strength']],
//                       inactiveColor: Color(0xA1DEB3AB),
//                       min:100.0 ,
//                       max: 900.0,
//                       divisions: 8,
//                       onChanged: (val){
//                         setState(() {
//                           _currentStrength = val.round();
//                         });
//                       }),
//                   SizedBox(height: 10),
//
//
//
//                   //Submit button
//                   TextButton(
//                       style: TextButton.styleFrom(
//                         primary: Colors.white,
//                         backgroundColor: Colors.brown,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         elevation: 10,
//                       ),
//                       onPressed: ()async{
//                         print(_currentName);
//                         print(_currentStrength);
//                         print(_currentSugar);
//                       },
//                       child: Text('Submit',style: TextStyle(color: Colors.white),)),
//                 ],
//               ),
//             ),
//           );
//         }
//         else {
//           if(snapshot.hasError)throw('$snapshot.error');
//           print('enjoy the infinite loading');
//           return Loading();
//         }
//       }
//     );
//   }
// }
import 'package:brew_crew/model/user_model.dart';
import 'package:brew_crew/services/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormSettings extends StatefulWidget {
  const FormSettings({Key? key}) : super(key: key);

  @override
  _FormSettingsState createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0','1','2','3','4','5'];

  //entries in the form
  late String _currentName;
  late int _currentStrength = 100;
  late String _currentSugar = '0';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);
    final Stream<DocumentSnapshot> _userData = FirebaseFirestore.instance.collection('brews').doc(user.uid).snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _userData,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          throw '$snapshot.error';
        }
        //if(snapshot.hasData)print(snapshot.data!.get('name'));

        if (snapshot.hasData) {
          _currentName = snapshot.data!.get('name');
          _currentSugar = snapshot.data!.get('sugar');
          _currentStrength = snapshot.data!.get('strength');

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  //heading
                  Text('Update your profile',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20),

                  //Name entry
                  TextFormField(
                    initialValue: _currentName,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    validator: (val) => val!.isEmpty? 'Please enter your name' : null,
                    onChanged: (val){
                      _currentName = val;
                    },
                  ),
                  SizedBox(height: 20),

                  //dropdown menu for sugar
                  DropdownButtonFormField(
                    value: _currentSugar,
                    items: sugar.map((sugars){
                      return DropdownMenuItem(
                        value: sugars,
                        child: Text('$sugars sugars'),
                      );
                    }).toList(),
                    onChanged: (val){
                      setState(() {
                        _currentSugar = val.toString();
                      });
                    },
                  ),


                  //Slider for strength
                  Slider(
                    value: (_currentStrength).toDouble() ,
                    activeColor: Colors.brown[_currentStrength],
                    inactiveColor: Color(0xA1DEB3AB),
                    min:100.0 ,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val){
                      setState(() {
                        _currentStrength = val.round();
                      });
                    }),
                  SizedBox(height: 10),


                  //Submit button
                  TextButton(
                      onPressed: ()async{
                        print(_currentName);
                        print(_currentStrength);
                        print(_currentSugar);
                      },
                      child: Text('Submit')),
                ],
              ),
            ),
          );
        }
        else
          return Loading();
      }
    );
  }
}



