// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grocery_app/bloc/weather_bloc_event.dart';
// import 'package:grocery_app/bloc/weather_bloc_states.dart';
// import 'package:weather/weather.dart';
//
// class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
//   String API_KEY = "d0c2344a6c5103533bf70487195132ca";
//   WeatherBloc() : super(WeatherBlocInitial()) {
//     on<FetchWeather>((event, emit) async {
//       emit(WeatherBlocLoading());
//       try {
//         // final client = HttpService.getClient();
//         WeatherFactory wf = WeatherFactory(
//           API_KEY,
//           language: Language.ENGLISH,
//         );
//
//         // print(
//         //     'Fetching weather for location: ${event.position.latitude}, ${event.position.longitude}');
//
//         Weather weather = await wf.currentWeatherByLocation(
//           event.position.latitude,
//           event.position.longitude,
//         );
//
//         print('Weather fetched: $weather');
//
//         emit(WeatherBlocSuccess(weather));
//       } catch (e) {
//         // print('Error fetching weather.....: $e');
//         emit(WeatherBlocFailure());
//       }
//     });
//   }
// }

// weather_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/weather_bloc_event.dart';
import 'package:grocery_app/bloc/weather_bloc_states.dart';
import 'package:weather/weather.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final WeatherFactory weatherFactory;

  WeatherBloc(this.weatherFactory) : super(WeatherBlocInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
      FetchWeather event, Emitter<WeatherBlocState> emit) async {
    emit(WeatherBlocLoading());
    try {
      Weather weather = await weatherFactory.currentWeatherByLocation(
          event.position.latitude, event.position.longitude);
      List<Weather> forecast = await weatherFactory.fiveDayForecastByLocation(
          event.position.latitude, event.position.longitude);

      emit(WeatherBlocSuccess(weather: weather, forecast: forecast));
    } catch (e) {
      emit(WeatherBlocFailure());
    }
  }
}
