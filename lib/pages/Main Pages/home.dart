// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Side Drawer/sidebar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> postItems = [];
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance.collection("users").get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  void getDocI() {
    // await FirebaseFirestore.instance
    //     .collectionGroup("imagesAndDescription")
    //     .get()
    //     .then(
    //       (snapshot) => snapshot.docs.forEach(
    //         (document) {
    //           postItems.add(document.reference.id);
    //         },
    //       ),
    //     );
    FirebaseFirestore.instance.collection("users").get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) async {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(document.reference.id)
                  .collection('imagesAndDescription')
                  .orderBy('timeposted', descending: true)
                  .snapshots();
            },
          ),
        );
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideBar(),
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 150,
            color: Colors.white,
            child: Image.asset(
              "images/logo.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome to',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.blueGrey,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Meru University Watch',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.lightGreenAccent[700],
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Where we find all news around Meru niversity',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                  color: Colors.blueGrey,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10),
                  child: const DataFetch(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataFetch extends StatelessWidget {
  const DataFetch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup("imagesAndDescription")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueGrey[500],
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              Icons.person_2_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          snapshot.data!.docs[index]['name'] +
                              ' ' +
                              snapshot.data!.docs[index]['second name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Title: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          snapshot.data!.docs[index]['title'],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (snapshot.data!.docs[index]['imageurl'].toString().isEmpty)
                    Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      "Notice! Notice! Notice!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                color: Colors.white,
                                child: Image.asset(
                                  "images/university.jpg",
                                  fit: BoxFit.fill,
                                ),
                                // child: AssetImage(
                                //   snapshot.data!.docs[index]['imageurl']
                                //       .toString(),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (snapshot.data!.docs[index]['imageurl']
                      .toString()
                      .isNotEmpty)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Image.network(
                            snapshot.data!.docs[index]['imageurl'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(
                          "Description:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshot.data!.docs[index]['description'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Uploaded at:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            snapshot.data!.docs[index]['timeposted'],
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
