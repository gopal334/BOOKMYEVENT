import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Service/database.dart';
import '../categories_event.dart';
import 'detail_page.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Stream? eventstream;
  String? _currentCity;

  // ✅ Method to get current city
  Future<void> _getCurrentCity() async {
    try {
      // Request permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentCity = "Location permission denied";
        });
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentCity = "Location permission permanently denied";
        });
        return;
      }

      // ✅ Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // ✅ Get placemarks (reverse geocoding)
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        setState(() {
          _currentCity = placemarks[0].locality ?? "City not found";
        });
      }
    } catch (e) {
      setState(() {
        _currentCity = "Error: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentCity(); // app start hote hi call
    onTheLoading();
  }
  onTheLoading() async {
    eventstream = await DatabaseMethods().getEvents();
    setState(() {

    });


  }


  Widget allEvent() {
    return StreamBuilder(
      stream: eventstream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            String inputDate = ds["date"];
            DateTime dateTime = DateTime.parse(inputDate);
            String formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
            String forametterTime = ds["Time"];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                image: ds["image"],
                                location: ds["location"],
                                price: ds["Price"],
                                date: ds["date"],
                                name: ds["Name"],
                                detail: ds["Detail"],
                                time: ds["Time"], userId: '',

                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/images/event.jpg",
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                     margin: EdgeInsets.only(left: 10, top: 10),
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
            formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ds["Name"] ?? "No Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "₹${ds["Price"] ?? "0"}",
                        style: TextStyle(
                          color: Color(0xff6351ec),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(
                      ds["location"] ?? "Unknown",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            );
          },
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _currentCity == null? Center(child: CircularProgressIndicator(),): Container(
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xffe3e6ff),Color(0xfff1f3ff),Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 55.0,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(_currentCity ?? "Loading...",style: TextStyle(fontSize:22,fontWeight: FontWeight.w400),)
                  ],
                ),
                SizedBox(height: 10),
                Text("Hello,Gopal",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),),
                SizedBox(height: 15),
                Text("There are 20 events\n around your location",style: TextStyle(color: Color(0xff6351ec),fontSize:25,fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(right: 17,),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),

                  child: TextField(

                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,

                      hintText: "Search a Event",icon: Icon(Icons.location_on_outlined)
                    ),
                  ),

                ),
                SizedBox(height: 14,),
                Container(
                  height: 100,
                  width: 1000,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventCategories(categories: "Music",),
                            )
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Material(
                            elevation : 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height : 10,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Image.asset("assets/images/musical.png",width: 45,height: 45,),
                                  Text("Music",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventCategories(categories: "Clothing",)
                                  )
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Material(
                            elevation : 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Image.asset("assets/images/tshirt.png",width: 45,height: 45,),
                                  Text("Clothing",style: TextStyle(color: Colors.black,fontSize:17,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventCategories(categories: "Festival",)
                                  )
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Material(
                            elevation : 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Image.asset("assets/images/confetti.png",width: 45,height: 45,),
                                  Text("Festival",style: TextStyle(color: Colors.black,fontSize:17,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventCategories(categories: "Food",)
                                  )
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Material(
                            elevation : 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(

                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Image.asset("assets/images/dish.png",width: 45,height: 45,),
                                  Text("Food",style: TextStyle(color: Colors.black,fontSize:17,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upcoming Events",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text("See All",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              //  SizedBox(height: ,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: allEvent(),
                        )
                  ],

                ),




              ],
            ),

          ),
        ),
      ),
    );
  }
}
