import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pollutrack25/screens/login.dart';
import 'package:pollutrack25/screens/profile.dart';

class Exposure extends StatefulWidget {
  const Exposure({super.key});

  @override
  State<Exposure> createState() => _ExposureState();
}

class _ExposureState extends State<Exposure> {

  double? _exposure;
  DateTime? _currentDate;

  @override
  void initState() {
    _exposure = Random().nextDouble() * 100;
    _currentDate = DateTime.now();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10, bottom: 20),
            child: 
              SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, User",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Daily Personal Exposure',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _changeDate('previous');
                              },
                              child: const Icon(
                                Icons.navigate_before,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('EEE, d MMM').format(_currentDate!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _changeDate('next');
                              },
                              child: const Icon(
                                Icons.navigate_next,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Cumulative Exposure",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Total count of all the pollution you've breathed in the day",
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (_exposure!.toInt()).toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              _exposure! / 100 < 0.33
                                  ? "Low"
                                  : _exposure! / 100 > 0.33 &&
                                          _exposure! / 100 < 0.66
                                      ? "Medium"
                                      : "High",
                              style: const TextStyle(fontSize: 12, color: Colors.black45),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, bottom: 10),
                              height: 15,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: LinearProgressIndicator(
                                  value: _exposure! / 100,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Daily Trend",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "See how much you’ve been exposed throughout the day",
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                      ),
                      const SizedBox(height: 30),
                      const Column(
                        children:[
                            Text('No data available',
                            style: TextStyle(fontSize:16),
                            textAlign: TextAlign.center,)
                        ],
                      ),
                      const AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CircularProgressIndicator.adaptive()
                      ),      
                    ],
                  ),
                ),
        ),
      ),
    bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Login(),
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () async{
                final name =  await Navigator.of(context).push(MaterialPageRoute(builder:  (context) => Profile()));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Name updated! New name: $name'),
                    duration: const Duration(seconds: 3),
                  ),
                );
                
              },
            ),
          ],
        ),
      ),
    );
  }
void _changeDate(String direction) {
  setState(() {
    if (direction == 'previous') {
      _currentDate = _currentDate!.subtract(const Duration(days: 1));
      _exposure = Random().nextDouble() * 100;
    } else if (direction == 'next') {
      _currentDate = _currentDate!.add(const Duration(days: 1));
      _exposure = Random().nextDouble() * 100;
    }
  });
}
}