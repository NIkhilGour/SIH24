import 'package:ayurvan/core/colors.dart';
import 'package:ayurvan/models/3d_model.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';


class HerbalPlantDetail extends StatefulWidget {
  final HerbalPlant plant;

  const HerbalPlantDetail({super.key, required this.plant});

  @override
  _HerbalPlantDetailState createState() => _HerbalPlantDetailState();
}

class _HerbalPlantDetailState extends State<HerbalPlantDetail> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      String fileName = '${widget.plant.name.toLowerCase().replaceAll(' ', '')}.wav';
      String filePath = 'audio/$fileName';
      await _audioPlayer.play(AssetSource(filePath));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Row(
                children: [
                    Container(
                          height: 50,
                          width: 50,
                          decoration:  BoxDecoration(
                            color: tilecolor,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),

                    const SizedBox(width: 50,),

                  Center(
                    child: Text(
                      widget.plant.name,
                      style:  TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color:textcolor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
      
              // 3D Model Container
              Center(
                child: Container(
                  height: 550, 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:tilecolor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 3,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ModelViewer(
                    src: widget.plant.modelPath,
                    autoRotate: true,
                    cameraControls: true,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 30),
      
             
              Center(
                child: IconButton(
                  iconSize: 72,
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  ),
                  color: buttoncolor,
                  onPressed: _toggleAudio,
                ),
              ),
              const SizedBox(height: 10),
      
              
              Center(
                child: Text(
                  isPlaying ? 'Pause Audio' : 'Play Audio',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
