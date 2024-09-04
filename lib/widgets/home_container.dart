import 'package:flutter/material.dart';
import 'package:ayurvan/core/colors.dart';

class HomeTileContainer extends StatelessWidget {
  const HomeTileContainer({super.key});

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
            height: 50,
            width: 50,
            child: Image.asset('assets/images/documentID63-2.png',fit: BoxFit.cover,)),),

            Positioned(
            left: 120,
            top: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   const Text('Ginger',style: TextStyle(
                    color : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    
                  ),),
                  Text('Zingiber officinale',style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
