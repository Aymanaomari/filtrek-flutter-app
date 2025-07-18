import 'package:filtrek_app/core/constant/map_key.dart';
import 'package:filtrek_app/core/constant/map_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GymMapScreen extends StatefulWidget {
  final double destinationLat;
  final double destinationLng;

  const GymMapScreen(
      {super.key, required this.destinationLat, required this.destinationLng});

  @override
  State<GymMapScreen> createState() => _GymMapScreenState();
}

class _GymMapScreenState extends State<GymMapScreen> {
  List<LatLng> polylineCoordinates = [];

  static const LatLng target = LatLng(33.3667, -7.5867);

  LocationData? currentLocation;
  GoogleMapController? mapController;

  LatLng? source; // This will be set once from current location

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  bool isLoading = true;

  void setLoadingIfReady() {
    if (currentLocation != null && polylineCoordinates.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    // Check if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check location permissions
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get current location
    LocationData locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
      source =
          LatLng(locationData.latitude!, locationData.longitude!); // Set source
      isLoading = false; // Show map as soon as location is ready
    });

    // Get polyline after source is set
    getPolyPoints();

    location.onLocationChanged.listen((newLoc) {
      if (mounted) {
        setState(() {
          currentLocation = newLoc;
        });
        setLoadingIfReady();

        // Update camera position to follow current location
        if (mapController != null &&
            newLoc.latitude != null &&
            newLoc.longitude != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          );
        }
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getPolyPoints() async {
    // Wait for source to be set before getting polyline
    if (source == null) return;

    // Initialize PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    // Get route using legacy Directions API
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(source!.latitude,
            source!.longitude), // Use current location as source
        destination: PointLatLng(
            widget.destinationLat, widget.destinationLng), // Destination
        mode: TravelMode.driving,
      ),
    );

    print("PolylineResult status: " + result.status.toString());
    print("PolylineResult errorMessage: " + (result.errorMessage ?? "none"));
    print("PolylineResult points count: " + result.points.length.toString());
    if (result.points.isNotEmpty) {
      setState(() {
        // Convert to LatLng for Google Maps
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
      setLoadingIfReady();
    }
  }

  // Method to center camera on current location with custom zoom
  void centerOnCurrentLocation({double zoom = 16.0}) {
    if (mapController != null && currentLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: zoom,
          ),
        ),
      );
    }
  }

  // Method to fit all markers (current location, source, destination) in view
  void fitAllMarkers() {
    if (mapController != null && currentLocation != null && source != null) {
      List<LatLng> points = [
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        source!,
        LatLng(widget.destinationLat, widget.destinationLng),
      ];

      double minLat =
          points.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
      double maxLat =
          points.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
      double minLng =
          points.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
      double maxLng =
          points.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          100.0, // padding
        ),
      );
    }
  }

  void setCustomMakerIcon() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/source_marker.png");
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/destination_marker.png");
    currentIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/current_marker.png");
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Find Your way"),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Find Your way"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        style: MapStyles.styleOne,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
          zoom: 14.0,
        ),
        markers: {
          if (currentLocation != null)
            Marker(
              markerId: MarkerId("currentLocation"),
              position: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
              infoWindow: InfoWindow(title: "Current Location"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          if (source != null)
            Marker(
              markerId: MarkerId("source"),
              position: source!,
              infoWindow: InfoWindow(title: "Source"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
            ),
          Marker(
            markerId: MarkerId("destination"),
            position: LatLng(widget.destinationLat, widget.destinationLng),
            infoWindow: InfoWindow(title: "Destination"),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: ColorScheme.of(context).primary,
            width: 6,
          ),
        },
      ),
    );
  }
}
