import 'dart:math';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager_test_app/backgorund.dart' as bgnd;
import 'package:workmanager_test_app/notifications.dart' as notify;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bgnd.setUpWorkManager();
    notify.initialize();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter workmanager test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Geolocator.requestPermission();
              },
              child: Text("request permission"),
            ),
            SizedBox(height: 60),
            RaisedButton(
              onPressed: () {
                notify.sendNotification("just from frontedn");
              },
              child: Text("Just notify"),
            ),
            RaisedButton(
              onPressed: () {
                BackgroundFetch.scheduleTask(
                  TaskConfig(
                    taskId: bgnd.TaskName.SEND_NOTIFICATION,
                    delay: 0,
                  ),
                );
              },
              child: Text('one off'),
            ),
            RaisedButton(
              // onPressed: () {
              //   Workmanager.registerOneOffTask(
              //     Random().nextInt(9999).toString(),
              //     bgnd.TaskName.LOCATION,
              //   );
              // },
              child: Text('one off location'),
            ),
            RaisedButton(
              // onPressed: () {
              //   Workmanager.registerPeriodicTask(
              //     Random().nextInt(9999).toString(),
              //     bgnd.TaskName.PERIODIC_TASK,
              //   );
              // },
              child: Text('perdiodic notify'),
            ),
            RaisedButton(
              // onPressed: () {
              //   Workmanager.registerPeriodicTask(
              //     Random().nextInt(9999).toString(),
              //     bgnd.TaskName.LOCATION,
              //   );
              // },
              child: Text('periodic location'),
            ),
            RaisedButton(
              child: Text('cancel all'),
              onPressed: () {
                BackgroundFetch.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
