import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/widgets/home_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundcolor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      color:const Color.fromARGB(162, 239, 222, 222),
                      borderRadius: BorderRadius.circular(16),
                     
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(buttoncolor),
                        shape: const WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))))),
                    icon: const Icon(
                      Icons.filter_alt,
                      color: Colors.white,
                    ),
                    color: textcolor,
                    iconSize: 30,
                    onPressed: () {
                      // Add your filter functionality here
                    },
                  ),
                ],
              ),
            ),
            
            Expanded(child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                  return const HomeTileContainer();
            },))
            
          ],
        ),
      ),
    );
  }
}
