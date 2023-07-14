import 'const.dart';

const String degree = "°";
const String title = "Weather App";
const String apiKey = "Your API Key here";
const String currentEndpoint =
    "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}";
const String daysEndpoint =
    "api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}";
var weatherImages = [clouds, humidity, windspeed];
var weatherStrings = ['70%', '40%', '15Km/hr'];
