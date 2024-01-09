import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime('Athens', 'GR.svg', 'Europe/Berlin'),
    WorldTime('Cairo', 'EG.svg', 'Africa/Cairo'),
    WorldTime('Chicago', 'US.svg', 'America/Chicago'),
    WorldTime('Jakarta', 'ID.svg', 'Asia/Jakarta'),
    WorldTime('Jayapura', 'ID.svg', 'Asia/Jayapura'),
    WorldTime('London', 'GB.svg', 'Europe/London'),
    WorldTime('Makassar', 'ID.svg', 'Asia/Makassar'),
    WorldTime('Mecca', 'SA.svg', 'Etc/GMT+3'),
    WorldTime('Nairobi', 'KE.svg', 'Africa/Nairobi'),
    WorldTime('New York', 'US.svg', 'America/New_York'),
    WorldTime('Seoul', 'KR.svg', 'Asia/Seoul'),
    WorldTime('Tokyo', 'JP.svg', 'Asia/Tokyo'),
  ];

  void updateTime(index) async {
    WorldTime worldTime = locations[index];
    await worldTime.getTime();

    // ignore: use_build_context_synchronously
    Navigator.pop(context, {
      'location': worldTime.location,
      'time': worldTime.time,
      'flag': worldTime.flag,
      'isDayTime': worldTime.isDayTime,
      'offsetDuration': worldTime.offsetDuration,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Choose a location',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: SvgPicture.asset(
                    'assets/${locations[index].flag}',
                    width: 40.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}