import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '0f4abf9e48d2bdc335bac3abbe5c0e4b';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //--------------------------------------------
  void getCityWeather(String cityNames) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityNames&appid=$apiKey'));
    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      var weatherDescription = jsonDecode(data)['weather'][0]['main'];
      var temperature = jsonDecode(data)['main']['temp'];
      var cityName = jsonDecode(data)['name'];

      // print(data); //print json all data
      print(response.statusCode);
      print(temperature);
      print(weatherDescription);
      print(longitude);
      print(cityName);
      print("you entered city name = $cityNames");
    } else {
      print(response.statusCode);
    }
  }

  //--------------------------------------------
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              icon: Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide.none,
              ),
            ),
            controller: nameController,
          ),
          ElevatedButton(
            onPressed: () {
              getCityWeather(nameController.text);
            },
            child: Text('Get Location Weather Data'),
          ),
        ],
      ),
    );
  }
}
