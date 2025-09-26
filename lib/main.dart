import 'package:eventbookingapp/pages/Signup.dart';
import 'package:eventbookingapp/pages/bottomNav.dart';
import 'package:eventbookingapp/pages/detail_page.dart';
import 'package:eventbookingapp/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'Service/auth_check.dart';
import 'admin/admin_dashboard.dart';
import 'admin/admin_logi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Stripe.publishableKey =
  "pk_test_51S1uO630BnVAj8iajjSPvBhruvsX9wrr2NV2yIt91CNl0qs0xDsORSeD2Ddcmien78DhWpf321ckKmL7sYDQuRUJ00eYyHuQHc";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Booking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: const AuthCheck(), // 👈 yaha se decide hoga login hai ya nahi
home : homepage(),
      routes: {
        '/detail': (context) => DetailPage(
          image: "",
          location: "",
          price: "",
          date: "",
          name: "",
          detail: "",
          time: "",
          userId: '',
        ),
        '/signup': (context) => const signupPage(),
        '/bottom': (context) => const bottomNav(),
      },
    );
  }
}
