import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email='';
  String password = '';
  String conformPassword='';
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Color(0xFFDCC7C0),
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        width: 400,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                    validator: (val) => val!.isEmpty? 'Please enter email':null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                    validator: (val)=> val!.length<6?'The password must contain atleast 6 characters':null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                    onChanged: (val){
                      setState(() {
                        conformPassword = val;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextButton(onPressed: ()async{

                  if (_formKey.currentState!.validate()) {
                    if (password == conformPassword) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      setState(() {
                        if(result==null)
                          error = 'Please supply a valid email';
                      });
                    }
                    else{
                      setState(() {
                        error = 'Password and confirm password should be same';
                        loading = false;
                      });
                    }

                  }
                },
                    child: Text('Register')),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text('Already Registered? Sign In'),
                      TextButton(onPressed: (){
                        widget.toggleView();
                      },
                          child: Text('Sign In')),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 15),),
              ],
            )
        ),
      ),
    );
  }
}
