import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventbookingapp/pages/detail_page.dart';
import 'package:flutter/material.dart';
import '../Service/database.dart';

class EventCategories extends StatefulWidget {
  final String categories;

  EventCategories({required this.categories});

  @override
  State<EventCategories> createState() => _EventCategoriesState();
}

class _EventCategoriesState extends State<EventCategories> {
  Stream? eventstream;

  @override
  void initState() {
    super.initState();
    eventstream = DatabaseMethods().eventCategories(widget.categories);
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
            

            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
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
                  Container(
                    child: Column(
                      children: [
                        Text(
                          ds["Detail" ] ?? "No detail",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Date-",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           SizedBox(width: 15, height: 5,),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Text(
                              "Show Timing - ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),


                            ),
                            Text(
                               ds["Time"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),

                            ),
                          ],
                        ),
                      ],
                    )



                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categories,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 35),),
        centerTitle: true,
      ),
      body: allEvent(),

    );
  }
}
