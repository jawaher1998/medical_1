import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_utils/app_utils.dart';
import 'package:medical_1/Patients/clinet.dart';
import 'dart:io';

import 'package:medical_1/style/color/color.dart';


class booking extends StatefulWidget {
  booking();

  @override
  bookingstate createState() => bookingstate();
}

class bookingstate extends State<booking> {

  dynamic slecteddoctor = "0";
  final now = DateTime.now();
  late BookingService mockBookingService ;
String namedoctor ="";
  @override

  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService =
        BookingService(
            serviceName: 'Mock Service',
            serviceDuration: 30,
            bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
            bookingStart: DateTime(now.year, now.month, now.day, 8, 0)

        );

  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  // Future<dynamic> uploadBookingMock(
  //     {required BookingService newBooking}) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   converted.add(DateTimeRange(
  //       start: newBooking.bookingStart, end: newBooking.bookingEnd));
  //   print('${newBooking.toJson()} has been uploaded');
  // }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }
  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }
  CollectionReference Abooking = FirebaseFirestore.instance.collection('Abooking');

  Future<dynamic> uploadBookingFirebase(
      {required BookingService newBooking}) async {
    await Abooking.add(newBooking.toJson())
        .then((value) => print("Booking Added"))
        .catchError((error) => print("Failed to add booking: $error"));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: tLPurple,
        appBar: AppBar(
            backgroundColor: tLPurple,
            title: Text("حجز موعد"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Column(
            children: <Widget>[
         Padding(padding: EdgeInsets.all(15),
         child: Text("اختار من فضلك أسم الدكتور", style: TextStyle(fontSize: 18),),) ,
              Expanded(
                  child:
                  Column(

                      children:[

                  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('User_Doctor').snapshots(),
              builder: (context, snapshot) {
                List<DropdownMenuItem> doctoritem = [];
                if (!snapshot.hasData) {
                  const CircularProgressIndicator();
                } else {
                  final doctors = snapshot.data?.docs.reversed.toList();

                  doctoritem.add(
                    DropdownMenuItem(
                      value: "0",
                      child:Text("اسم الدكتورة"),
                    ),
                  );
                  for (var doctor in doctors!) {


                    doctoritem.add(

                 DropdownMenuItem(
                          value: doctor.id,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [

                              Text(doctor['displayName'],),


                            ],
                          ),
                        ),
                    );

                  }

                }

                return DropdownButton(

                  borderRadius: BorderRadius.all(Radius.circular(17)),
                  items: doctoritem,
                  onChanged: (docotoValue) {
                    print(docotoValue);
                    setState(() {
                      slecteddoctor = docotoValue;
                      late   Map<String,String> data ={
                        'id':slecteddoctor
                      };
                      FirebaseFirestore.instance.collection("booking_id").add(data);
                    });

                  },

                  value: slecteddoctor,
                  isExpanded: false,

                );

              }),

          Expanded(
            child: BookingCalendar(
            bookingService: mockBookingService,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingFirebase,
            pauseSlotText: 'LUNCH',
            hideBreakTime: false,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            loadingWidget: const Text('Fetching data...'),
            startingDayOfWeek: StartingDayOfWeek.tuesday,
            wholeDayIsBookedWidget:
            const Text('Sorry, for this day everything is booked'),
              bookingButtonColor:  tDarkPurple,
             bookingButtonText: "حجز موعد",

          ),
          ),
        ]
        ),
      ),
    ]
    ),
      ),

    );
  }
}
@JsonSerializable(explicitToJson: true)
class SportBooking {
  /// The generated code assumes these values exist in JSON.
  final String? userId;
  final String? userName;
  final String? placeId;
  final String? serviceName;
  final int? serviceDuration;
  final int? servicePrice;
  final DateTime? bookingStart;
  final DateTime? bookingEnd;
  final String? email;
  final String? phoneNumber;
  final String? placeAddress;

  SportBooking(
      {this.email,
        this.phoneNumber,
        this.placeAddress,
        this.bookingStart,
        this.bookingEnd,
        this.placeId,
        this.userId,
        this.userName,
        this.serviceName,
        this.serviceDuration,
        this.servicePrice});


}

