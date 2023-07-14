import 'package:weatherapp/consts/const.dart';
import 'package:weatherapp/Providers/get_Waether_Provider.dart';
import 'package:geolocator/geolocator.dart';

import '../Models/CurrentCityWeather.dart';

class HomeController extends GetxController {
  var lighttheme = true.obs;
  dynamic currentCityWeatherData;
  dynamic currentCityForecastData;
  var currentCityLoading = false.obs;
  var currentCityWeatherLoading = false.obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;
  @override
  void onInit() async {
    // language Prefernce
    await getUserLocation();
    currentCityWeatherData = getWeatherProvider()
        .getLocationWeather(lat: lat.value, long: long.value);
    currentCityForecastData = getWeatherProvider()
        .getLocationForcast(lat: lat.value, long: long.value);
    // getNotificationCount();
    super.onInit();
  }

  getUserLocation() async {
    try {
      currentCityLoading.value = true;
      print('Getting Data');
      currentCityWeatherLoading.value = true;
      await _determinePosition().then((value) async {
        lat.value = value.latitude;
        long.value = value.longitude;
        print(value.latitude);
        print(value.longitude);
        // var locationData = await getWeatherProvider()
        //     .getLocationWeather(lat: value.latitude, long: value.longitude);
        // currentCityWeatherData =
        //     currentCityWeatherFromJson(locationData.body.toString());
        // currentCityWeatherData = currentCity;
        // print(currentCity.wind?.speed);
      });
    } catch (e) {
      Get.defaultDialog(title: e.toString());
      // print(e.toString());
    }
    currentCityLoading.value = false;
    currentCityWeatherLoading.value = false;
    print('Data Fetched');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
