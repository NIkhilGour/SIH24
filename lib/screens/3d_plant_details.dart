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
      String filePath = '3d/audio/$fileName';
      await _audioPlayer.play(AssetSource(filePath));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.plant.name,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Center(
              child: Text(
                widget.plant.name,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3D Model Container
            Center(
              child: Container(
                height: 550, 
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
                color: Colors.green[800],
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
    );
  }
}
