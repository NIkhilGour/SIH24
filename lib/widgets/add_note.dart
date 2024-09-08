import 'package:ayurvan/models/plant_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.plant});

  final HerbalPlants plant;

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _noteController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false; // Track loading state

  Future<void> _addNote() async {
    final user = _auth.currentUser;
    if (user == null) return;

    String note = _noteController.text;

    setState(() {
      _isLoading = true; // Show progress indicator
    });

    try {
      // Add the note to the 'UserNotes' collection
      await FirebaseFirestore.instance
    .collection('UserNotes')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('notes') // Subcollection for multiple notes
    .add({
      'botanicalName': widget.plant.botanicalName,
      'englishName': widget.plant.englishName,
      'note': note,
      'timestamp': FieldValue.serverTimestamp(), // Store the time when the note was added
    });


      // Show success SnackBar after note is added
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added successfully!')),
      );

      // Close the modal bottom sheet
      Navigator.pop(context);
    } catch (e) {
      // Show error SnackBar if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add note. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a Note',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _noteController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your note',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null // Disable button when loading
                    : () async {
                        if (_noteController.text.isNotEmpty) {
                          await _addNote();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Note cannot be empty')),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0), // Increased button padding
                ),
                child: _isLoading
                    ? Center(
                      child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                    )
                    : const Text('Add Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
