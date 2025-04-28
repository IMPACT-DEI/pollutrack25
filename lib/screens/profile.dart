import 'package:flutter/material.dart';
import 'package:pollutrack25/models/dataProvider.dart';
import 'package:pollutrack25/screens/login.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              SizedBox(height: 5),
              Text(
                "Info about you and your preferences",
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Surname'),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: ElevatedButton(
                    child: Text('Save and exit'),
                    onPressed: () {
                      // Pop the current screen and call the setUserName method
                      // with the values from the text fields
                      if (_nameController.text.isNotEmpty) {
                        Provider.of<DataProvider>(
                          context,
                          listen: false,
                        ).setUserName(
                          _nameController.text,
                          _surnameController.text,
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About", style: TextStyle(fontSize: 16)),
                    Text(
                      "Pollutrack aims to improve the consciousness of the user to the air pollutants issue. The user can track the amount of pollutants they has been exposed to during the day and learn useful information about them.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("version 2.0.0"),
                    ),
                  ],
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: ElevatedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      // logout button; pushReplacement because I don't want the user can go back to the exposure page when logged out
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
