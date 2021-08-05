import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Color(0xFFDCC7C0),
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text('Brew Crew'),
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
                  validator: (val) => val!.isEmpty ? 'Enter email': null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  }
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Password'
                  ),
                  validator: (val) => val!.length<6 ? 'Password must contain atleast 6 characters':null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  }
                ),
                SizedBox(height: 20),
                TextButton(onPressed: ()async{
                  
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null) {
                      setState(() {
                          error = 'Invalid Credentials';
                          loading = false;
                      });
                    }
                  }
                },
                    child: Text('Login')),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text('New User? Register'),
                      TextButton(onPressed: (){
                        widget.toggleView();
                      },
                          child: Text('Create New Account')),
                  ],
                  ),
                ),
                SizedBox(height: 20),
                Text(error,style: TextStyle(color: Colors.red),),
              ],
            )
        ),
      ),
    );
  }
}
