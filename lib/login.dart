import 'package:eventaholic/societywelcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginScreen extends StatefulWidget {
  static String id ='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CollectionReference student = FirebaseFirestore.instance.collection('student');
  CollectionReference society = FirebaseFirestore.instance.collection('society');
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Center(
                child: Text(
                  'Eventory',
                  style: TextStyle(
                    fontFamily: 'Mystical Snow',
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.w500,
                  ),

                ),
              ),
            ),
            Image(image: AssetImage('images/login.png'),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 16.0),
              child: TextField(
                textAlign:TextAlign.center,
                onChanged: (value) {
                 email=value;
                },

                cursorColor: Colors.deepOrangeAccent,
                cursorHeight: 25.0,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(

                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey.shade100),

                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 16.0),
              child: TextField(
                textAlign:TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                style: TextStyle(color: Colors.white),
                obscureText: true,
                obscuringCharacter: "*",
                cursorColor: Colors.deepOrangeAccent,
                cursorHeight: 25.0,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey.shade100),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Center(
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.poppins(

                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 100.0),
              child: GestureDetector(
                onTap: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      student.doc(user.user.uid).get().then((value) =>{
                        if( value.get('isStudent'))
                          {
                          Navigator.pushNamed(context, HomeScreen.id)
                          }
                        else
                          {
                            Navigator.pushNamed(context, SocietyWelcome.id)
                          }
                      }).catchError((err)=>print(err));
                      society.doc(user.user.uid).get().then((value) =>{
                        if( value.get('isStudent'))
                          {
                            Navigator.pushNamed(context, HomeScreen.id)
                          }
                        else
                          {
                            Navigator.pushNamed(context, SocietyWelcome.id)
                          }
                      }).catchError((err)=>print(err));

                    }
                  }
                  catch(e){
                    print(e);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  height: 50,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),


                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
