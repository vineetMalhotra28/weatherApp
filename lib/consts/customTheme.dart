import 'package:weatherapp/consts/const.dart';

class CustomTheme {
  static final lighTheme = ThemeData(
      fontFamily: "popins",
      cardColor: Colors.grey[200],
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.grey[800],
      iconTheme: IconThemeData(color: Colors.grey[600]));

  static final darkTheme = ThemeData(
      fontFamily: "popins",
      scaffoldBackgroundColor: bgColor,
      cardColor: Colors.grey[100],
      primaryColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white));
}
