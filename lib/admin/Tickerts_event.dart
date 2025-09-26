import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventTickets extends StatefulWidget {
  const EventTickets({super.key});

  @override
  State<EventTickets> createState() => _EventTicketsState();
}

class _EventTicketsState extends State<EventTickets> {
  Stream? bookingStream;

  @override
  void initState() {
    super.initState();
    bookingStream = FirebaseFirestore.instance.collection("bookings").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Event Tickets",
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.purple),
      ),
      body: StreamBuilder(
        stream: bookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data.docs.isEmpty) {
            return const Center(child: Text("No booking found"));
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              String userId = ds["userId"] ?? "";

              if (userId.isEmpty) {
                // 🔹 Agar userId empty hai → direct show karo
                return _buildTicketCard(
                  location: ds["location"] ?? "Unknown",
                  eventName: ds["eventName"] ?? "No Event",
                  eventDate: ds["eventDate"] ?? "",
                  userName: "Unknown User",
                  tickets: ds["tickets"] ?? 0,
                  totalAmount: ds["totalAmount"] ?? 0,
                );
              }

              // 🔹 Agar userId hai → fetch user data
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection("users").doc(userId).get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const SizedBox();
                  }

                  var userData = userSnapshot.data!.data() as Map<String, dynamic>?;
                  String userName = userData?["name"] ?? "Unknown User";

                  return _buildTicketCard(
                    location: ds["location"] ?? "Unknown",
                    eventName: ds["eventName"] ?? "No Event",
                    eventDate: ds["eventDate"] ?? "",
                    userName: userName,
                    tickets: ds["tickets"] ?? 0,
                    totalAmount: ds["totalAmount"] ?? 0,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  /// 🔹 Helper Widget to Build Ticket Card
  Widget _buildTicketCard({
    required String location,
    required String eventName,
    required String eventDate,
    required String userName,
    required int tickets,
    required int totalAmount,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Location
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Card Body
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              eventName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 5),
                    Text(eventDate),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 5),
                    Text(userName),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.confirmation_num, size: 16),
                    const SizedBox(width: 5),
                    Text("$tickets"),
                    const SizedBox(width: 15),
                    const Icon(Icons.currency_rupee, size: 16, color: Colors.green),
                    Text(
                      "$totalAmount",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
