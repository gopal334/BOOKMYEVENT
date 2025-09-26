import 'package:eventbookingapp/Service/shared_ref.dart';
import 'package:eventbookingapp/Service/auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username = "";
  String? email = "";
  String? userId = "";
  String? imageUrl = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? getUserName = await SharedPreferenceHelper().getUserName();
    String? getUserEmail = await SharedPreferenceHelper().getUserEmail();
    String? getUserId = await SharedPreferenceHelper().getUserId();
    String? getUserImage = await SharedPreferenceHelper().getUserImage();

    setState(() {
      username = getUserName ?? "Guest User";
      email = getUserEmail ?? "No Email";
      userId = getUserId ?? "N/A";
      imageUrl = getUserImage ??
          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"; // default avatar
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Image
              CircleAvatar(
                radius: 60,
                backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                    ? NetworkImage(imageUrl!)
                    : const NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
              ),
              const SizedBox(height: 20),

              // Username
              Text(
                username ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Email
              Text(
                email ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),

              // User Id
              Text(
                "User ID: ${userId ?? ""}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  await Authmethods().signOut(context);
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
