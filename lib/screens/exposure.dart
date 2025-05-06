import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pollutrack25/models/dataProvider.dart';
import 'package:pollutrack25/screens/profile.dart';
import 'package:pollutrack25/utils/line_chart_HR.dart';
import 'package:pollutrack25/utils/line_chart_pm25.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Exposure screen is stateful because it needs to update the UI (date and exposure value) when the user changes the date
class Exposure extends StatelessWidget {
  const Exposure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 10,
            bottom: 20,
          ),
          child:
          // Consumer widget is used to listen to the changes in the DataProvider
          Consumer<DataProvider>(
            builder: (context, provider, child) {
              // SingleChildScrollView is used to make the screen scrollable
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FutureBuilder(
                          future: SharedPreferences.getInstance(),
                          builder: ((context, snapshot) {
                            if(snapshot.hasData){
                              final sp = snapshot.data as SharedPreferences;
                              if(sp.getString('name') == null){
                                return Text("Hello, User", style: TextStyle(fontSize: 36));
                              }
                              else{
                                  final name = sp.getString('name');
                                  return Text("Hello, $name", style: TextStyle(fontSize: 36));
                              }
                            }
                            else{
                              return CircularProgressIndicator();
                            }
                            
                          }),
                        ),
                        Spacer(),
                        IconButton(
                          icon: const Icon(Icons.person),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Daily Personal Exposure',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // InkWell widget is used to make the icons clickable
                          child: InkWell(
                            onTap: () {
                              // function that calls the provider function passing the date before the current date
                              provider.getDataOfDay(
                                provider.currentDate.subtract(
                                  const Duration(days: 1),
                                ),
                              );
                            },
                            child: const Icon(Icons.navigate_before),
                          ),
                        ),
                        Text(
                          DateFormat('EEE, d MMM').format(provider.currentDate),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // function that calls the provider function passing the date after the current date
                              provider.getDataOfDay(
                                provider.currentDate.add(
                                  const Duration(days: 1),
                                ),
                              );
                            },
                            child: const Icon(Icons.navigate_next),
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
                    provider.loading
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 10,
                            bottom: 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (provider.exposure.toInt()).toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                provider.exposure / 100 < 0.33
                                    ? "Low"
                                    : provider.exposure / 100 > 0.33 &&
                                        provider.exposure / 100 < 0.66
                                    ? "Medium"
                                    : "High",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 10,
                                ),
                                height: 15,
                                // ClipRect is used to clip the LinearProgressIndicator
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  // LinearProgressIndicator is used to show the progress of the exposure value
                                  // value is set to the exposure value divided by 100 to get the percentage
                                  child: LinearProgressIndicator(
                                    value: provider.exposure / 100,
                                    backgroundColor: Colors.grey.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    const SizedBox(height: 20),
                    const Text("Daily Trend", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 5),
                    const Text(
                      "See how much you’ve been exposed throughout the day",
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    const SizedBox(height: 30),
                    const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Heart Rate',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.favorite),
                          ],
                        ),

                        SizedBox(height: 15),
                      ],
                    ),
                    provider.loading
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: LineChartHr(hrData: provider.heartRates),
                        ),
                    const SizedBox(height: 30),
                    const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pm2.5',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.air_outlined),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    provider.loading
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: LineChartPm(pmData: provider.pm25),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
