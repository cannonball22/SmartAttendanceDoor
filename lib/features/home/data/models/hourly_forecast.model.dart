import 'dart:convert';

import 'package:flutter/material.dart';

class HourlyForecast {
  IconData icon;
  String hour;
  String temperature;

  //
  //
  HourlyForecast(
      {required this.icon, required this.hour, required this.temperature});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
      'hour': hour,
      'temperature': temperature,
    };
  }

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
    return HourlyForecast(
      icon: map['hour'],
      temperature: map['temperature'],
      hour: map['hour'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyForecast.fromJson(String source) =>
      HourlyForecast.fromMap(json.decode(source) as Map<String, dynamic>);
}
