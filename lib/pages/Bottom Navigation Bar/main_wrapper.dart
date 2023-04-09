import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../Main Pages/add_post.dart';
import '../Main Pages/profile.dart';
import '../Main Pages/home.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late final PageController pageController;
  int currentIndex = 0;
  List<Widget> pages = [
    const Home(),
    const AddPotsts(),
    const PersonalData(),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: WaterDropNavBar(
        bottomPadding: 10.0,
        waterDropColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        onItemSelected: onTap,
        selectedIndex: currentIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home_filled,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
              filledIcon: Icons.add_a_photo_rounded,
              outlinedIcon: Icons.add_a_photo_outlined),
          BarItem(filledIcon: Icons.people, outlinedIcon: Icons.people_outline),
        ],
      ),
    ));
  }
}

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   int index = 0;
//   List screen = [
//     const Home(),
//     const AddPotsts(),
//     const PersonalData(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             index = 2;
//           });
//         },
//         backgroundColor: Colors.yellow,
//         child: Icon(
//           Icons.search,
//           color: index == 2 ? Colors.blueGrey : Colors.grey,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     index = 0;
//                   });
//                 },
//                 child: Icon(
//                   Icons.home,
//                   size: 27,
//                   color: index == 0 ? Colors.blueGrey : Colors.grey,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     index = 1;
//                   });
//                 },
//                 child: Icon(
//                   Icons.category,
//                   size: 27,
//                   color: index == 1 ? Colors.blueGrey : Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: screen[index],
//     );
//   }
// }
