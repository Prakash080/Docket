import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  const ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title = "";
  String des = "";
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: delete,
        backgroundColor: Colors.red,
        label: const Text("Delete"),
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Edit Docket",
          style: TextStyle(
            fontSize: 32.0,
            fontFamily: "lato",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [IconButton(onPressed: save, icon: const Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(
            12.0,
          ),
          child: Column(children: [
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    initialValue: widget.data['title'],
                    onChanged: (val) {
                      title = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Can't be empty !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    child: Text(
                      widget.time,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: "lato",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Note Description",
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: "lato",
                      color: Colors.black87,
                    ),
                    initialValue: widget.data['description'],
                    onChanged: (val) {
                      des = val;
                    },
                    maxLines: 20,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Can't be empty !";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState!.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}
