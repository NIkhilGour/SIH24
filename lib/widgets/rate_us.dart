import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({super.key});

  @override
  _RateUsScreenState createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rate Us',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'We value your feedback!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Please rate your experience',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),
              // Rating Bar
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Rating: $_rating',
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              
              TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Leave a comment (optional)',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
             SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _submitRating();
                },
                style: ElevatedButton.styleFrom(
                 backgroundColor: const Color(0xFF61886F),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRating() async {
   
    String feedback = _feedbackController.text;

    await FirebaseFirestore.instance.collection('Feedbacks').doc(FirebaseAuth.instance.currentUser!.uid).set({
              'rating': _rating,
              'comment': feedback
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your feedback!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: EdgeInsets.all(10),
      ),
    );

  
    setState(() {
      _rating = 0;
      _feedbackController.clear();
    });
  }
}
