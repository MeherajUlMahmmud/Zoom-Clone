import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

showSnackBar(
  BuildContext context,
  String text,
  Color bgColor,
  Color textColor,
  int duration,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: bgColor,
      duration: Duration(milliseconds: duration),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

addStringToSF(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

addIntToSF(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

addBoolToSF(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

addDoubleToSF(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

getStringValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString(key);
  return stringValue;
}

getBoolValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? boolValue = prefs.getBool(key);
  return boolValue;
}

getIntValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? intValue = prefs.getInt(key);
  return intValue;
}

getDoubleValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double? doubleValue = prefs.getDouble(key);
  return doubleValue;
}

removeFromLocalStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

printLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Start");
  prefs.getKeys().forEach((key) {
    print(key);
    print(prefs.getString(key));
  });
  print("End");
}
