
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Feedback',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us what you love about the app, or what we could be doing better.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter feedback',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter your feedback here...',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCreativeSection(),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _submitFeedback();
                },
                style: ElevatedButton.styleFrom(
                 backgroundColor: const Color(0xFF61886F),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit feedback',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreativeSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      child: const ListTile(
        leading: Icon(
          Icons.spa, // Herbal garden-related icon
          color: Colors.greenAccent,
          size: 40,
        ),
        title: Text(
          'Gardening Tip of the Day',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Did you know? Basil grows best when planted next to tomatoes.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
    );
  }

  void _submitFeedback() async {
    
    String feedback = _feedbackController.text;

   await FirebaseFirestore.instance.collection('Feedbacks').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'text': feedback
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
      _feedbackController.clear();
    });
  }
}
