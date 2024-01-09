import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime worldTime = WorldTime('Jakarta', 'ID.svg', 'Asia/Jakarta');
    await worldTime.getTime();
    // ignore: use_build_context_synchronously
    await Future.delayed( const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': worldTime.location,
      'time': worldTime.time,
      'flag': worldTime.flag,
      'isDayTime': worldTime.isDayTime,
      'offsetDuration': worldTime.offsetDuration,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: const Center(
        child: SpinKitPouringHourGlassRefined(
          color: Color.fromARGB(255, 38, 166, 154),
          duration: Duration(seconds: 2),
          size: 100.0,
        ),
      ),
    );
  }
}