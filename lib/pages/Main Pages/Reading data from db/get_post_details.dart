// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class GetPostdetails extends StatelessWidget {
//   const GetPostdetails({super.key, required this.documentId});
//   final String documentId;
//   @override
//   Widget build(BuildContext context) {

//     return FutureBuilder<DocumentSnapshot>(

//       future: FirebaseFirestore.instance
//           .collection("user")
//           .get()
//           .then((snapshot) => snapshot.docs.forEach((document)  {
//                  FirebaseFirestore.instance
//                     .collection("users")
//                     .doc(document.reference.id)
//                     .collection('imagesAndDescription')
//                     .get();
//               })),
//       builder: ((context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map data = (snapshot.data!.data() ?? {}) as Map;
//           return Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ListTile(
//                   title: Row(
//                     children: [
//                       const Text(
//                         'Description: ',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'R',
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         ' ${data['description']}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return const Text('Loading...');
//         }
//       }),
//     );
//   }
// }
