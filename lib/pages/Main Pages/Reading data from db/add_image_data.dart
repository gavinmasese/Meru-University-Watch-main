// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously, empty_catches

import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Bottom Navigation Bar/main_wrapper.dart';

// ignore: must_be_immutable
class GetData extends StatelessWidget {
  GetData({
    super.key,
    required this.documentId,
  });

  final String documentId;

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

  final smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var nowTime = formatDate(DateTime.now(),
              [yyyy, '-', mm, '-', dd, '~', HH, ':', nn, ':', ss]);
          var name = snapshot.data!['first name'];
          var name_2 = snapshot.data!['last name'];
          var title = snapshot.data!['title'];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "To add a post,\n Choose what item you would like to share below:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      "Add a description/quote :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: smsController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Text',
                      hintStyle: const TextStyle(fontFamily: 'ro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MainWrapper())));
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (file == null) return;

                        String uniqueFileName =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        Reference referencRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referencRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            contentType: ContentType.success,
                            message: 'Any image slected will be Uploaded!',
                            title: 'Hello There!',
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                        try {
                          await referenceImageToUpload.putFile(
                            File(file.path),
                          );
                          String imageUrl =
                              await referenceImageToUpload.getDownloadURL();

                          Map<String, String> dataToSave = {
                            "timeposted": nowTime.toString(),
                            "imageurl": imageUrl,
                            "description": smsController.text.trim(),
                            "name": name.toString(),
                            "second name": name_2.toString(),
                            "title": title.toString(),
                          };
                          CollectionReference collectionRef = FirebaseFirestore
                              .instance
                              .collection("users")
                              .doc(documentId)
                              .collection('imagesAndDescription');
                          collectionRef.add(dataToSave);
                        } catch (error) {}
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[200],
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                            'Attach Image',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ro',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (smsController.text.trim().isNotEmpty) {
                          try {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => const MainWrapper())));

                            Map<String, String> dataToSave = {
                              "timeposted": nowTime.toString().trim(),
                              "description": smsController.text.trim(),
                              "imageurl": "",
                              "name": name.toString(),
                              "second name": name_2.toString(),
                              "title": title.toString(),
                            };
                            CollectionReference collectionRef =
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(documentId)
                                    .collection('imagesAndDescription');
                            collectionRef.add(dataToSave);

                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                contentType: ContentType.success,
                                message: 'Quote has been Uploaded!',
                                title: 'Hello There!',
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          } catch (error) {}
                        } else {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              contentType: ContentType.success,
                              message: 'Description is EMPTY!',
                              title: 'Hello There!',
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[200],
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                            'Add as Plain Text',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ro',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Text('');
        }
      }),
    );
  }

  Future picker() async {}
}
