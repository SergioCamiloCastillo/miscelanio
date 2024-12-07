import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });
  get cameraGranted => camera == PermissionStatus.granted;
  get photoLibraryGranted => photoLibrary == PermissionStatus.granted;
  get sensorsGranted => sensors == PermissionStatus.granted;
  get locationGranted => location == PermissionStatus.granted;
  get locationAlwaysGranted => locationAlways == PermissionStatus.granted;
  get locationWhenInUseGranted => locationWhenInUse == PermissionStatus.granted;
  
  PermissionsState copyWith(
          {PermissionStatus? camera,
          PermissionStatus? photoLibrary,
          PermissionStatus? sensors,
          PermissionStatus? location,
          PermissionStatus? locationAlways,
          PermissionStatus? locationWhenInUse}) =>
      PermissionsState(
        camera: camera ?? this.camera,
        photoLibrary: photoLibrary ?? this.photoLibrary,
        sensors: sensors ?? this.sensors,
        location: location ?? this.location,
        locationAlways: locationAlways ?? this.locationAlways,
        locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
      );
}
