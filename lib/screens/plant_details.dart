import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/models/3d_model.dart';
import 'package:ayurvan/models/plant_data.dart';
import 'package:ayurvan/widgets/expandable_container.dart';

import 'package:ayurvan/widgets/uses_container.dart';

import 'package:flutter/material.dart';

class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen({super.key,required this.plantdata});
  final HerbalPlants plantdata;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundcolor,
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
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: tilecolor,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: plantdata.imageUrls!.length,
                    itemBuilder: (context,index) {
                      return Image.network(
                        plantdata.imageUrls![index],
                        fit: BoxFit.contain,
                      );
                    }
                  ),
                ),
              ),
              Positioned(
                top: 380,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                         
                          children: [
                            Text(
                              plantdata.botanicalName!,
                              style: TextStyle(
                                  color: buttoncolor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),

                            const Icon(Icons.star,size: 30,color: Colors.orange,)
                          ],
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          plantdata.englishName!,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(
                          plantdata.hindiName!,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 20),
                        child: Text(
                          'Uses',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context)
                            .size
                            .width, // Ensure it spans the screen width
                        child: ListView.builder(
                          physics:
                              const BouncingScrollPhysics(), // Smooth scrolling
                          scrollDirection: Axis.horizontal,
                          itemCount: plantdata.uses!.length,
                          itemBuilder: (context, index) {
                            return  UsesContainer(uses: plantdata.uses![index],);
                          },
                        ),
                      ),

                      
                        SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Expanded(
                        
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 10),
                            child: Text(
                                plantdata.description!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

                  Positioned(
                top: 45,
                right: 0,
                child: ExpandableIconExample(iconname: 'plant_type',textdata:plantdata.type! ,)
                ), 

                   Positioned(
                top: 103,
                right: 0,
                child: ExpandableIconExample(iconname: 'soil',textdata: plantdata.soilType![0],)
                ), 
                   Positioned(
                top: 161,
                right: 0,
                child: ExpandableIconExample(iconname: 'season',textdata: plantdata.season!,)
                ), 
                   Positioned(
                top: 219,
                right: 0,
                child: ExpandableIconExample(iconname: 'watering',textdata: plantdata.wateringFrequency!,)
                ), 
                   Positioned(
                top: 277,
                right: 0,
                child: ExpandableIconExample(iconname: 'region',textdata: plantdata.region!,)
                ),  
              
            ],
          ),
        ),
      ),
    );
  }
}
