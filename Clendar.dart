// ignore: file_names
// ignore: file_names
// ignore_for_file: unused_import, duplicate_import, file_names, avoid_web_libraries_in_flutter, duplicate_ignore, use_key_in_widget_constructors, unused_element, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, no_logic_in_create_state, prefer_const_constructors, unnecessary_this, missing_return, avoid_unnecessary_containers, avoid_print, unused_field, unused_local_variable, unused_label, empty_statements, prefer_const_declarations, unnecessary_null_in_if_null_operators, dead_code, non_constant_identifier_names

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/Homescreen.dart';
import 'dart:developer';
import 'dart:html';
import 'package:flutter_application_6/main.dart';
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
import 'employeeScreen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'screeneachemployee.dart';

class Clr extends StatelessWidget {
  final user;
  final previous, previous2, Namebook;

  Clr({Key key, this.previous, this.user, this.previous2, this.Namebook})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Clra(
        user: user,
        previous: previous,
        previous2: previous2,
        Namebook: Namebook,
      ),
    );
  }
}

class Clra extends StatefulWidget {
  final user, previous, previous2, Namebook;

  Clra({Key key, this.user, this.previous, this.previous2, this.Namebook})
      : super(key: key);
  @override
  _Clra createState() => _Clra(previous, user, previous2, Namebook);
}

class _Clra extends State<Clra> {
  final previous, user, previous2, Namebook;
  List<Appointment> book = <Appointment>[];
  var name;
  var email;
  var number;

  _Clra(this.previous, this.user, this.previous2, this.Namebook);
  Future fetchPhotos() async {
    var res = await http.get(Uri.parse(
        "https://mailed-interchange.000webhostapp.com/bookingmonica.php"));
    if (res.statusCode == 200) {
      var obj = json.decode(res.body);
      return obj;
    }
  }

  // ignore: prefer_final_fields
  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PraEmployeSc(
                              user: previous,
                              previous: previous2,
                              Namebook: Namebook,
                            )));
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(previous['Name']),
        ),
        body: FutureBuilder(
            future: fetchPhotos(),
            builder: (ctx, snapShot) {
              name = Namebook['name'];
              number = Namebook['number'];
              email = Namebook['email'];
              for (int i = 0; i < snapShot.data.length; i++) {
                final DateTime startTime =
                    DateTime.parse(snapShot.data[i]['startTime']);
                final DateTime endTime =
                    DateTime.parse(snapShot.data[i]['endTime']);
                if (snapShot.data[i]['emailuser'] == Namebook['email']) {
                  book.add(Appointment(
                      startTime: startTime,
                      endTime: endTime,
                      subject: "Name:$name  Email:$email  Number:$number",
                      color: Colors.blue));
                } else {
                  book.add(Appointment(
                      startTime: startTime,
                      endTime: endTime,
                      color: Colors.red));
                }
              }
              return SfCalendar(
                view: CalendarView.week,
                firstDayOfWeek: 6,
                //initialSelectedDate: DateTime.now(),
                //initialDisplayDate: DateTime.now(),
                dataSource: MeetingDataSource(getAppointments(book)),
              );
            }));
  }
}

Future fetchPhotos() async {
  var res = await http.get(Uri.parse(
      "https://mailed-interchange.000webhostapp.com/bookingmonica.php"));
  if (res.statusCode == 200) {
    var obj = json.decode(res.body);

    return obj;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

List<Appointment> getAppointments(List<Appointment> m) {
  List<Appointment> book = m;
  return book;
}
