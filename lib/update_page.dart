import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'post.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage(this.post, {super.key});

  final Post post;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
String updatedWord = "";

  void _updateFirebaseData() async {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "text": updatedWord,
      "updatedAt": DateTime.now(),
    };
// Add a new document with a generated ID
    await FirebaseFirestore.instance.collection("new").doc(widget.post.id).update(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            initialValue: widget.post.text,
            onChanged: (value) {
              updatedWord = value;
              setState(() {

              });
            },
          ),
          ElevatedButton(onPressed:updatedWord.isEmpty ? null : (){
            _updateFirebaseData();
          } , child: const Icon(Icons.person))
        ],
      ),
    );
  }
}
