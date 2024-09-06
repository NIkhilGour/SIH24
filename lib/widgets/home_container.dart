import 'package:ayurvan/models/plant_data.dart';
import 'package:flutter/material.dart';
import 'package:ayurvan/core/colors.dart';

class HomeTileContainer extends StatelessWidget {
  const HomeTileContainer({super.key,required this.plantdata});
  final HerbalPlants plantdata;
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(20.0),
  
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        
        Container(
          height: 100,
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            color: tilecolor
          ),
        ),
    
        Positioned(
          top: -40,
          width: 140,
          height: 130,
          left: 0,
          
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image.network(plantdata.imageUrls![0],fit: BoxFit.cover,)),),

            Positioned(
            left: 120,
            top: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text(plantdata.englishName!,style: const TextStyle(
                    color : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    
                  ),),
                  Text(plantdata.botanicalName!,style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),)
          ],)),

          const Positioned(
            right: 25,
            top: 35,
            child: Icon(Icons.grain,size: 30,color: Colors.blue,))
              
      ],
    )
    );
  }
}
