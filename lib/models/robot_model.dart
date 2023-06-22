// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nao_app/api/robot_api_interface.dart';

class Enum {
  List<String> items = [];
  String selectedItem;

  Enum({required this.items, required this.selectedItem});
}

class RobotModel implements RobotInterface {
  final String ipAddress;
  String name;

  String voice;
  String language;

  RobotModel(
      {required this.ipAddress,
      this.name = "",
      this.voice = "",
      this.language = ""});

  Future<int> connect(String port) async {
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
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('statusCode', 408);
    }); */

    return response.statusCode;
  }

/*   RobotModel copyWith({
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
  int get hashCode => ipAddress.hashCode; */

  @override
  Future<void> setPosture(String posture) async {
    var url = Uri.http('$ipAddress:8080', '/api/move/posture');
    var headers = {"Content-type": "application/json"};
    var body =
        '{"enableArmsInWalkAlgorithm": true, "posture": "$posture", "speed": ${1}}';

    if (kDebugMode) {
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
  }

  @override
  Future<void> move(Object moveObject) async {
    var url = Uri.http('$ipAddress:8080', '/api/move/movement');
    var headers = {"Content-type": "application/json"};
    var body = json.encode(moveObject);
    if (kDebugMode) {
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

  @override
  String getVideoStream() {
    var url = Uri.http('$ipAddress:8080', '/api/vision/video_feed');

    return url.toString();
  }

  @override
  Future<void> handleTajChi(bool isTajChiEnabled) async {
    var headers = {"Content-type": "application/json"};
    Uri url;
    if (isTajChiEnabled) {
      url = Uri.http('$ipAddress:8080', '/api/behavior/stop_taj_chi');
    } else {
      url = Uri.http('$ipAddress:8080', '/api/behavior/do_taj_chi');
    }

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Future<void> saySomething(Object audioObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/aduio/tts');
    try {
      var response = await http.post(url, headers: headers, body: audioObject);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Future<Enum> getLanguage() async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/language');

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('Success:.');
        var data = jsonDecode(response.body);
        List<String> languages = List<String>.from(data['language']);
        return Future.value(Enum(items: languages, selectedItem: languages[0]));
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    return Future.value(Enum(items: [], selectedItem: ""));
  }

  @override
  Future<Enum> getVoice() async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/voice');

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('Success:.');
        var data = jsonDecode(response.body);
        List<String> voices = List<String>.from(data['voice']);
        return Future.value(Enum(items: voices, selectedItem: voices[0]));
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    return Future.value(Enum(items: [], selectedItem: ""));
  }

  @override
  Future<void> setLanguage(Object languageObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/language');
    try {
      var response =
          await http.post(url, headers: headers, body: languageObject);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Future<void> setVoice(Object voiceObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/voice');
    try {
      var response = await http.post(url, headers: headers, body: voiceObject);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Future<int> getVolume() async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/volume');

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('Success:.');
        var data = jsonDecode(response.body);
        return Future.value(data);
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    return Future.value(0);
  }

  @override
  Future<void> setVolume(Object volumeObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    try {
      var response = await http.post(url, headers: headers, body: volumeObject);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  // Getter
  Future<double> getBattery() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/config/battery');
    var response = await http.get(url);
    
    print(response.statusCode.toString() + ': ' + response.body);

    if (response.statusCode == 200) {
      return double.parse(response.body) / 100.0;
    }
    else {
      return 0.5;
    }
  }

  Future<double> getWifi() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/config/wifi_strength');
    var response = await http.get(url);
    
    print(response.statusCode.toString() + ': ' + response.body);

    if (response.statusCode == 200) {
      return double.parse(response.body) / 100.0;
    }
    else {
      return 0.5;
    }
  }

  Future<double> getBrightness() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/vision/brightness');
    var response = await http.get(url);

    print(response.statusCode.toString() + ': ' + response.body);
    
    if (response.statusCode == 200) {
      return double.parse(response.body) / 255.0;
    }
    else {
      return 0.5;
    }
  }

  Future<List<String>> getLanguage() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/language');
    var response = await http.get(url);

    print(response.statusCode.toString() + ': ' + response.body);
    
    if (response.statusCode == 200) {
      
      List<String> languageValues = response.body.split(',');
      
      if (language == "") {
        language = languageValues[0];
      }

      return languageValues;
    }
    else {
      return <String>[];
    }
  }

  Future<List<String>> getVoice() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/voice');
    var response = await http.get(url);
    
    print(response.statusCode.toString() + ': ' + response.body);

    if (response.statusCode == 200) {
      List<String> voiceValues = response.body.split(',');
      
      if (voice == "") {
        voice = voiceValues[0];
      }

      return voiceValues;
    }
    else {
      return <String>[];
    }
  }

  Future<double> getVolume() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    var response = await http.get(url);

    print(response.statusCode.toString() + ': ' + response.body);
    
    if (response.statusCode == 200) {
      return double.parse(response.body) / 100.0;
    }
    else {
      return 0.5;
    }
  }

  // Setter
  Future<void> setName(String name) async {
    name = name;
  }

  Future<void> setBrightness(double bri) async {    
    int bright = (bri * 255.0).round();

    Uri url = Uri.http('$ipAddress:8080', '/api/vision/brightness');
    var headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers:headers, body: '{"brightness": $bright}');

    print(response.statusCode.toString() + ': ' + response.body);
  }

  Future<void> setLanguage(String lng) async {
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/language');
    var headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers:headers, body: '{"language": "$lng"}');

    print(response.statusCode.toString() + ': ' + response.body);
  }

  Future<void> setVoice(String voice) async {
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/voice');
    var headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers:headers, body: '{"voice": "$voice"}');

    print(response.statusCode.toString() + ': ' + response.body);
  }

  Future<void> setVolume(double vol) async {
    int volume = (vol * 100.0).round();

    Uri url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    var headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers:headers, body: '{"volume": $volume}');

    print(response.statusCode.toString() + ': ' + response.body);
  }  
}
