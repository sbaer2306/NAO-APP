// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:nao_app/api/robot_api_interface.dart';

class Enum {
  List<String> items = [];
  String selectedItem;

  Enum({required this.items, required this.selectedItem});
}

class RobotModelTest implements RobotInterface {
  final String ipAddress;
  String name;

  String voice;
  String language;

  RobotModelTest(
      {required this.ipAddress,
      this.name = "",
      this.voice = "",
      this.language = ""});

  Future<int> connect(String port, String username, String pw) async {
/*     var client = new SSHClient(
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
        await client.execute("unzip -o main.zip\n");
        await client.execute("pip install --user nao flask\n");
        await client.execute("python NAO-APP-Pythonserver-API-main/app.py & \n");
      }
      else {
        print("object");
      }
      //await client.disconnectSFTP();
      await client.disconnect();
    }catch(error){if (kDebugMode) {
      print(error);
    }} */
    //Test URL
    //var url = Uri.https('httpbin.org', 'post');
    //NAO URL


    //TEST response
/*     final response = await http.post(url, body: {'name': 'test'}).timeout(
        const Duration(seconds: 10), onTimeout: () {
      return http.Response('statusCode', 408);
    }); */

    //NAO response
    /*
    final response = await http
        .post(url, headers: headers, body: json)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('statusCode', 408);
    });
    return response.statusCode;
    */

    return 200;
  } 

  @override
  Future<void> setPosture(String posture) async {


    /*
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
    */


  }

  @override
  Future<void> move(Object moveObject) async {

    /*
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
    */

  }

  @override
  String getVideoStream() {
    var url = Uri.http('$ipAddress:8080', '/api/vision/video_feed');

    return url.toString();
  }

  @override
  Future<void> handleTajChi(bool isTajChiEnabled) async {

    /*
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
    */
  }

  @override
  Future<void> saySomething(Object audioObject) async {

    
    /*
    try {
      print("before post");
      var response = await http.post(url, headers: headers, body:bodyObj );
      print("response ${response}");
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    */

  }

  @override
  Future<Enum> getLanguage() async {


    /*
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
    */
    return Future.value(Enum(items: ['German', 'Japanese', 'Chinese', 'English'], selectedItem: "English"));
  }


  Future<Enum> getVoice() async {

    /*
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
    */
    return Future.value(Enum(items: ["Julia22Enhanced", "maki_n16", "naoenu", "naomnc"], selectedItem: "Julia22Enhanced"));
  }

  @override
  Future<void> setLanguage(Object languageObject) async {

    
    /*
    try {
      var response =
          await http.post(url, headers: headers, body: langObj);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    */

  }


  @override
  Future<void> setVoice(Object voiceObject) async {

    
    /*
    try {
      var response = await http.post(url, headers: headers, body: bodyObj);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    */


  }

  @override
  Future<void> setVolume(Object volumeObject) async {

    
    /*
    try {
      var response = await http.post(url, headers: headers, body: bodyObj);
      if (response.statusCode == 200) {
        print('Success:.');
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    */


  }

  // Getter
  Future<double> getBattery() async {

    /*
    var response = await http.get(url);
    
    print(response.statusCode.toString() + ': ' + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['battery'].toDouble() / 100.0;
    }
    else {
      return 0.5;
    }
    */

    return 0.9;
  }

  Future<double> getWifi() async {

    /*
    var response = await http.get(url);
    
    print(response.statusCode.toString() + ': ' + response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['strength'].toDouble() / 100.0;
    }
    else {
      return 0.5;
    }
    */
    return 0.1;
  }

  Future<int> getBrightness() async {

    /*
    var response = await http.get(url);

    print(response.statusCode.toString() + ': ' + response.body);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['brightnesss'].toDouble() / 255.0;
    }
    else {
      return 0.5;
    }
    */
    return 70;
  }

  Future<int> getVolume() async {

    /*
    var response = await http.get(url);

    print(response.statusCode.toString() + ': ' + response.body);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['volume'].toDouble() / 100.0;
    }
    else {
      return 0.5;
    }
    */
    return 10;
  }
  // Setter
  Future<void> setName(String name) async {
    name = name;
  }

  Future<void> setBrightness(Object bri) async {    

  }
}
