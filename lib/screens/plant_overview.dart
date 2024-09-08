import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/screens/revolving_images.dart';
import 'package:flutter/material.dart';
import 'package:ayurvan/models/3d_model.dart';
import 'package:ayurvan/screens/3d_plant_details.dart';

class HerbalPlantsOverview extends StatefulWidget {
  final List<HerbalPlant> plants;

  const HerbalPlantsOverview({super.key, required this.plants});

  @override
  _HerbalPlantsOverviewState createState() => _HerbalPlantsOverviewState();
}

class _HerbalPlantsOverviewState extends State<HerbalPlantsOverview> {
  late List<HerbalPlant> _filteredPlants;
  late TextEditingController _searchController;
  bool _showSplashScreen = true; // Control whether to show the splash screen or not

  @override
  void initState() {
    super.initState();
    _filteredPlants = widget.plants;
    _searchController = TextEditingController();
    _searchController.addListener(_filterPlants);

    // Show the splash screen for 2-3 seconds, then display the main content
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showSplashScreen = false;
      });
    });
  }

  void _filterPlants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlants = widget.plants.where((plant) {
        return plant.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplashScreen
          ? const Center(
              // Your splash screen content goes here
              child: RevolvingImages()
            )
          : SizedBox(
            height: MediaQuery.of(context).size.height-100,
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Virtual 3D Tour',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: textcolor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              icon: Icon(Icons.search, color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        itemCount: _filteredPlants.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          final plant = _filteredPlants[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HerbalPlantDetail(plant: plant),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: tilecolor,
                              elevation: 3,
                              shadowColor: Colors.grey.withOpacity(0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 200,
                                        child: Image.asset(
                                            'assets/icons/3d_card_icon.png'),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      plant.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
