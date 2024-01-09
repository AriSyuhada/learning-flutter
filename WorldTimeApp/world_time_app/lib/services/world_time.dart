
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  late String time;
  late int offsetDuration;
  String flag;
  String urlLocation;
  late bool isDayTime;

  WorldTime(this.location, this.flag, this.urlLocation);

  Future<void> getTime() async {
    try {

      var response = await http.get(
        Uri.parse('http://worldtimeapi.org/api/timezone/$urlLocation')
      );
      Map data = jsonDecode(response.body);
      
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      offsetDuration = int.parse(offset.substring(1,3));
      
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: offsetDuration));
      
      // time = now.toString();
      isDayTime =   now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jms().format(now);

    } on Exception catch (e) {
      print('Caught Error: $e');
      time = 'Caught error while getting Time and Location';
    }
  }
}