import 'dart:async';
import 'dart:ui' as ui;
import 'package:filtrek_app/core/constant/map_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTabView extends StatefulWidget {
  final dynamic gymData; // Replace dynamic with your actual GymData type

  const MapTabView({
    Key? key,
    required this.gymData,
  }) : super(key: key);

  @override
  State<MapTabView> createState() => _MapTabViewState();
}

class _MapTabViewState extends State<MapTabView> {
  static const CameraPosition _defaultPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  String? _mapStyle;
  BitmapDescriptor? _customMarker;

  CameraPosition get _cameraPosition {
    final data = widget.gymData;
    if (data?.address?.latitude != null && data?.address?.longitude != null) {
      return CameraPosition(
        target: LatLng(data.address.latitude, data.address.longitude),
        zoom: 15.0,
      );
    }
    return _defaultPosition;
  }

  Set<Marker> get _markers {
    final data = widget.gymData;
    if (data?.address?.latitude != null && data?.address?.longitude != null) {
      return {
        Marker(
          markerId: const MarkerId('gym_location'),
          position: LatLng(data.address.latitude, data.address.longitude),
          infoWindow: InfoWindow(
            title: data.name,
            snippet: data.completeAddress,
          ),
        ),
      };
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    // Replace markers with custom marker if available
    final Set<Marker> themedMarkers = _markers.map((m) {
      if (_customMarker != null) {
        return m.copyWith(iconParam: _customMarker);
      }
      return m;
    }).toSet();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _cameraPosition,
          style: MapStyles.styleOne,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          compassEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomGesturesEnabled: true,
          markers: themedMarkers,
        ),
      ),
    );
  }
}
