import 'package:weather/weather.dart';

abstract class WeatherBlocState {}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}

class WeatherBlocSuccess extends WeatherBlocState {
  final Weather weather;
  final List<Weather> forecast;

  WeatherBlocSuccess({required this.weather, required this.forecast});
}

class WeatherBlocFailure extends WeatherBlocState {}
