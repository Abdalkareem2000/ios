// ignore_for_file: avoid_web_libraries_in_flutter, unused_import, duplicate_import, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, unused_element, non_constant_identifier_names, unused_local_variable, deprecated_member_use, must_be_immutable, dead_code, unrelated_type_equality_checks, avoid_print

import 'dart:developer';
import 'dart:html';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'Homescreen.dart';
import 'package:flutter_application_6/main.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/cupertino.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _SignUp(),
    );
  }
}

class _SignUp extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => SignUpPage();
}

class SignUpPage extends State<_SignUp> {
  final formKey = GlobalKey<FormState>();
  bool pa = true, pas = true;
  bool pa1 = true, pas1 = true;
  TextEditingController email2 = TextEditingController();
  String get email3 => email2.text;
  TextEditingController password2 = TextEditingController();
  String get password3 => password2.text;
  TextEditingController name = TextEditingController();
  String get name1 => name.text;
  TextEditingController number = TextEditingController();
  String get number1 => number.text;
  Future insertMethod(BuildContext cont) async {
    String Url = "https://mailed-interchange.000webhostapp.com/insertdb.php";
    var res = await http.post(Uri.parse(Url), headers: {
      "Accept": "application/json"
    }, body: {
      "name": name1,
      "number": number1,
      "email": email3,
      "password": password3,
    });
    var respBody = json.decode(res.body);
    if (respBody == "Success") {
      Fluttertoast.showToast(
        msg: "SignUp successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeS(
                    Namebook: {
                      "name": name1,
                      "number": number1,
                      "email": email3,
                      "password": password3
                    },
                  )));
    } else if (respBody == "Error") {
      Fluttertoast.showToast(
        msg: "The email is already exist!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else {
      Fluttertoast.showToast(
        msg: "The number is already exist!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = 1000;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Home Helper'),
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.only(left: 40, right: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    "Sign up",
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF363f93),
                      ),
                      labelText: "Enter your name",
                    ),
                    validator: (value) {
                      var value1 = value;
                      bool b = true;
                      var match = RegExp(r'^[a-z A-Z]+$').hasMatch(value1);
                      if (RegExp(r'^[a-z A-Z]+$').hasMatch(value1)) {
                        b = false;
                      }
                      if (value.isEmpty || b) {
                        return "Enter correct name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                      labelText: "Enter your number",
                      prefixIcon: Icon(
                        Icons.call,
                        color: Color(0xFF363f93),
                      ),
                    ),
                    validator: (value) {
                      var value1 = value;
                      bool c = true;
                      if (RegExp(
                              r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                          .hasMatch(value1)) {
                        c = false;
                      }
                      if (value1.isEmpty || c) {
                        return "Enter correct phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: email2,
                    decoration: InputDecoration(
                      labelText: "Enter your email",
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Color(0xFF363f93),
                      ),
                    ),
                    validator: (value) {
                      var value1 = value;
                      bool w = true;
                      if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                          .hasMatch(value1)) {
                        w = false;
                      }
                      if (value1.isEmpty || w) {
                        return "Enter correct email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    obscureText: pa,
                    controller: password2,
                    decoration: InputDecoration(
                        helperText:
                            "should contain at least one upper case and lower case and digit and Special character and 8 characters in length",
                        labelText: "Enter your Password",
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xFF363f93),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            pa ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xFF363f93),
                          ),
                          onPressed: () {
                            setState(() {
                              pa = !pa;
                              pas = !pas;
                            });
                          },
                        )),
                    validator: (value) {
                      var value1 = value;
                      bool w = true;
                      if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                          .hasMatch(value1)) {
                        w = false;
                      }
                      if (value1.isEmpty || w) {
                        return "invalid password should contain at least one upper case and lower case and digit and Special character and 8 characters in length";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  TextFormField(
                    obscureText: pa1,
                    decoration: InputDecoration(
                        labelText: "Enter password again",
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xFF363f93),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            pa1 ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xFF363f93),
                          ),
                          onPressed: () {
                            setState(() {
                              pa1 = !pa1;
                              pas1 = !pas1;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value.isEmpty || password2.text != value) {
                        return "Enter correct password again";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      FloatingActionButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            insertMethod(context);
                          }
                        },
                        child: const Icon(Icons.login),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
