import 'package:flutter/material.dart';
import 'package:pollutrack25/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? surname;
  String? gender;
  String? dob;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      surname = prefs.getString('surname');
      gender = prefs.getString('gender');
      dob = prefs.getString('dob');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: TextStyle(fontSize: 36, color: Colors.black))),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 40,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Info about yourself",
                style: TextStyle(fontSize: 24, color: Colors.black45),
              ),
              SizedBox(height: 20),
              // Mostra i dati o un messaggio che indicano che mancano
              _buildProfileData('Name', name),
              _buildProfileData('Surname', surname),
              _buildProfileData('Gender', gender),
              _buildProfileData('Date of Birth', dob),
              SizedBox(height: 30),

              Center(child: ElevatedButton(onPressed: (){
                // Logout logic
                _logout();
              }, child: Text('Logout'))),
            ],
          ),
        ),
      ),
    );
  }

  // Funzione per il logout
  void _logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('username'); 
    await sp.remove('password');
    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  ); // Naviga alla pagina di login
  }

  // Funzione per costruire i dati del profilo
  Widget _buildProfileData(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? '/', // Mostra 'Data missing' se il valore è nullo
              style: TextStyle(color: value == null ? Colors.red : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
