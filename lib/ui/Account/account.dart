import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _profileImage;
  String? _photoURL;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      setState(() {
        nameController.text = userDoc['name'];
        _photoURL = userDoc['photoURL'];
      });
    }
  }

  Future<void> _pickProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadProfilePhoto(User user) async {
    if (_profileImage != null) {
      try {
        final storageRef = _storage.ref().child('profile_photos/${user.uid}.jpg');
        await storageRef.putFile(_profileImage!);
        final photoURL = await storageRef.getDownloadURL();
        print('Photo URL: $photoURL');  // Debug print
        return photoURL;
      } catch (e) {
        print('Failed to upload profile photo: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload profile photo: $e')),
        );
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : (_photoURL != null ? NetworkImage(_photoURL!) : AssetImage('assets/images/icons/userIcon.png')) as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () async {
                      await _pickProfilePhoto();
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () async {
                  await _pickProfilePhoto();
                },
                child: Text(
                  'Change Profile Photo',
                  style: TextStyle(
                    fontFamily: 'Inria Serif',
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                    height: 1.2,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Change Your Name',
                  labelStyle: TextStyle(
                    fontFamily: 'Inria Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    letterSpacing: 0.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Change Your Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Inria Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    letterSpacing: 0.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                textAlign: TextAlign.center,
                obscureText: true,
              ),
              SizedBox(height: 16),
              Container(
                width: 230,
                height: 50,
                margin: EdgeInsets.symmetric(),
                child: ElevatedButton(
                  onPressed: () async {
                    await _saveChanges(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF149EC5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                      side: BorderSide(width: 2, color: Color(0xFF149EC5)),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontFamily: 'Inria Sans',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.2,
                      letterSpacing: 0.0,
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

  Future<void> _saveChanges(BuildContext context) async {
    String name = nameController.text;
    String password = passwordController.text;

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updateDisplayName(name);

        if (password.isNotEmpty) {
          await user.updatePassword(password);
        }

        String? photoURL = await _uploadProfilePhoto(user);
        if (photoURL != null) {
          await user.updatePhotoURL(photoURL);
        }

        user.reload();
        print('Photo URL after reload: $photoURL');  // Debug print
        await _firestore.collection('users').doc(user.uid).update({
          'name': name,
          'photoURL': photoURL,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      print('Failed to update profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }
}
