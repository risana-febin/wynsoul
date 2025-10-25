import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/mainpage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String place = "";
  String phone = "";
  String email = "";

  bool isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "";
      place = prefs.getString('place') ?? "";
      phone = prefs.getString('phone') ?? "";
      email = prefs.getString('email') ?? "";

      _nameController.text = name;
      _placeController.text = place;
      _phoneController.text = phone;
      _emailController.text = email;
    });
  }

  void _saveUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('place', _placeController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('email', _emailController.text);

    setState(() {
      name = _nameController.text;
      place = _placeController.text;
      phone = _phoneController.text;
      email = _emailController.text;
      isEditing = false;
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen(initialIndex: 0)),
      (route) => false,
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          controller: controller,
          enabled: isEditing,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 0)),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _saveUserDetails();
              } else {
                setState(() {
                  isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileField("Name", _nameController),
            _buildProfileField("Place", _placeController),
            _buildProfileField(
              "Phone",
              _phoneController,
              keyboardType: TextInputType.phone,
            ),
            _buildProfileField(
              "Email",
              _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            if (!isEditing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
