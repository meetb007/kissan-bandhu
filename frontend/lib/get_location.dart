import 'package:geolocator/geolocator.dart';

Future<List<String>> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  String latitude = position.latitude.toString();
  String longitude = position.longitude.toString();
  return [latitude, longitude];
}
