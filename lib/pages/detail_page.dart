import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Service/database.dart';
// <- DatabaseMethods class

class DetailPage extends StatefulWidget {
  String image, location, date, name, detail, time;
  String price;
  String userId; // 👈 current logged-in user id

  DetailPage({
    required this.image,
    required this.location,
    required this.price,
    required this.date,
    required this.name,
    required this.detail,
    required this.time,
    required this.userId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int ticket = 1;

  Map<String, dynamic>? paymentIntent;
  static const String backendUrl =
      "http://127.0.0.1:4242/create-payment-intent"; // 👈 backend URL
  DatabaseMethods dbMethods = DatabaseMethods();

  Future<void> makePayment() async {
    try {
      int amount = int.parse(widget.price) * ticket * 100;

      // 1. Call backend for PaymentIntent
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": amount,
          "currency": "inr",
          "description": widget.name,
          "metadata": {"tickets": ticket.toString()}
        }),
      );

      paymentIntent = jsonDecode(response.body);

      // 2. Init Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["clientSecret"],
          merchantDisplayName: "Event Booking App",
        ),
      );

      // 3. Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Save Booking to Firestore
      await dbMethods.addBooking({
        "userId": widget.userId,
        "eventName": widget.name,
        "eventDate": widget.date,
        "eventTime": widget.time,
        "location": widget.location,
        "tickets": ticket,
        "totalAmount": int.parse(widget.price) * ticket,
        "timestamp": FieldValue.serverTimestamp(),
      });

      // 5. Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Payment & Booking Successful!")),
      );
    } catch (e) {
      print("Payment Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Payment Failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/event.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 40, left: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month, color: Colors.white70),
                                SizedBox(width: 5),
                                Text(
                                  widget.date,
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(width: 50),
                                Icon(Icons.location_on, color: Colors.white70),
                                SizedBox(width: 5),
                                Text(
                                  widget.location,
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "About Event",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                widget.detail,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.red),
                  SizedBox(width: 5),
                  Text(widget.date, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  SizedBox(width: 5),
                  Text(widget.location, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Row(
                children: [
                  Icon(Icons.access_alarm, color: Colors.red),
                  SizedBox(width: 5),
                  Text(widget.time, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text("Number of Tickets", style: TextStyle(fontSize: 22)),
                  SizedBox(width: 20),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => ticket++),
                          child: Text("+", style: TextStyle(fontSize: 25)),
                        ),
                        Text(ticket.toString(),
                            style: TextStyle(color: Color(0xff6351ec), fontSize: 25)),
                        GestureDetector(
                          onTap: () => setState(() {
                            if (ticket > 1) ticket--;
                          }),
                          child: Text("-", style: TextStyle(fontSize: 25)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ₹${int.parse(widget.price) * ticket}",
                      style: TextStyle(
                          color: Color(0xff6351ec),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: makePayment,
                    child: Container(
                      width: 160,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xff6351ec),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
