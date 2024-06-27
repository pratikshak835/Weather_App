import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_app/bloc/weather_bloc.dart';
import 'package:grocery_app/bloc/weather_bloc_event.dart';
import 'package:grocery_app/bloc/weather_bloc_states.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.position});

  final Position position;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple.withOpacity(0.7),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      floatingActionButton: BlocBuilder<WeatherBloc, WeatherBlocState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              context.read<WeatherBloc>().add(FetchWeather(widget.position));
            },
            child: const Icon(Icons.refresh),
          );
        },
      ),
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
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: BlocBuilder<WeatherBloc, WeatherBlocState>(
              builder: (context, state) {
                if (state is WeatherBlocSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📍${state.weather.areaName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          getGreeting(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        getWeatherIcon(state.weather.weatherConditionCode!),
                        Center(
                          child: Text(
                            '${state.weather.temperature!.celsius!.round()}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            state.weather.weatherMain!.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            DateFormat('EEEE dd -')
                                .add_jm()
                                .format(state.weather.date!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            "Temp feels like ${state.weather.tempFeelsLike!.celsius!.round()}°C",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/11.png', scale: 8),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sunrise',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      DateFormat()
                                          .add_jm()
                                          .format(state.weather.sunrise!),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset('assets/12.png', scale: 8),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sunset',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      DateFormat()
                                          .add_jm()
                                          .format(state.weather.sunset!),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/13.png', scale: 8),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Temp Max',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "${state.weather.tempMax!.celsius!.round()}°C",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset('assets/14.png', scale: 8),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Temp Min',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "${state.weather.tempMin!.celsius!.round()}°C",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Forecast",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height:
                                  120, // Adjust the height of the horizontal ListView as needed
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.forecast.length,
                                itemBuilder: (context, index) {
                                  Weather forecastItem = state.forecast[index];
                                  return Container(
                                    width:
                                        200, // Customize card width as needed
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        DateFormat('EEEE dd ,')
                                            .add_jm()
                                            .format(forecastItem.date!),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "${forecastItem.temperature!.celsius!.round()}°C",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      leading: getWeatherForecastIcon(
                                          forecastItem.weatherConditionCode!),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (state is WeatherBlocLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherBlocFailure) {
                  return const Center(
                    child: Text(
                      'Failed to fetch weather data',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getWeatherIcon(int code) {
    if (code > 200 && code < 300) {
      return Image.asset('assets/1.png');
    } else if (code > 300 && code < 400) {
      return Image.asset('assets/2.png');
    } else if (code > 500 && code < 600) {
      return Image.asset('assets/3.png');
    } else if (code > 600 && code < 700) {
      return Image.asset('assets/4.png');
    } else if (code > 700 && code < 800) {
      return Image.asset('assets/5.png');
    } else if (code == 800) {
      return Image.asset('assets/6.png');
    } else if (code > 800 && code <= 804) {
      return Image.asset('assets/7.png');
    } else {
      return Image.asset('assets/7.png');
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else if (hour < 22) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  Widget getWeatherForecastIcon(int code) {
    if (code > 200 && code < 300) {
      return Image.asset('assets/1.png');
    } else if (code > 300 && code < 400) {
      return Image.asset('assets/2.png');
    } else if (code > 500 && code < 600) {
      return Image.asset('assets/3.png');
    } else if (code > 600 && code < 700) {
      return Image.asset('assets/4.png');
    } else if (code > 700 && code < 800) {
      return Image.asset('assets/5.png');
    } else if (code == 800) {
      return Image.asset('assets/6.png');
    } else if (code > 800 && code <= 804) {
      return Image.asset('assets/7.png');
    } else {
      return Image.asset('assets/7.png');
    }
  }
}
