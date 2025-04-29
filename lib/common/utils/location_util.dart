import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/common/dialogs/dialog_provider.dart';

class LocationUtil {
  LocationUtil._();

  static final LocationUtil instance = LocationUtil._();

  Future<bool> requestPermission({BuildContext? context, bool openSettings = false}) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      if (openSettings) {
        if (context?.mounted == true) {
          // ignore: use_build_context_synchronously
          _showOpenAppSettingsDialog(context!);
        }
      }
      return false;
    } else if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  _showOpenAppSettingsDialog(BuildContext context) {
    DialogProvider.instance.showConfirmDialog(
      context,
      title: 'Weather App',
      message: 'Please allow location access to use this function!',
      negativeTitle: 'Cancel',
      positiveTitle: 'OK',
      positiveCallback: () {
        AppSettings.openAppSettings();
      },
    );
  }

  _showOpenSystemSettingsDialog(BuildContext context) {
    DialogProvider.instance.showConfirmDialog(
      context,
      title: 'Weather App',
      message: 'Please turn on location to use this function!',
      negativeTitle: 'Cancel',
      positiveTitle: 'OK',
      positiveCallback: () {
        AppSettings.openAppSettings();
      },
    );
  }

  Future<Position?> getCurrentLocation({bool permissionAllowed = false}) async {
    if (!permissionAllowed) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        bool permissionAllowed = await requestPermission();
        if (permissionAllowed) {
          return getCurrentLocation(permissionAllowed: true);
        }
        return null;
      }
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
    }
    Position? locationData = await Geolocator.getLastKnownPosition();
    if (locationData == null) {
      try {
        locationData = await Geolocator.getCurrentPosition();
      } catch (e) {
        debugPrint('$e');
      }
    }
    return locationData;
  }

  Future<Position?> getCurrentLocationRequire({bool permissionAllowed = false, required BuildContext context}) async {
    if (!permissionAllowed) {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
        return null;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        bool permissionAllowed = await requestPermission();
        if (permissionAllowed) {
          return getCurrentLocation(permissionAllowed: true);
        }
        if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
        return null;
      }
      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
        return null;
      }
    }
    Position? locationData = await Geolocator.getLastKnownPosition();
    if (locationData == null) {
      try {
        locationData = await Geolocator.getCurrentPosition();
      } catch (e) {
        if (context.mounted) {
          _showOpenSystemSettingsDialog(context);
        }
      }
    }
    return locationData;
  }
}
