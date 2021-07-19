import 'package:flutter/material.dart';

import ' mqtt/mqtt_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo MQTT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MqttClientPofovu mqttClientPofovu = new MqttClientPofovu();

  @override
  void initState() {
    super.initState();

    mqttClientPofovu.prepare();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: <Widget>[
        Positioned(
            top: 10,
            left: 10,
            width: 100.0,
            height: 100.0,
            child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  debugPrint('button is pressed!');
                  mqttClientPofovu.publishMessage('hello fox!');
                },
                child: const Text('Say hi')))
      ]),
    );
  }
}
