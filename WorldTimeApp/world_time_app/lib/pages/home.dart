import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Timer timer;
  Map data = {};
  late String bgImage;
  late Color? bgColor;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => timeTick());
    super.initState();
  }

  void timeTick() {
    DateTime now = DateTime.now().toUtc();
    now = now.add(Duration(hours: data['offsetDuration']));

    setState(() {
      data['isDayTime'] = now.hour > 6 && now.hour < 19 ? true : false;
      data['time'] = DateFormat.jms().format(now);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    bgColor = data['isDayTime'] ? Colors.teal[300] : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                        'offsetDuration': result['offsetDuration'],
                      };
                    });
                  }, 
                  icon: Icon(
                    Icons.edit_location,
                    size: 30.0,
                    color: Colors.red[900],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0
                    ),
                  ),
                ),
                const SizedBox(height: 80.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 32.0,
                        letterSpacing: 4.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100.0),
                Stack(
                  children: <Widget>[
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 58.0,
                        fontWeight: FontWeight.w800,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5.0
                          ..color = Colors.white70
                      ),
                    ),
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 58.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[850],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}