import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ALERT"),
          content: Text("CONTENT: $payload"),
        ));
  }

  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime =
    new DateTime.now().add(Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.schedule(0, 'Title ', 'Body', scheduledNotificationDateTime, platform);
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Demo"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: showNotification,
        child: new Icon(Icons.notifications),
      ),
    );
  }
}