import 'package:flutter/material.dart';

import '../Service/auth.dart';
import '../admin/admin_logi.dart';
class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Image.asset('assets/images/onboarding.png',
            ),
            Text("Unlock the Future of",style: TextStyle(color: Colors.black,fontSize:30,fontWeight: FontWeight.bold),),
            Text("Event Booking App",style: TextStyle(color: Color(0xff6351ec),fontSize:25,fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            Text(
              textAlign: TextAlign.center,
              "Discover,book and experiences unforgettable moments effortlessly!",style: TextStyle(color: Colors.black45,fontSize:20,fontWeight: FontWeight.bold),),
SizedBox(height: 60,),
            GestureDetector(
              onTap: () async {
                Authmethods authMethods = Authmethods();
                await authMethods.signInwithGoogle(context);
              },

              child: Container(
                height: 60,
                margin: EdgeInsets.only(left: 30,right: 30),

                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16)
                ),


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Image.asset('assets/images/Google.webp',height: 30,width: 30,fit: BoxFit.cover,),
                    SizedBox(width: 10,),
                    Text("Sign in with Google",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),),

                //
                  ],


                ),

              ),

            ),
            SizedBox(height: 20,),


            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminLoginPage()),
                  );
                },
                child
                : Text("Admin Login",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.bold),)),



          ],

        ),
      ),
    );
  }
}
