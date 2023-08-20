import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'additional_info_ item.dart';
import 'hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherData;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Osun";
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,nigeria&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw "Unexpected Error getting weather info for $cityName";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weatherData = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weatherData = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      // Body Section
      body: FutureBuilder(
        future: weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB00020),
                ),
              ),
            );
          }

          final data = snapshot.data as Map<String, dynamic>;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentWeather = data['list'][0]['weather'][0]['main'];
          final currentWeatherPressure = data['list'][0]['main']['pressure'];
          final currentWeatherHumidity = data['list'][0]['main']['humidity'];
          final currentWeatherWindSpeed = data['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Main Card
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
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          Text(
                            '$currentTemp K',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Icon(
                            currentWeather == 'Clouds'
                                ? Icons.cloud
                                : currentWeather == 'Rain'
                                    ? Icons.water_drop
                                    : currentWeather == 'Clear'
                                        ? Icons.wb_sunny
                                        : Icons.wb_sunny,
                            size: 64,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            '$currentWeather',
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Weather Forecast Cards
              const Text(
                "Hourly Forecast",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for (int i = 0; i < 5; i++)
              //         HourlyForecastItem(
              //           time: data['list'][i + 1]['dt'].toString(),
              //           icon: data['list'][i + 1]['weather'][0]['main'] ==
              //                       'Clouds' ||
              //                   data['list'][i + 1]['weather'][0]['main'] ==
              //                       "Rain"
              //               ? Icons.cloud
              //               : Icons.sunny,
              //           value: data['list'][i + 1]['main']['temp'].toString(),
              //         ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final hourlyForecast = data['list'][index + 1];
                    final hourlySky =
                        data['list'][index + 1]['weather'][0]['main'];
                    final time = DateTime.parse(hourlyForecast['dt_txt']);
                    return HourlyForecastItem(
                      time: DateFormat.jm().format(time),
                      icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                          ? Icons.cloud
                          : Icons.sunny,
                      value: hourlyForecast['main']['temp'].toString(),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Additional Weather Forecast Cards
              const Text(
                "Additional Information",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    title: "Humidity",
                    value: currentWeatherHumidity.toString(),
                  ),
                  AdditionalInfoItem(
                    icon: Icons.air,
                    title: "Wind Speed",
                    value: currentWeatherWindSpeed.toString(),
                  ),
                  AdditionalInfoItem(
                    icon: Icons.ac_unit,
                    title: "Pressure",
                    value: currentWeatherPressure.toString(),
                  ),
                ],
              )
            ]),
          );
        },
      ),
    );
    // The body Section
  }
}
