import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUp extends StatefulWidget {
  static String id ='sign_up';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  CollectionReference student = FirebaseFirestore.instance.collection('student');
  final _auth=FirebaseAuth.instance;
  String name;
  String password;
  String email;
  String phone;


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
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
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
            ),
            Image(image: AssetImage('images/login.png'),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                textAlign:TextAlign.center,
                onChanged: (value) {
                  name=value;
                },
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.deepOrangeAccent,
                cursorHeight: 25.0,
                decoration: InputDecoration(

                  hintText: 'Name',
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
                  email=value;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.deepOrangeAccent,
                cursorHeight: 25.0,
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
                  phone=value;
                },
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.deepOrangeAccent,
                cursorHeight: 25.0,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  hintText: 'Phone Number',
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
                cursorColor: Colors.deepOrangeAccent,
                cursorHeight: 25.0,
                obscureText: true,
                obscuringCharacter: "*",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 100.0),
              child: GestureDetector(
                onTap: () async {


                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser!=null){
                      print(newUser.user.uid);
                      student.doc(newUser.user.uid).set({
                        'email': email,
                        'name': name,
                        'password': password,
                        'phone': phone,
                        'isStudent':true,
                      }).then((value)=>print("data added")).catchError((error)=>print(error));
                      Navigator.pushNamed(context, HomeScreen.id);

                    }
                  }catch(e){print(e);}


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
                      'Sign Up',
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
