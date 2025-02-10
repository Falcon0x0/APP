import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/Additional_Info_Item.dart';
import 'package:weather_app/secrets.dart';

import 'hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    String cityName = 'London';
    final res = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName.uk&APIPI=$openWeatherAPIKey",
      ),
    );
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //MAIN CARD
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300 K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Rain',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 8,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(
                    time: '00.00',
                    icon: Icons.cloud,
                    temperature: '301.22',
                  ),
                  HourlyForecastItem(
                    time: '03.00',
                    icon: Icons.sunny,
                    temperature: '300.52',
                  ),
                  HourlyForecastItem(
                    time: '06.00',
                    icon: Icons.cloud,
                    temperature: '302.22',
                  ),
                  HourlyForecastItem(
                    time: '09.00',
                    icon: Icons.sunny,
                    temperature: '304.22',
                  ),
                  HourlyForecastItem(
                    time: '10.00',
                    icon: Icons.cloud,
                    temperature: '301.22',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Additinal Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoITEM(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoITEM(
                  icon: Icons.air,
                  label: 'Windspeed',
                  value: '7.67',
                ),
                AdditionalInfoITEM(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1006',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
