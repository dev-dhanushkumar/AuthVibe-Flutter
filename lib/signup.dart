import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickauth_flutter/signin.dart';
import 'package:quickauth_flutter/user.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  Future save() async{
    var res= await http.post(
      Uri.parse("https://p066xjm1-8000.inc1.devtunnels.ms/api/auth/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'passwordConfirm': user.password,
      }),
    );
    print(res.body);
    if (res.statusCode == 201) {
      final responseBody = res.body;
      if (responseBody.contains('"status":"success"')) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
      }
    }
  }
  SignupUser user = SignupUser("", "", "", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset('images/top.svg',width: 400, height: 150,)
          ),

          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 200,),
                  Text("Signup", style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.bold,fontSize: 50,
                    color: Colors.blue
                  ),),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.name),
                      onChanged: (value) {
                        user.name = value;
                      },
                      validator: (value){
                        if(value!.isEmpty) {
                          return "Enter Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        )
                      ),
                    )
                  ),


                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.email),
                      onChanged: (value) {
                        user.email = value;
                      },
                      validator: (value){
                        if(value!.isEmpty) {
                          return "Enter Email";
                        } else if(!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                          return "Enter a valid email";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        )
                      ),
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      obscureText: true,
                      onChanged: (value) {
                        user.password = value;
                      },
                      validator: (value){
                        if(value!.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        )
                      ),
                    )
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      obscureText: true,
                      onChanged: (value) {
                        user.password = value;
                      },
                      validator: (value){
                        if(value!.isEmpty) {
                          return "Enter Confirm Password";
                        } else if (value != user.password) {
                          return "Passwords do not match";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Confirm Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.blue)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color:  Colors.red)
                        )
                      ),
                    )
                  ),


                  Padding(padding: EdgeInsets.all(16.0), child: SizedBox(
                    height: 50,
                    width: 400,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          print("ok");
                          save();
                        } else {
                          print("Not ok");
                        }
                      },
                      child: Text("Signup", style: TextStyle(color: Colors.white)),
                    )
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 7, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "Already have an account? ", 
                          style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold)
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Signin()));
                            },
                            child: Text(
                            "SignIn", 
                            style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}