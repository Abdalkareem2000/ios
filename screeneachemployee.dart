// ignore_for_file: file_names, camel_case_types, override_on_non_overriding_member, unused_import, duplicate_import, avoid_web_libraries_in_flutter, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, no_logic_in_create_state, unnecessary_this, unused_local_variable, unused_field, deprecated_member_use, valid_regexps, avoid_init_to_null, missing_return, unused_element, missing_required_param, prefer_const_literals_to_create_immutables, duplicate_ignore, empty_statements, dead_code, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_application_6/Homescreen.dart';
import 'package:flutter_application_6/employeeScreen.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'dart:html';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'signup.dart';
import 'package:flutter_application_6/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Clendar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PraEmployeSc extends StatelessWidget {
  final user, previous, Namebook;
  PraEmployeSc({Key key, this.user, this.previous, this.Namebook})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrEmpSc(
        user: user,
        previous: previous,
        Namebook: Namebook,
      ),
    );
  }
}

class PrEmpSc extends StatefulWidget {
  final user, previous, Namebook;

  PrEmpSc({Key key, this.user, this.previous, this.Namebook}) : super(key: key);

  @override
  _PrEmpSc createState() => _PrEmpSc(user, previous, Namebook);
}

class _PrEmpSc extends State<PrEmpSc> {
  var empcontrating1;
  var empcontrating;
  double empratestar;
  var emprate;
  var empname;
  double rateemp = 0;
  int count = 0;
  final user, previous, Namebook;
  _PrEmpSc(this.user, this.previous, this.Namebook);
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime dateTime = null;
  DateTime dateTime1 = null;
  TextEditingController comment = TextEditingController();
  String get comment1 => comment.text;
  TextEditingController Problem = TextEditingController();
  String get Problem1 => Problem.text;
  TextEditingController feedback = TextEditingController();
  String get feedback1 => feedback.text;
  double rate = 0;
  String get rate1 => rate.toString();
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

  Future insertcomment() async {
    String Url =
        "https://mailed-interchange.000webhostapp.com/insertcomment.php";
    var res = await http.post(Uri.parse(Url),
        headers: {"Accept": "application/json"},
        body: {"name": Namebook['name'], "Comment": comment1});
    var respBody = json.decode(res.body);

    if (respBody == "Success") {
      comment = null;
      Fluttertoast.showToast(
        msg: "Comment Okay",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PraEmployeSc(
                    user: user,
                    previous: previous,
                    Namebook: Namebook,
                  )));
    } else {
      Fluttertoast.showToast(
        msg: "Add Comment!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    }
  }

  String getDTstart() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    }
  }

  String getDTend() {
    if (dateTime1 == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime1);
    }
  }

  Future insertMethod() async {
    String Url =
        "http://mailed-interchange.000webhostapp.com/insertDateTime.php";
    var res = await http.post(Uri.parse(Url), headers: {
      "Accept": "application/json"
    }, body: {
      "nameuser": Namebook['name'],
      "numberuser": Namebook['number'],
      "emailuser": Namebook['email'],
      "startTime": getDTstart(),
      "endTime": getDTend(),
    });
    var respBody = json.decode(res.body);

    if (respBody == "Success") {
      Fluttertoast.showToast(
        msg: "Okay book",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Clr(
                  user: user,
                  previous: user,
                  previous2: previous,
                  Namebook: Namebook)));
    } else if (respBody == "Error") {
      Fluttertoast.showToast(
        msg: "Enter Start Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else if (respBody == "Delete") {
      Fluttertoast.showToast(
        msg: "invalid Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else if (respBody == "invalid end Time") {
      Fluttertoast.showToast(
        msg: "invalid End Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else if (respBody == "invalid Start Time") {
      Fluttertoast.showToast(
        msg: "invalid Start Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Enter End Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    }
  }

  Future deletMethod() async {
    String Url = "http://mailed-interchange.000webhostapp.com/DeletBooking.php";
    var res = await http.post(Uri.parse(Url), headers: {
      "Accept": "application/json"
    }, body: {
      "emailuser": Namebook['email'],
      "startTime": getDTstart(),
      "endTime": getDTend(),
    });
    var respBody = json.decode(res.body);

    if (respBody == "Success") {
      Fluttertoast.showToast(
        msg: "Okay Unbook",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Clr(
                  user: user,
                  previous: user,
                  previous2: previous,
                  Namebook: Namebook)));
    } else if (respBody == "Error") {
      Fluttertoast.showToast(
        msg: "Enter Start Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else if (respBody == "Error2") {
      Fluttertoast.showToast(
        msg: "You Don't have book at this time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else if (respBody == "invalid end Time") {
      Fluttertoast.showToast(
        msg: "You Don't have book at this time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else if (respBody == "invalid Start Time") {
      Fluttertoast.showToast(
        msg: "You Don't have book at this time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Enter End Time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 20.0,
        webPosition: "center",
        timeInSecForIosWeb: 4,
      );
    }
  }

  Future fetchPhotos() async {
    var res = await http.get(Uri.parse(
        "https://mailed-interchange.000webhostapp.com/getdataemployee.php"));
    if (res.statusCode == 200) {
      var obj = json.decode(res.body);

      return obj;
    }
  }

  Future getComments() async {
    var res = await http.get(Uri.parse(
        "https://mailed-interchange.000webhostapp.com/getcomments.php"));
    if (res.statusCode == 200) {
      var obj = json.decode(res.body);

      return obj;
    }
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: dateTime ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return null;
    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 8, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );
    if (newTime == null) return null;

    return newTime;
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;
    final time = await pickTime(context);
    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future pickDateTime1(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;
    final time = await pickTime(context);
    if (time == null) return;
    setState(() {
      dateTime1 = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void showRating(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Rate $empname"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Please leave a star rating.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  RatingBar.builder(
                    //initialRating: empratestar,
                    itemSize: 46,
                    minRating: 1,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newrating) {
                      setState(() {
                        this.rateemp = newrating;
                      });
                    },
                    updateOnDrag: true,
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PraEmployeSc(
                                  user: user,
                                  previous: previous,
                                  Namebook: Namebook,
                                )));
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ));
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
                                builder: (context) => PraEmployeSc(
                                      user: user,
                                      previous: previous,
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
                                builder: (context) => PraEmployeSc(
                                      user: user,
                                      previous: previous,
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
                                builder: (context) => PraEmployeSc(
                                      user: user,
                                      previous: previous,
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
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    var height = 1000;
    empcontrating = user['countrating'];
    emprate = user['rating'];
    empratestar = double.parse('$emprate');
    empname = user['Name'];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    List<Widget> _widgetOptions = <Widget>[
      Container(
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
                  height: height * 0.05,
                ),
                Text(
                  "Booking",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  "Start Time",
                  style: TextStyle(fontSize: 22, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                FlatButton(
                  child: Text(
                    getDTstart(),
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  onPressed: () {
                    pickDateTime(context);
                  },
                  minWidth: 50,
                  height: 60,
                  color: Colors.black,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "End Time",
                  style: TextStyle(fontSize: 22, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                FlatButton(
                  child: Text(
                    getDTend(),
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  onPressed: () {
                    pickDateTime1(context);
                  },
                  minWidth: 50,
                  height: 60,
                  color: Colors.black,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      child: const Icon(Icons.table_chart),
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Open Table Time",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 20.0,
                          webPosition: "center",
                          timeInSecForIosWeb: 5,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Clr(
                                      user: user,
                                      previous: user,
                                      previous2: previous,
                                      Namebook: Namebook,
                                    )));
                      },
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        deletMethod();
                      },
                      child: Text(
                        "UnBook",
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF363f93)),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        insertMethod();
                      },
                      child: Text(
                        "Book",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF363f93)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
      Center(
        child: FutureBuilder(
          future: getComments(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Container(
                  child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                          title: Text(snapShot.data[index]['Name']),
                          subtitle: Text(snapShot.data[index]['Comment']),
                        );
                      },
                      itemCount: snapShot.data.length,
                    ),
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: comment,
                    decoration: InputDecoration(
                        labelText: "Write Comment...",
                        prefixIcon: Icon(
                          Icons.comment,
                          color: Color(0xFF363f93),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Color(0xFF363f93),
                          ),
                          onPressed: () {
                            setState(() {
                              insertcomment();
                            });
                          },
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter correct phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ));
            }
          },
        ),
      ),
      Center(
          child: FutureBuilder(
        future: fetchPhotos(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rate:$empratestar   /$empcontrating",
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 32,
                ),
                SmoothStarRating(
                  color: Colors.amber,
                  rating: empratestar,
                  isReadOnly: true,
                  size: 46,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                    onPressed: () {
                      showRating(context);
                    },
                    child: Text(
                      "Rate $empname",
                      style: TextStyle(fontSize: 32),
                    ))
              ],
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => employeSc(
                            user: previous,
                            Namebook: Namebook,
                          )));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(user['Name']),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.home),
            title: Text("Booking"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.comment),
            title: Text("Comments"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.rate_review_outlined),
            title: Text("Rating"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
