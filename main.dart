// ignore_for_file: avoid_web_libraries_in_flutter, unused_import, duplicate_import, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, unused_local_variable, must_be_immutable, valid_regexps, prefer_const_literals_to_create_immutables, duplicate_ignore, deprecated_member_use, override_on_non_overriding_member, unused_element, avoid_print, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_6/main.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'Homescreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => MyHomePage();
}

class MyHomePage extends State<_MyHomePage> {
  Future fetchPhotos() async {
    var res = await http.get(
        Uri.parse("https://mailed-interchange.000webhostapp.com/users.php"));
    if (res.statusCode == 200) {
      var obj = json.decode(res.body);
      return obj;
    }
  }

  var x;
  bool passwordVisible = true;
  var p = true;
  TextEditingController email = TextEditingController();
  String get email1 => email.text;
  TextEditingController password = TextEditingController();
  String get password1 => password.text;
  @override
  Widget build(BuildContext context) {
    Future loginMethod(var e) async {
      String Url = "https://mailed-interchange.000webhostapp.com/login.php";
      var res = await http.post(Uri.parse(Url), body: {
        "email": email1,
        "password": password1,
      });
      var respBody = json.decode(res.body);
      if (respBody == "Success") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeS(
                      Namebook: e,
                    )));
      } else {
        Fluttertoast.showToast(
          msg: "The email or password is not correct!!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 20.0,
          webPosition: "center",
          timeInSecForIosWeb: 4,
        );
      }
    }

    var height = 1000;
    final formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var m = MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Home Helper",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF363f93), fontSize: 40),
              ),
              //centerTitle: Center(),
            ),
            backgroundColor: Color(0xFFffffff),
            body: FutureBuilder(
                future: fetchPhotos(),
                // ignore: missing_return
                builder: (ctx, snapShot) {
                  return Container(
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 30, color: Color(0xFF363f93)),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                labelText: "Enter your email",
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                  color: Color(0xFF363f93),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                bool w = true;
                                if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                    .hasMatch(value)) {
                                  w = false;
                                }
                                if (value.isEmpty || w) {
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
                              controller: password,
                              obscureText: p,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  labelText: "Enter your Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF363f93),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFF363f93),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                        p = !p;
                                      });
                                    },
                                  )),
                              validator: (value) {
                                var value1 = value;
                                bool w = true;
                                if (RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                    .hasMatch(value1)) {
                                  w = false;
                                }
                                if (value1.isEmpty || w) {
                                  return "Enter correct password";
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
                                FlatButton(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 22, color: Color(0xFF363f93)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    //             if (formKey.currentState.validate()) {
                                    for (int i = 0;
                                        i < snapShot.data.length;
                                        i++) {
                                      if (snapShot.data[i]['email']
                                              .toLowerCase() ==
                                          email1.toLowerCase()) {
                                        x = snapShot.data[i];
                                      }
                                    }

                                    loginMethod(x);
                                    //              }
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
                  );
                })));
    return m;
  }
}
