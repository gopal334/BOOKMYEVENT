import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventbookingapp/pages/Profile.dart';
import 'package:eventbookingapp/pages/booking.dart';
import 'package:eventbookingapp/pages/home.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class bottomNav extends StatefulWidget {
  const bottomNav({super.key});

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  late List<Widget> Pages;
  late homepage Home;
  late BookingPage Booking;
  late ProfilePage  Profile;
  int currentTabindex =0;
  @override
  void initState() {
    Home = homepage();
    Booking = BookingPage(userId: '',);
    Profile = ProfilePage ();
    Pages =[Home,Booking,Profile];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          items:[
            Icon(Icons.home_outlined, size: 30,color: Colors.white,),
            Icon(Icons.book_online_outlined, size: 30,color: Colors.white,),
            Icon(Icons.person_outline, size: 30,color: Colors.white,),


          ] ,
        onTap: (int index) {
         setState(() {
           currentTabindex = index;
         });
        },
      ),
      body: Pages[currentTabindex],

    );
  }
}
