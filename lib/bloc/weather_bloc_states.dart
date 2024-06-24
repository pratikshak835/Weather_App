import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

class WeatherBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}

class WeatherBlocFailure extends WeatherBlocState {}

class WeatherBlocSuccess extends WeatherBlocState {
  WeatherBlocSuccess(this.weather);
  final Weather weather;

  @override
  List<Object?> get props => [weather];
}

class WeatherBlocStopped extends WeatherBlocState {}
