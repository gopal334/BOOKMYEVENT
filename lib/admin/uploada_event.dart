import 'dart:io';

import 'package:eventbookingapp/Service/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import '../Service/database.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  TextEditingController NameControler = new TextEditingController();
  TextEditingController PriceControler = new TextEditingController();
  TextEditingController DetailControler = new TextEditingController();
  TextEditingController LocationControler = new TextEditingController();

  final List<String> eventCategories = [
    "Music",
    "Food",
    "Clothing",
    "Festival"
  ];

  String? value;
  final ImagePicker _picker = ImagePicker();
  File ? selectedImage;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return DateFormat.jm().format(dt); // eg. 5:30 PM
  }


  Future getImage() async {
var image = await _picker.pickImage(source: ImageSource.gallery);
selectedImage = File(image!.path);
setState(() {
  selectedImage = File(image!.path);
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Back button + title
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 6),
                  const Text(
                    "Upload Event",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 45),
        
              // 📸 Event Image Picker
             selectedImage !=null?Center(
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(16),
                 child: Image.file(selectedImage!,height: 150,
                   width: 150,fit: BoxFit.cover,),
               ),
             ) :Center(
                child: GestureDetector(
                  onTap: (){
                    getImage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,

                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff6351ec), width: 2.0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.camera_alt_outlined, size: 40),
                  ),
                ),
              ),
        
              const SizedBox(height: 30),
        
              // 📝 Event Name
              const Text(
                "Event Name",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  TextField(
                  controller: NameControler,
                  decoration: InputDecoration(
                    hintText: "Enter Event name",
                    border: InputBorder.none,
                  ),
                ),
              ),
        
              const SizedBox(height: 25),
        
              // 💰 Ticket Price
              const Text(
                "Ticket Price",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  TextField(
                  controller: PriceControler,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Ticket Price",
                    border: InputBorder.none,
                  ),
                ),
              ),
        
              const SizedBox(height: 25),
        
              // 📂 Event Category Dropdown
              const Text(
                "Event Category",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: const Text("Select Category"),
                  items: eventCategories
                      .map(
                        (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 18),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ),
              const Text(
                "Enter Location",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  TextField(
                  controller: LocationControler,
                  decoration: InputDecoration(
                    hintText: "Enter Location Here",
                    border: InputBorder.none,
                  ),
                ),
              ),
        Row(
          children: [
            Icon(Icons.calendar_month, color: Colors.blue, size: 20),
            SizedBox(width: 10),
            Text(
              selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                  : "Pick Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.edit_calendar),
              onPressed: () => pickDate(context),
            ),
            SizedBox(width: 20),
            Icon(Icons.alarm, color: Colors.blue, size: 20),
            SizedBox(width: 10),
            Text(
              selectedTime != null
                  ? formatTimeOfDay(selectedTime!)
                  : "Pick Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () => pickTime(context),
            ),
          ],
        ),

              const SizedBox(height: 25),
        
              // 💰 Ticket Price
              const Text(
                "Event detail",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 152,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  TextField(
                  controller: DetailControler,
                  maxLines: 6,
                  maxLength: 150,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "What will be on event.....",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Center(
                child: GestureDetector(
                  onTap: () async{
                    //Its only work when you have firebase upgraded version
                //    String addid = randomAlphaNumeric(10);
                 //   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("BlogImages").child(addid);
                 //   final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
                //    var downlaodUrl = await(await task).ref.getDownloadURL();
                    String id = randomAlpha(10);
                    Map<String,dynamic> uploadEvent = {

                      "image" : "",
                      "Price" : PriceControler.text,
                      "Name" : NameControler.text,
                      "category" : value,
                      "Detail" : DetailControler.text,
                      "date" : DateFormat('yyyy-MM-dd').format(selectedDate!),
                      "Time" :  formatTimeOfDay(selectedTime!),
                      "location" : LocationControler.text,
                    };
                    await DatabaseMethods().addEvent(uploadEvent,id).then((value){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Event uploaded Successfully!!"),
                        ),


                      );
                      setState(() {
                        NameControler.text="";
                        PriceControler.text="";
                        DetailControler.text="";
                        selectedImage = null;
                        LocationControler.text="";
                        selectedDate = null;
                        selectedTime = null;


                      });

                    } );

                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text("Upload Event",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
