/*
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Position?> fetchLocation() async {
  PermissionStatus permission = await Permission.location.status;
  if (permission.isDenied) {
    permission = await Permission.location.request();
  }
  if (permission.isGranted) {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      return position;
    } catch (e) {
      print("Error fetching location: $e");
      return null;
    }
  } else {
    print("Location permission denied");
    return null;
  }
}
*/
