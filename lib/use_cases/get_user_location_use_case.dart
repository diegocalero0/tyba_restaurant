import 'package:geolocator/geolocator.dart';
import 'package:tyba_great_app/base/service_locator.dart';

class GetUserLocationUseCase {


  Future<Position?> invoke() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw('Servicios de ubicación desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw('Servicios de ubicación denegados.');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      
      throw("Permisos de ubicación permanentemente denegados, por favor actívelos en la configuración del dispositivo.");
    } 

    try {
      return (await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 5), desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true));
    } catch(e) {
      return await Geolocator.getLastKnownPosition();
    }

    
  }
}