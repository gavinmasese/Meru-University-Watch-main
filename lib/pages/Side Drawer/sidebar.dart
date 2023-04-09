import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Bottom Navigation Bar/main_wrapper.dart';

class SideBar extends StatelessWidget {
  SideBar({
    super.key,
  });
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Welcome To Meru University Watch',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            accountEmail: Text("Signed in as:\n${user!.email}"),
            currentAccountPicture: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 10),
                  ),
                ],
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/logo.jpg'),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail_outlined),
            title: const Text("Contact us"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text("About"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text("Back"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const MainWrapper())));
            },
          ),
        ],
      ),
    );
  }
}
