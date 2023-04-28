// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RobotModel {
  final String ipAddress;
  final String name;

  RobotModel({required this.ipAddress, this.name = ""});

  Future<int> connect() async {
    //Test Verbindung
    var url = Uri.https('httpbin.org', 'post');
    var response = await http.post(url, body: {'name': 'test'});

    //TODO:PORT in Maske
    //var port = '8080';
    //var url = Uri.http('$ipAdress:$port', '/api/connect');
    //final headers = {"Content-type": "application/json"};
    //var json = '{"ip_address": "$ipAddress", "port": "$port"}';
    //var response = await http.post(url, headers: headers, body: json);

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
    String? ipAddress,
  }) {
    return RobotModel(
      ipAddress: ipAddress ?? this.ipAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'IP': ipAddress,
    };
  }

  factory RobotModel.fromMap(Map<String, dynamic> map) {
    return RobotModel(
      ipAddress: map['IP'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RobotModel.fromJson(String source) =>
      RobotModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RobotModel(IP: $ipAddress)';

  @override
  bool operator ==(covariant RobotModel other) {
    if (identical(this, other)) return true;

    return other.ipAddress == ipAddress;
  }

  @override
  int get hashCode => ipAddress.hashCode;
}
