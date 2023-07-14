import 'package:weatherapp/consts/const.dart';
import 'package:http/http.dart' as http;

import '../Models/CurrentCityWeather.dart';
import '../Models/cityWeatherForecast.dart';

class getWeatherProvider {
  var err = '';
  getLocationWeather({lat, long}) async {
    try {
      var jsonResponse = null;
      var response = await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=7498ed9aade5859d5aad63cd75bfcaa6&units=metric'),
          headers: {"Accept": "application/json"});
      // jsonResponse = json.decode(response.body);
      // var message = jsonResponse["message"];
      // print(jsonResponse);
      if (response.statusCode == 200) {
        var data = await currentCityWeatherFromJson(response.body.toString());
        return data;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // err = 'Error';
        return Error;
      } else {
        // showSnackBar('error'.tr, 'server_error'.tr, warningColor);
        // return status;
      }
    } catch (err) {
      // showSnackBar('error'.tr, 'server_error'.tr, warningColor);
      return print(err.toString());
    }
  }

  getLocationForcast({lat, long}) async {
    try {
      var jsonResponse = null;
      var response = await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=7498ed9aade5859d5aad63cd75bfcaa6&units=metric'),
          headers: {"Accept": "application/json"});
      // jsonResponse = json.decode(response.body);
      // var message = jsonResponse["message"];
      // print(jsonResponse);
      if (response.statusCode == 200) {
        var data =
            await currentCityWeatherForecastFromJson(response.body.toString());
        print('data is getting');
        return data;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // err = 'Error';
        Get.defaultDialog(title: 'Error');
        return Error;
      } else {
        Get.defaultDialog(title: 'Error');
        // showSnackBar('error'.tr, 'server_error'.tr, warningColor);
        // return status;
      }
    } catch (err) {
      // showSnackBar('error'.tr, 'server_error'.tr, warningColor);
      // return print(err.toString());
      Get.defaultDialog(title: err.toString());
    }
  }
}
