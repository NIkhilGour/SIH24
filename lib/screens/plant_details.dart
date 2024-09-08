import 'package:carousel_slider/carousel_slider.dart';
import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/models/3d_model.dart';
import 'package:ayurvan/models/plant_data.dart';
import 'package:ayurvan/widgets/expandable_container.dart';
import 'package:ayurvan/widgets/uses_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantDetailsScreen extends StatefulWidget {
  const PlantDetailsScreen({super.key, required this.plantdata});
  final HerbalPlants plantdata;

  @override
  _PlantDetailsScreenState createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  int _currentIndex = 0;
  bool _isFavorited = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore
        .collection('favorites')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final favoritePlants = List<String>.from(doc.data()?['favoritePlants'] ?? []);
      setState(() {
        _isFavorited = favoritePlants.contains(widget.plantdata.botanicalName);
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore.collection('favorites').doc(user.uid);

    await _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(docRef);

      if (doc.exists) {
        final favoritePlants = List<String>.from(doc.data()?['favoritePlants'] ?? []);
        if (_isFavorited) {
          favoritePlants.remove(widget.plantdata.botanicalName);
        } else {
          favoritePlants.add(widget.plantdata.botanicalName!);
        }
        transaction.update(docRef, {'favoritePlants': favoritePlants});
      } else {
        final favoritePlants = _isFavorited
            ? []
            : [widget.plantdata.botanicalName!];
        transaction.set(docRef, {'favoritePlants': favoritePlants});
      }
    });

    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tilecolor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: tilecolor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Carousel and Dots positioned together in one container
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: tilecolor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: CarouselSlider.builder(
                              itemCount: widget.plantdata.imageUrls!.length,
                              itemBuilder: (context, index, realIndex) {
                                return Image.network(
                                  widget.plantdata.imageUrls![index],
                                  fit: BoxFit.contain,
                                );
                              },
                              options: CarouselOptions(
                                height: 250,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                                aspectRatio: 16 / 9,
                                autoPlayInterval: const Duration(seconds: 3),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                          // Space between carousel and dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.plantdata.imageUrls!.map((url) {
                              int index = widget.plantdata.imageUrls!.indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == index
                                      ? Colors.black87
                                      : Colors.black26,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 380,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.plantdata.botanicalName!,
                                style: TextStyle(
                                    color: buttoncolor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(
                                  _isFavorited
                                      ? Icons.star
                                      : Icons.star_border_outlined,
                                  color: _isFavorited ? Colors.orange : Colors.black54,
                                  size: 40,
                                ),
                                onPressed: _toggleFavorite,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            widget.plantdata.englishName!,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            widget.plantdata.hindiName!,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20),
                          child: Text(
                            'Uses',
                            style: GoogleFonts.archivo(
                              fontSize: 30,
                              fontWeight: FontWeight.w500
                            ),
                            // style: TextStyle(
                            //     color: Colors.black,
                            //     fontSize: 30,
                            //     fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.plantdata.uses!.length,
                            itemBuilder: (context, index) {
                              return UsesContainer(
                                uses: widget.plantdata.uses![index],
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                          child: Text(
                            widget.plantdata.description!,

                              style: GoogleFonts.lato(
                
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),
                            // style: const TextStyle(
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.w400,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 45,
                right: 0,
                child: ExpandableIconExample(
                  iconname: 'plant_type',
                  textdata: widget.plantdata.type!,
                ),
              ),
              Positioned(
                top: 103,
                right: 0,
                child: ExpandableIconExample(
                  iconname: 'soil',
                  textdata: widget.plantdata.soilType![0],
                ),
              ),
              Positioned(
                top: 161,
                right: 0,
                child: ExpandableIconExample(
                  iconname: 'season',
                  textdata: widget.plantdata.season!,
                ),
              ),
              Positioned(
                top: 219,
                right: 0,
                child: ExpandableIconExample(
                  iconname: 'watering',
                  textdata: widget.plantdata.wateringFrequency!,
                ),
              ),
              Positioned(
                top: 277,
                right: 0,
                child: ExpandableIconExample(
                  iconname: 'region',
                  textdata: widget.plantdata.region!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
