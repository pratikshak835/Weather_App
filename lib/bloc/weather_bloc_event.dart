import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  FetchWeather(this.position);
  final Position position;

  @override
  List<Object> get props => [position];
}

class StopFetchingWeather extends WeatherBlocEvent {}
