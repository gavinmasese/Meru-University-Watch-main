// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Side Drawer/sidebar.dart';
import 'Reading data from db/add_image_data.dart';

class AddPotsts extends StatefulWidget {
  const AddPotsts({super.key});

  @override
  State<AddPotsts> createState() => _AddPotstsState();
}

class _AddPotstsState extends State<AddPotsts> {
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer:  SideBar(),
      appBar: AppBar(
        title: const Center(child: Text("University Watch")),
        backgroundColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Padding(
        padding:  const EdgeInsets.all(8),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.5),
                        child: ListTile(
                          title: GetData(
                            documentId: docIDs[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
