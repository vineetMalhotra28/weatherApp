import 'package:flutter/material.dart';
import 'package:weatherapp/consts/const.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/consts/style.dart';
import 'package:weatherapp/controller/homeController.dart';

import 'Models/CurrentCityWeather.dart';
import 'Models/cityWeatherForecast.dart';
import 'consts/customTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '$title',
      theme: CustomTheme.lighTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            DateFormat('yMMMMd').format(DateTime.now()).toString(),
            style: appBarTitle.copyWith(color: theme.primaryColor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (controller.lighttheme.value) {
                          Get.changeThemeMode(ThemeMode.dark);
                          controller.lighttheme.value = false;
                        } else {
                          Get.changeThemeMode(ThemeMode.light);
                          controller.lighttheme.value = true;
                        }
                        // Get.changeThemeMode(ThemeMode.dark);
                      },
                      icon: Obx(() => controller.lighttheme.value
                          ? Icon(
                              Icons.light_mode_rounded,
                              color: theme.primaryColor,
                            )
                          : Icon(
                              Icons.light_mode_rounded,
                              color: theme.primaryColor,
                            ))),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: theme.primaryColor,
                      ))
                ],
              ),
            )
          ],
        ),
        body: Obx(() => controller.currentCityLoading.value
            ? InkWell(
                onTap: () {
                  // print(controller.currentCityWeatherData.wind.deg);
                },
                child: CircularProgressIndicator())
            : FutureBuilder(
                future: controller.currentCityWeatherData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    // print(snapshot.data..wind?.speed);
                    return (Center(
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    CurrentCityWeather data = snapshot.data;
                    print(data.wind!.speed);
                    // print(snapshot.data..wind?.speed);
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          runSpacing: 10,
                          children: [
                            Text(
                              data.name.toString(),
                              style:
                                  cityTitle.copyWith(color: theme.primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/weather/${data.weather![0].icon}.png",
                                  width: 80,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '${data.main!.temp}' + '$degree',
                                      style: cityTitle.copyWith(
                                          color: theme.primaryColor)),
                                  TextSpan(
                                    text: '${data.weather![0].main}',
                                    style: blackText.copyWith(
                                        color: theme.primaryColor),
                                  ),
                                ])),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_upward),
                                Text(
                                  '${data.main!.tempMax}',
                                  style: TextStyle(color: theme.primaryColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.arrow_downward),
                                Text(
                                  '${data.main!.tempMin}',
                                  style: TextStyle(color: theme.primaryColor),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(3, (index) {
                                var weatherStr = [
                                  '${data.main!.pressure}',
                                  '${data.main!.humidity}%',
                                  '${data.wind!.speed}Km/ h'
                                ];
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey[300],
                                      padding: EdgeInsets.all(10),
                                      child: Image.asset(
                                        weatherImages[index],
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      weatherStr[index],
                                      style: blackText.copyWith(
                                          color: theme.primaryColor),
                                    )
                                  ],
                                );
                              }),
                            ),
                            Divider(
                              thickness: 2,
                              color: cardColor,
                            ),
                            SizedBox(
                              height: 150,
                              child: FutureBuilder(
                                  future: controller.currentCityForecastData,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      // print(snapshot.data.cod);
                                      return (Center(
                                        child: CircularProgressIndicator(),
                                      ));
                                    } else {
                                      CurrentCityWeatherForecast data =
                                          snapshot.data;
                                      // for(var item in  data ){

                                      // }
                                      // data forEach;((k,v) => print('${k}: ${v}'));
                                      var dateNow = DateFormat('y-M-d')
                                          .format(DateTime.now())
                                          .toString();
                                      // var newDate = DateFormat('y-M-d')
                                      //     .format()
                                      //     .toString();

                                      // print(date);
                                      return ListView.builder(

                                          // padding: EdgeInsets.symmetric(horizontal: 10),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: 6,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2),
                                              width: 100,
                                              height: 100,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${index + 1}" + "PM" + "",
                                                    style: whiteText,
                                                  ),
                                                  Image.asset(
                                                    "assets/weather/02n.png",
                                                    width: 60,
                                                  ),
                                                  Text(
                                                    "${index + 1}" +
                                                        "0$degree" +
                                                        "C",
                                                    style: whiteText,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                  }),
                            ),
                            Divider(
                              thickness: 2,
                              color: cardColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Next 7 days',
                                  style: blackText.copyWith(
                                      color: theme.primaryColor),
                                ),
                                Text(
                                  'View All',
                                  style: blackText.copyWith(color: cardColor),
                                ),
                              ],
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var day = DateFormat('EEEE')
                                      .format(DateTime.now()
                                          .add(Duration(days: index + 1)))
                                      .toString();
                                  return Card(
                                    color: theme.cardColor,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          day,
                                          style: blackText,
                                        )),
                                        Image.asset(
                                          "assets/weather/09n.png",
                                          width: 50,
                                        ),
                                        Expanded(
                                            child: Text(
                                                "${index + 1}" "0$degree")),
                                        Text(
                                          '30$degree/ 20$degree',
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 3,
                                  );
                                },
                                itemCount: 7),
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }
}
