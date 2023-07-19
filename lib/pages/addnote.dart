import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title = "";
  String des = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Docket",
            style: TextStyle(
              fontSize: 32.0,
              fontFamily: "lato",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [IconButton(onPressed: add, icon: const Icon(Icons.check))],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: const InputDecoration.collapsed(
                            hintText: "Description",
                          ),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.black87,
                          ),
                          onChanged: (val) {
                            des = val;
                          },
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');
    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };
    ref.add(data);
    Navigator.pop(context);
  }
}
