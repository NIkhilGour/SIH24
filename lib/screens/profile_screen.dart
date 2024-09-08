import 'package:ayurvan/widgets/feedback.dart';
import 'package:ayurvan/widgets/profile_edit.dart';
import 'package:ayurvan/widgets/rate_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color tilecolor = const Color.fromRGBO(97, 135, 110, 1.0);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _name;
  String? _phoneNumber;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _name = userDoc['name'] ?? 'Unknown User';
          _phoneNumber = userDoc['phone'] ?? 'No Phone Number';
          _email = userDoc['email'] ?? currentUser.email ?? 'No Email';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tilecolor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Top container for profile picture and details
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: tilecolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Back button
                        Container(
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
                      ],
                    ),
                  ),
                ),
              ),

              // Profile picture, name, and phone number
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person,size:50,),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _name ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _phoneNumber ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // White rounded container for Account Overview
              Positioned(
                top: 380,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildAccountOption(
                          context,
                          icon: Icons.note_alt,
                          title: 'My Notes',
                          iconColor: Colors.green,
                          onTap: () {
                            // Handle My Notes tap
                          },
                        ),
                        _buildAccountOption(
                          context,
                          icon: Icons.feedback,
                          title: 'Feedback',
                          iconColor: Colors.purple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FeedbackScreen()),
                            );
                          },
                        ),
                        _buildAccountOption(
                          context,
                          icon: Icons.star_rate,
                          title: 'Rate Us',
                          iconColor: Colors.orange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RateUsScreen()), // Navigate to RateUsScreen
                            );
                          },
                        ),
                        _buildAccountOption(
                          context,
                          icon: Icons.logout,
                          title: 'Log Out',
                          iconColor: Colors.red,
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for account options
  Widget _buildAccountOption(BuildContext context,
      {required IconData icon,
      required String title,
      required Color iconColor,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing:
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
        onTap: onTap,
      ),
    );
  }
}
