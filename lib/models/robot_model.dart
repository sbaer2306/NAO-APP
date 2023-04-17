import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RobotModel {
  final String ipAdress;

  RobotModel({
    required this.ipAdress,
  });

  Future<int> connect() async {
    //TODO:PORT in Maske
    var port= '8080';
    var url = Uri.http(ipAdress+':'+port, '/api/connect');
    final headers = {"Content-type": "application/json"};
    var json = '{"ip_address": "${ipAdress}", "port": "${port}"}';
    var response = await http.post(url, headers: headers, body: json);
    var statusCode = response.statusCode;
    if (kDebugMode) {
      print(statusCode);
      if (statusCode == 200) {
        print("Verbindung erfolgreich");
      }
    }
    return statusCode;
  }


  RobotModel copyWith({
    String? ipAdress,
  }) {
    return RobotModel(
      ipAdress: ipAdress ?? this.ipAdress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'IP': ipAdress,
    };
  }

  factory RobotModel.fromMap(Map<String, dynamic> map) {
    return RobotModel(
      ipAdress: map['IP'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RobotModel.fromJson(String source) =>
      RobotModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RobotModel(IP: $ipAdress)';

  @override
  bool operator ==(covariant RobotModel other) {
    if (identical(this, other)) return true;

    return other.ipAdress == ipAdress;
  }

  @override
  int get hashCode => ipAdress.hashCode;
}
