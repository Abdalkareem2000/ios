// ignore_for_file: avoid_web_libraries_in_flutter, unused_import, duplicate_import, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, unused_element, non_constant_identifier_names, unused_local_variable, deprecated_member_use, must_be_immutable, file_names, avoid_print, prefer_const_literals_to_create_immutables, missing_required_param, prefer_typing_uninitialized_variables, no_logic_in_create_state, prefer_final_fields, unused_field, dead_code

import 'dart:developer';

import 'dart:html';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'signup.dart';
import 'package:flutter_application_6/main.dart';
import 'employeeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeS extends StatefulWidget {
  final Namebook;

  const HomeS({Key key, this.Namebook}) : super(key: key);
  @override
  _HomeSc createState() => _HomeSc(Namebook);
}

class _HomeSc extends State<HomeS> {
  final Namebook;

  _HomeSc(this.Namebook);
  var height = 1000;
  int _selectedIndex = 0;
  TextEditingController Problem = TextEditingController();
  String get Problem1 => Problem.text;
  TextEditingController feedback = TextEditingController();
  String get feedback1 => feedback.text;
  double rate = 0;
  String get rate1 => rate.toString();
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future fetchPhotos() async {
    var res = await http.get(Uri.parse(
        "https://mailed-interchange.000webhostapp.com/getdataservice.php"));
    if (res.statusCode == 200) {
      var obj = json.decode(res.body);

      return obj;
    }
  }

  Future insertcontactus() async {
    String Url =
        "https://mailed-interchange.000webhostapp.com/insertcontactus.php";
    var res = await http.post(Uri.parse(Url), headers: {
      "Accept": "application/json"
    }, body: {
      "name": Namebook['name'],
      "number": Namebook['number'],
      "email": Namebook['email'],
      "Problem": Problem1
    });
    var respBody = json.decode(res.body);

    if (respBody == "Success") {
      Fluttertoast.showToast(
        msg: "we will contact you on whatsapp",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
      Problem = null;
    } else {
      Fluttertoast.showToast(
        msg: "Add Problem!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    }
  }

  Future insertratefeedback() async {
    String Url =
        "https://mailed-interchange.000webhostapp.com/insertratefeedback.php";
    var res = await http.post(Uri.parse(Url), headers: {
      "Accept": "application/json"
    }, body: {
      "name": Namebook['name'],
      "number": Namebook['number'],
      "email": Namebook['email'],
      "rate": rate1,
      "feedback": feedback1
    });
    var respBody = json.decode(res.body);

    if (respBody == "Success") {
      Fluttertoast.showToast(
        msg: "Thank You",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
      rate = 0;
      feedback = null;
    } else if (respBody == "Error") {
      Fluttertoast.showToast(
        msg: "Please Rate App",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else {
      Fluttertoast.showToast(
        msg: "please Write Feedback",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    }
  }

  void ContactUs(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Contact Us"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Please Enter Subject',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: Problem,
                    decoration: InputDecoration(
                      labelText: "Write Subject...",
                      prefixIcon: Icon(
                        Icons.comment,
                        color: Color(0xFF363f93),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter correct phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeS(
                                      Namebook: Namebook,
                                    )));
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        insertcontactus();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  void feedbackandrating(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Rate and feedback"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rate',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  RatingBar.builder(
                    itemSize: 46,
                    //itemPadding: EdgeInsets.symmetric(horizontal: 4),
                    minRating: 1,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newrating) {
                      setState(() {
                        rate = newrating;
                      });
                    },
                    updateOnDrag: true,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: feedback,
                    decoration: InputDecoration(
                      labelText: "Write feedback...",
                      prefixIcon: Icon(
                        Icons.comment,
                        color: Color(0xFF363f93),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeS(
                                      Namebook: Namebook,
                                    )));
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        insertratefeedback();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  void Logout(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure??"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeS(
                                      Namebook: Namebook,
                                    )));
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Center(
          child: FutureBuilder(
        future: fetchPhotos(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: Text(snapShot.data[index]['services']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => employeSc(
                                  user: snapShot.data[index],
                                  Namebook: Namebook,
                                )));
                  },
                );
              },
              itemCount: snapShot.data.length,
            );
          }
        },
      )),
      Center(
          child: FutureBuilder(
        future: fetchPhotos(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemBuilder: (_, index) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        Namebook['name'],
                        style:
                            TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      FlatButton(
                        child: Text(
                          "Contact Us",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        onPressed: () {
                          ContactUs(context);
                        },
                        minWidth: 50,
                        height: 60,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      FlatButton(
                        child: Text(
                          "Feedback And Rating App",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        onPressed: () {
                          feedbackandrating(context);
                        },
                        minWidth: 50,
                        height: 60,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      FlatButton(
                        child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        onPressed: () {
                          Logout(context);
                        },
                        minWidth: 50,
                        height: 60,
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              },
              itemCount: 1,
            );
          }
        },
      )),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(Icons.logout)),
        title: Text('Services'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      )
      /*Center(
          child: FutureBuilder(
        future: fetchPhotos(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: Text(snapShot.data[index]['services']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => employeSc(
                                  user: snapShot.data[index],
                                  Namebook: Namebook,
                                )));
                  },
                );
              },
              itemCount: 4,
            );
          }
        },
      ))*/
      ,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
