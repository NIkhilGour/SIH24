import 'package:ayurvan/models/plant_data.dart';
import 'package:flutter/material.dart';
import 'package:ayurvan/core/colors.dart';

class HomeTileContainer extends StatelessWidget {
  const HomeTileContainer({super.key, required this.plantdata});
  final HerbalPlants plantdata;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        clipBehavior: Clip.none, // Allows the image to overflow
        children: [
          // The main container
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: tilecolor,
            ),
            child: Padding(
             padding: const EdgeInsets.only(bottom: 16,top: 16,left: 24,right: 16), // Adjust to make space for the image
              child: Row(
                
                children: [
                  // Column for text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        plantdata.englishName!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        plantdata.botanicalName!,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                
                ],
              ),
            ),
          ),

          // The image positioned outside the container
          Positioned(
            top: -30,
            right: 0,
            child: SizedBox(
              height: 110,
              width: 80,
              child: Image.network(
                plantdata.imageUrls![0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
