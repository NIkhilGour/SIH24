import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/screens/ayushAi.dart';
import 'package:ayurvan/screens/home_page.dart';

import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';



class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _Tabs();
}

class _Tabs extends State<Tabs> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: StylishBottomBar(
       
        option: DotBarOptions(
          iconSize: 30,
          dotStyle: DotStyle.tile,
          gradient: const LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.pink,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor:selectedicon,
            unSelectedColor:unselectedicon,
            title: const Text('Home'),
           
           
            badgePadding: const EdgeInsets.only(left: 4, right: 4),
          ),
          BottomBarItem(
            icon: Image.asset('assets/icons/cube.png',height: 27,color: unselectedicon,),
            selectedIcon: Image.asset('assets/icons/cube.png',height: 27,color: unselectedicon,),
             selectedColor:selectedicon,
            unSelectedColor:unselectedicon,
            // backgroundColor: Colors.orange,
            title: const Text('3D'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.star,
              ),
              selectedIcon: const Icon(
                Icons.star,
              ),
              selectedColor:selectedicon,
              unSelectedColor:unselectedicon,
              title: const Text('Star')),
          BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
               selectedColor:selectedicon,
            unSelectedColor:unselectedicon,
              title: const Text('Profile')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected,
        notchStyle: NotchStyle.circle,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
       
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) {
              return const AyushAi();
          },));
        },
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.asset('assets/icons/ayushAi.jpg',fit: BoxFit.cover,height: 60,))
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: const [
            HomeScreen(),
            Center(child: Text('3D')),
          
            Center(child: Text('Style')),
            Center(child: Text('Profile')),
          ],
        ),
      ),
    );
  }
}


