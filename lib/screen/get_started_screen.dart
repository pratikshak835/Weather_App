import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/bloc/weather_bloc.dart';
import 'package:grocery_app/bloc/weather_bloc_event.dart';
import 'package:grocery_app/screen/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/weather.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherFactory weatherFactory =
        WeatherFactory('d0c2344a6c5103533bf70487195132ca');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: 300,
              width: 600,
              decoration: const BoxDecoration(color: Color(0XFFFFAB40)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 170.0, right: 15, left: 15),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/1.png',
                    scale: 2,
                  ),
                ),
                const Text(
                  'Discover the weather in your city',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, right: 8.0, left: 8.0),
                  child: Text(
                    'Get to know your weather maps and radar precipitation forecast ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    width: 480.0, // Adjust width as needed
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FutureBuilder(
                                future: _determinePosition(),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return BlocProvider<WeatherBloc>(
                                      create: (context) => WeatherBloc(
                                          weatherFactory)
                                        ..add(
                                          FetchWeather(snap.data as Position),
                                        ),
                                      child: HomeScreen(
                                        position: snap.data as Position,
                                      ),
                                    );
                                  } else if (snap.hasError) {
                                    return Center(
                                      child: Text('$snap.hasError'),
                                    );
                                  } else {
                                    return const Scaffold(
                                      body: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ));
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await openAppSettings();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await openAppSettings();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await openAppSettings();
  }
  Position position = await Geolocator.getCurrentPosition();
  // print('Current position: ${position.latitude}, ${position.longitude}');
  return position;
}

/*
import 'dart:ui';
import 'dart:ui';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/bloc/weather_bloc.dart';
import 'package:grocery_app/bloc/weather_bloc.dart';
import 'package:grocery_app/bloc/weather_bloc_event.dart';
import 'package:grocery_app/bloc/weather_bloc_event.dart';
import 'package:grocery_app/screen/home_screen.dart';
import 'package:grocery_app/screen/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/weather.dart';
import 'package:weather/weather.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherFactory weatherFactory =
        WeatherFactory('d0c2344a6c5103533bf70487195132ca');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: 300,
              width: 600,
              decoration: const BoxDecoration(color: Color(0XFFFFAB40)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 170.0, right: 15, left: 15),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/1.png',
                    scale: 2,
                  ),
                ),
                const Text(
                  'Discover the weather in your city',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, right: 8.0, left: 8.0),
                  child: Text(
                    'Get to know your weather maps and radar precipitation forecast ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    width: 480.0, // Adjust width as needed
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        // Show loader
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                        Position? position = await _determinePosition(context);

                        // Hide loader
                        Navigator.of(context).pop();

                        if (position != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<WeatherBloc>(
                                create: (context) => WeatherBloc(weatherFactory)
                                  ..add(
                                    FetchWeather(position),
                                  ),
                                child: HomeScreen(
                                  position: position,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Position?> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show dialog to enable location services
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text('Please enable location services to continue.'),
          actions: [
            TextButton(
              onPressed: () async {
                const AndroidIntent intent = AndroidIntent(
                  action: 'android.settings.LOCATION_SOURCE_SETTINGS',
                );
                await intent.launch();
                Navigator.of(context).pop();
              },
              child: const Text('Enable'),
            ),
          ],
        ),
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Show dialog to enable location permissions
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permissions Denied'),
            content: const Text(
                'Location permissions are denied. Please grant permissions to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Geolocator.openAppSettings();
                },
                child: const Text('Grant Permissions'),
              ),
            ],
          ),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permissions Permanently Denied'),
          content: const Text(
              'Location permissions are permanently denied. We cannot request permissions.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
*/
