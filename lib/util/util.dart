import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:images_picker/images_picker.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/widgets/dropdown_alert/alert_controller.dart';
import 'package:passenger/util/widgets/dropdown_alert/data_alert.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:url_launcher/url_launcher.dart';

EventTransformer<E> debounce<E>(Duration duration) {
  return (Stream<E> events, Stream<E> Function(E) mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

List<LatLng> decodeEncodedPolyline(String encoded) {
  List<LatLng> poly = <LatLng>[];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;
    LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
    poly.add(p);
  }
  return poly;
}

String getTravelTransportation(TravelTransportation travelMode) {
  String transportationRoute = 'driving';
  switch (travelMode) {
    case TravelTransportation.bicycle:
      transportationRoute = 'bicycling';
      break;
    case TravelTransportation.bus:
      transportationRoute = 'transit';
      break;
    case TravelTransportation.driving:
      transportationRoute = 'driving';
      break;
    case TravelTransportation.walk:
      transportationRoute = 'walking';
      break;
    default:
      break;
  }
  return transportationRoute;
}

void urlSchemaUtil(String value, UrlSchemaType type) async {
  Uri? uri;
  if (type == UrlSchemaType.phone) {
    uri = Uri.parse('tel:$value');
  } else if (type == UrlSchemaType.sms) {
    uri = Uri.parse('sms:$value');
  } else if (type == UrlSchemaType.link) {
    uri = Uri.parse(value);
  }

  if (uri != null) {
    launchUrl(uri);
  }
}

extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final E temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

void alertDropdownNotify(String title, String? message, TypeAlert type) {
  AlertController.show(title, message ?? '', type);
}

Future<bool> requestPermission({
  required Permission permission,
  required BuildContext context,
}) async {
  final Completer<bool> wait = Completer<bool>();
  permission.request().then((PermissionStatus status) async {
    if (status.isGranted) {
      wait.complete(true);
    } else if (status.isDenied) {
      wait.complete(false);
    } else {
      await showCameraSettingDialog(context, wait);
    }
    return wait.future;
  });
  return false;
}

Future<List<File>?> openCamera(BuildContext context) async {
  if (await requestPermission(
    permission: Permission.camera,
    context: context,
  )) {
    List<Media>? pickedFiles = await ImagesPicker.openCamera(
      quality: 0.5,
      maxSize: 51200,
    );
    if (pickedFiles != null) {
      return pickedFiles.map((Media e) => File(e.path)).toList();
    }
  }
  return null;
}

Future<void> showCameraSettingDialog(
  BuildContext context,
  Completer<bool> wait,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(S(context).require_camera_permission),
      content: Text(S(context).require_camera_permission_explained),
      actions: <Widget>[
        TextButton(
          child: Text(
            S(context).deny,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            wait.complete(false);
          },
        ),
        TextButton(
          child: Text(
            S(context).setting,
          ),
          onPressed: () => openAppSettings(),
        ),
      ],
    ),
  );
}
