import 'package:ayurvan/core/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserNoteScreen extends StatelessWidget {
  const UserNoteScreen({super.key});

  // Method to fetch notes from the 'notes' subcollection
  Future<List<QueryDocumentSnapshot>> _getUserNotes() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var querySnapshot = await FirebaseFirestore.instance
        .collection('UserNotes')
        .doc(userId)
        .collection('notes')
        .orderBy('timestamp', descending: true) // Optionally sort by timestamp
        .get();

    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Notes'),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _getUserNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching notes'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes available'));
          }
          final notes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0), // Add padding around the ListView
            itemCount: notes.length,
            itemBuilder: (context, index) {
              var noteData = notes[index].data() as Map<String, dynamic>;
              var botanicalName = noteData['botanicalName'] ?? 'Unknown Botanical Name';
              var englishName = noteData['englishName'] ?? 'Unknown English Name';
              var note = noteData['note'] ?? 'No note content';
              var timestamp = noteData['timestamp']?.toDate();

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0), 
                color: tilecolor,// Add vertical margin between cards
                elevation: 4.0, // Add shadow for a lifted effect
                child: ExpansionTile(
                  title: Text(
                    englishName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(
                    botanicalName,
                    style: TextStyle(
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  trailing: timestamp != null
                      ? Text(
                          '${timestamp.day}/${timestamp.month}/${timestamp.year}',
                          style: TextStyle(
                            color: Colors.blueGrey[500],
                          ),
                        )
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        note,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
