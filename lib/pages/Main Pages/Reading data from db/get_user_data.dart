import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  const GetUserName({super.key, required this.documentId});
  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Row(
                    children: [
                      const Text(
                        'First Name: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'R',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' ${data['first name']}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      const Text(
                        'Last Name: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'R',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' ${data['last name']}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      const Text(
                        'Email: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'R',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' ${data['email']}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('Loading...');
        }
      }),
    );
  }
}
