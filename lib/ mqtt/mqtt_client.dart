// import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:jinx/config.dart' as Config;

class MqttClientPofovu {
  late MqttClient cli;
  MqttConnectionState connectionState = MqttConnectionState.disconnected;

  void prepare() async {
    /// init
    cli = MqttServerClient.withPort(
        Config.broker, Config.indentifier, Config.port);
    cli.logging(on: true);
    cli.keepAlivePeriod = 30;

    /// callback func
    cli.onConnected = _onConnected;
    cli.onDisconnected = _onDisconnected;
    cli.onSubscribed = _onSubcribed;
    cli.onUnsubscribed = _onUnsubscribed;
    cli.onSubscribeFail = _onSubscribeFail;

    /// connect to mqtt server
    try {
      print('Connecting MQTT server ...');
      await cli.connect();
    } catch (e) {
      print(e);
      cli.disconnect();
    }

    /// check if conected or not
    if (cli.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected MQTT server');
      connectionState = MqttConnectionState.connected;
    } else {
      print('Failed to connect to MQTT server');
      connectionState = MqttConnectionState.faulted;
      cli.disconnect();
    }
  }

  void _onConnected() {
    print('Connected to MQTT server!');
  }

  void _onDisconnected() {
    print('Disconnected to MQTT server!');
  }

  void _onSubcribed(String? topic) {
    print('Subcribe topic $topic');
  }

  void _onSubscribeFail(String? topic) {
    print('Failed to subscribe $topic');
  }

  void _onUnsubscribed(String? topic) {
    print('Unsubcribe topic $topic');
  }

  void publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('Publishing message $message to topic ${Config.topicName}');
    cli.publishMessage(Config.topicName, MqttQos.exactlyOnce, builder.payload!);
  }
}
