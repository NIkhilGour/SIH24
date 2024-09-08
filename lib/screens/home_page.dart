import 'dart:convert';
import 'package:flutter/services.dart'; // To use rootBundle for asset loading
import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/models/plant_data.dart';
import 'package:ayurvan/screens/plant_details.dart';
import 'package:ayurvan/widgets/home_container.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Data>? futureData;
  List<HerbalPlants>? allPlants; // Store all plants
  List<HerbalPlants>? filteredPlants; // Store filtered plants
  TextEditingController searchController = TextEditingController();
  String selectedPlantType = 'All'; // Default selection for dropdown

  // List of predefined plant types for filtering
  List<String> plantTypes = [
    "All",
    "Flowering Plant",
    "Non-Flowering Plant",
    "Herb",
    "Shrub",
    "Tree",
    "Climber",
    "Fern",
    "Moss",
    "Aquatic Plant",
    "Succulent"
  ];

  @override
  void initState() {
    super.initState();
    futureData = loadData(); // Initialize future here
    searchController.addListener(_filterPlants); // Listen for search input changes
  }

  Future<Data> loadData() async {
    try {
      // Use rootBundle to load the file from assets
      String jsonString = await rootBundle.loadString('assets/data.json');
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      Data data = Data.fromJson(jsonData);

      // Set initial data for plants
      setState(() {
        allPlants = data.cCollections?.herbalPlants;
        filteredPlants = allPlants;
      });

      return data;
    } catch (e) {
      print('Error loading data: $e');
      return Future.error('Failed to load data');
    }
  }

  // This method filters the plants based on search input and selected plant type
  void _filterPlants() {
  String query = searchController.text.toLowerCase();
  setState(() {
    filteredPlants = allPlants?.where((plant) {
      bool matchesSearch = plant.botanicalName!.toLowerCase().contains(query) ||
          plant.englishName!.toLowerCase().contains(query) ||
          plant.uses!.any((use) => use.toLowerCase().contains(query)); // Search within the list of uses
      bool matchesType = (selectedPlantType == 'All') || plant.type == selectedPlantType;

      return matchesSearch && matchesType;
    }).toList();
  });
}


  // Method to handle the popup menu selection
  void _onFilterSelected(String? newType) {
    setState(() {
      selectedPlantType = newType!;
      _filterPlants(); // Re-filter based on new selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      resizeToAvoidBottomInset: true,
      body: FutureBuilder<Data>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || filteredPlants == null) {
            return const Center(child: Text('No data available'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AyurVan',  
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(162, 239, 222, 222),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.filter_alt,
                          color: Colors.white,
                          size: 30,
                        ),
                        color: Colors.white,
                        onSelected: _onFilterSelected,
                        itemBuilder: (BuildContext context) {
                          return plantTypes.map((String type) {
                            return PopupMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPlants!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PlantDetailsScreen(
                            plantdata: filteredPlants![index],
                          );
                        }));
                      },
                      child: HomeTileContainer(
                          plantdata: filteredPlants![index]),
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
