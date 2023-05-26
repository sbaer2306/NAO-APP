// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nao_app/api/robot_api_interface.dart';

class RobotModel implements RobotInterface {
  final String ipAddress;
  final String name;

  RobotModel({required this.ipAddress, this.name = ""});

  Future<int> connect() async {
    //TODO:PORT in Maske
    var port = '9559';

    //Test URL
    var url = Uri.https('httpbin.org', 'post');
    //NAO URL
    //var url = Uri.http('$ipAddress:8080', '/api/connect');

    final headers = {"Content-type": "application/json"};
    var json = '{"ip_address": "$ipAddress", "port": "$port"}';

    //TEST response
    final response = await http.post(url, body: {'name': 'test'}).timeout(
        const Duration(seconds: 10), onTimeout: () {
      return http.Response('statusCode', 408);
    });

    //NAO response
/*     final response = await http
        .post(url, headers: headers, body: json)
        .timeout(const Duration(seconds: 7), onTimeout: () {
      return http.Response('statusCode', 408);
    }); */

    return response.statusCode;
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

  @override
  Future<void> setPosture(String posture) async {
    var url = Uri.http('$ipAddress:8080', '/api/move/posture');
    var headers = {"Content-type": "application/json"};
    var body = json.encode({
      'enableArmsInWalkAlgorithm': true,
      'posture': posture,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Success: $posture");
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Future<void> move(Object moveObject) async {
    var url = Uri.http('$ipAddress:8080', '/api/move/movement');
    var headers = {"Content-type": "application/json"};
    var body = json.encode(moveObject);

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Success: ${json.encode(moveObject)}.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }
}
