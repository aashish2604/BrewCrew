import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late int _currentStrength;
  late String _currentSugar = '0';

  @override
  Widget build(BuildContext context) {
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
                value: _currentSugar ?? '0',
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


            //Submit button
            TextButton(
                onPressed: ()async{
                  print(_currentName);
                  //print(_currentStrength);
                  print(_currentSugar);
                },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
