import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/models/plant_data.dart';
import 'package:ayurvan/screens/plant_details.dart';
import 'package:ayurvan/widgets/home_container.dart';
import 'package:flutter/services.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<List<HerbalPlants>>? futurePlants; // Updated to fetch a list of plants

  @override
  void initState() {
    super.initState();
    futurePlants = _getFavoritePlants(); // Initialize future here
  }

 Future<List<HerbalPlants>> _getFavoritePlants() async {
  try {
    // Fetch favorite botanical names from Firestore
    String userId = FirebaseAuth.instance.currentUser!.uid; // Replace with the current user's ID or a dynamic method to get it
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('favorites').doc(userId).get();
    
    // Check if the document exists and has the favoritePlants field
    if (snapshot.exists && snapshot.data() != null) {
      // Extract favoritePlants as a list of strings
      List<dynamic> favoriteBotanicalNamesDynamic = snapshot['favoritePlants'] ?? [];
      List<String> favoriteBotanicalNames = favoriteBotanicalNamesDynamic.cast<String>();

      // Load all plant data
      String jsonString = await rootBundle.loadString('assets/data.json');
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      Data data = Data.fromJson(jsonData);

      // Filter plants based on favorite botanical names
      List<HerbalPlants>? allPlants = data.cCollections?.herbalPlants;
      List<HerbalPlants> favoritePlants = allPlants?.where((plant) => favoriteBotanicalNames.contains(plant.botanicalName)).toList() ?? [];

      return favoritePlants;
    } else {
      print('No data found for the user');
      return [];
    }
  } catch (e, stacktrace) {
    print('Error fetching favorite plants: $e');
    print('Stack trace: $stacktrace');
    return [];
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      resizeToAvoidBottomInset: true,
      body: FutureBuilder<List<HerbalPlants>>(
        future: futurePlants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites found'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Favorites',
                      style: TextStyle(
                        color: textcolor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PlantDetailsScreen(
                            plantdata: snapshot.data![index],
                          );
                        }));
                      },
                      child: HomeTileContainer(
                        plantdata: snapshot.data![index],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}