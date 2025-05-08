import 'package:flutter/material.dart';
import 'package:pollutrack25/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  Future<Map<String, String?>> _loadProfileData() async {
    final sp = await SharedPreferences.getInstance();
    return {
      'name': sp.getString('name'),
      'surname': sp.getString('surname'),
      'gender': sp.getString('gender'),
      'dob': sp.getString('dob'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: TextStyle(fontSize: 36, color: Colors.black))),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 40, bottom: 20),
          child: FutureBuilder<Map<String, String?>>(
            future: _loadProfileData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Info about yourself", style: TextStyle(fontSize: 24, color: Colors.black45)),
                  SizedBox(height: 20),
                  _buildProfileData('Name', data['name']),
                  _buildProfileData('Surname', data['surname']),
                  _buildProfileData('Gender', data['gender']),
                  _buildProfileData('Date of Birth', data['dob']),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final sp = await SharedPreferences.getInstance();
                        await sp.remove('username');
                        await sp.remove('password');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileData(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text('$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value ?? '/',
              style: TextStyle(color: value == null ? Colors.red : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
