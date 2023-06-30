// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nao_app/api/robot_api_interface.dart';
import 'package:ssh2/ssh2.dart';

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

  Future<int> connect(String port, String username, String pw) async {
    
    await installBackendOnNAO(username, pw);

    //NAO URL
    var url = Uri.http('$ipAddress:8080', '/api/connect');

    final headers = {"Content-type": "application/json"};
    var json = '{"ip_address": "$ipAddress", "port": "$port"}';

    //NAO response
    final response = await http
        .post(url, headers: headers, body: json)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('statusCode', 408);
    });


    return response.statusCode;
  }

  Future<void> installBackendOnNAO(String username, String pw) async{
    // ignore: unnecessary_new
    var client = new SSHClient(
      host: ipAddress,
      port: 22,
      username: username,
      passwordOrKey: pw,
    );

    var result = '';

    try {
      result = await client.connect() ?? 'Null result';

      if (result == "session_connected") {

        await client.execute("wget https://github.com/sbaer2306/NAO-APP-Pythonserver-API/archive/refs/heads/main.zip\n");
        await client.execute("unzip -o main.zip && rm main.zip\n");
        await client.execute("pip install --user nao flask\n");
        await client.execute("PYTHONPATH=/opt/aldebaran/lib/python2.7/site-packages nohup /usr/bin/python2 /data/home/nao/NAO-APP-Pythonserver-API-main/app.py > log.txt 2>&1 &\n");
      }
      await client.disconnect();
    }catch(error){if (kDebugMode) {
      print(error);
    }}
  }

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
      await http.get(url, headers: headers);
    } catch (error) {
      if (kDebugMode) {
        print('Error occurred: $error');
      }
    }
  }

  @override
  Future<void> saySomething(Object audioObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/tts');
    var bodyObj = json.encode(audioObject);
    try {
      await http.post(url, headers: headers, body:bodyObj );
    } catch (error) {
      if (kDebugMode) {
        print('Error occurred: $error');
      }
    }
  }

  @override
  Future<Enum> getLanguage() async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/language');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<String> languages = List<String>.from(data['language']);
      return Future.value(Enum(items: languages, selectedItem: languages[0]));
    }

    return Future.value(Enum(items: [], selectedItem: ""));
  }


  Future<Enum> getVoice() async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/voice');

    var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<String> voices = List<String>.from(data['voice']);
        return Future.value(Enum(items: voices, selectedItem: voices[0]));
    }

    return Future.value(Enum(items: [], selectedItem: ""));
  }



  @override
  Future<void> setLanguage(Object languageObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/language');
    var langObj = json.encode(languageObject);
    await http.post(url, headers: headers, body: langObj);
  }


  @override
  Future<void> setVoice(Object voiceObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/voice');
    var bodyObj = json.encode(voiceObject);

    await http.post(url, headers: headers, body: bodyObj);
  }

  @override
  Future<void> setVolume(Object volumeObject) async {
    var headers = {"Content-type": "application/json"};
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    var bodyObj = json.encode(volumeObject);
    await http.post(url, headers: headers, body: bodyObj);
  }

  // Getter
  Future<double> getBattery() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/config/battery');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['battery'].toDouble() / 100.0;
    }
    else {
      return 0.5;
    }
  }

  Future<double> getWifi() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/config/wifi_strength');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['strength'].toDouble() / 100.0;
    }
    else {
      return 0.5;
    }
  }

  Future<double> getBrightness() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/vision/brightness');
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['brightnesss'].toDouble() / 255.0;
    }
    else {
      return 0.5;
    }
  }

  Future<double> getVolume() async {
    Uri url = Uri.http('$ipAddress:8080', '/api/audio/volume');
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['volume'].toDouble() / 100.0;
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
    await http.post(url, headers:headers, body: '{"brightness": $bright}');
  }
}
