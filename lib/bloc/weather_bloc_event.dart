import 'package:geolocator/geolocator.dart';

abstract class WeatherBlocEvent {}

class FetchWeather extends WeatherBlocEvent {
  final Position position;

  FetchWeather(this.position);
}
