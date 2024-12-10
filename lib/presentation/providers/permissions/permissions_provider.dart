import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    StateNotifierProvider<PermissionNotifier, PermissionsState>((ref) {
  return PermissionNotifier();
});

class PermissionNotifier extends StateNotifier<PermissionsState> {
  PermissionNotifier() : super(PermissionsState()) {
    checkPermissions();
  }
  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);
    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      //todo do something
    }
  }
  //todo check permissions
}

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
