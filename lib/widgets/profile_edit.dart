import 'dart:io'; // For File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Naman Nayak');
  final TextEditingController _phoneController = TextEditingController(text: '+91 7898976189');
  final TextEditingController _emailController = TextEditingController(text: 'namannayak24@gmail.com');
  final TextEditingController _dobController = TextEditingController(text: '01/01/2000');

  XFile? _imageFile;
  String _gender = 'Male';
  DateTime? _dob;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _selectDateOfBirth() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        _dob = selectedDate;
        _dobController.text = '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey[50]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              IconButton(
                icon: Icon(Icons.arrow_back, size: 30, color: Colors.black54),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              
              SizedBox(height: 20),

              
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                          ? FileImage(File(_imageFile!.path))
                          : AssetImage('assets/images/naman.jpg') as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      
                      _buildFormField(
                        controller: _nameController,
                        labelText: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      
                     
                      _buildFormField(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      
                      
                      _buildFormField(
                        controller: _emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      
                      // Gender Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: _gender,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                          items: ['Male', 'Female', 'Other'].map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                      
                      // Date of Birth Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: _dobController,
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                          readOnly: true,
                          onTap: _selectDateOfBirth,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      
                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Process data here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Profile updated successfully')),
                            );
                            // Optionally navigate back or reset form
                          }
                        },
                        child: Text('Update Profile'),
                        style: ElevatedButton.styleFrom(
                          
                          padding: EdgeInsets.symmetric(vertical: 14),
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
