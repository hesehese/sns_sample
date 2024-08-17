import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String newText = "";

  Future _addFirebaseData() async {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "text": newText,
      "createdAt": DateTime.now(),
    };
// Add a new document with a generated ID
    FirebaseFirestore.instance.collection("posts").add(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
              onChanged: (value) {
              newText = value;
            },
          ),
          ElevatedButton(onPressed:(){
            _addFirebaseData();
          } , child: const Icon(Icons.person))
        ],
      ),
    );
  }
}
