import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Add user details
  Future<void> addUserDetail(
      Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .set(userInfoMap);
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  // Get user details
  Future<DocumentSnapshot> getUserDetail(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get();
  }

  // Update user details
  Future<void> updateUserDetail(
      String id, Map<String, dynamic> updateMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(updateMap);
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .delete();
  }

  // ✅ Add Event
  Future<void> addEvent(Map<String, dynamic> eventInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Event")
          .doc(id)
          .set(eventInfoMap);
    } catch (e) {
      print("Error saving event: $e");
    }
  }
  Future<Stream<QuerySnapshot>> getEvents() async {
    return await FirebaseFirestore.instance.collection("Event").snapshots();
  }
  // ✅ Add Booking
  Future<void> addBooking(Map<String, dynamic> bookingInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection("bookings")
          .add(bookingInfo);
    } catch (e) {
      print("Error saving booking: $e");
    }
  }

// ✅ Get bookings for a user
  Stream<QuerySnapshot> getUserBookings(String userId) {
    return FirebaseFirestore.instance
        .collection("bookings")
        .where("userId", isEqualTo: userId)
        .snapshots();
  }
  Stream<QuerySnapshot> eventCategories(String category) {
    return FirebaseFirestore.instance
        .collection("Event")
        .where("categor", isEqualTo: category)
        .snapshots();
  }
  Stream<QuerySnapshot> getTickets() {
    return FirebaseFirestore.instance
        .collection("bookings")

        .snapshots();
  }
}
