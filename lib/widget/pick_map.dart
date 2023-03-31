import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../providers/stories_provider.dart';

class AddMapWidget extends StatefulWidget {
  const AddMapWidget({super.key});

  @override
  State<AddMapWidget> createState() => _AddMapWidgetState();
}

class _AddMapWidgetState extends State<AddMapWidget> {
  @override
  void initState() {
    super.initState();
    getDeviceLocation();
  }

  LatLng devicePosition = const LatLng(12, 12);
  geo.Placemark? placemark;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: devicePosition, zoom: 18),
        myLocationEnabled: true,
        markers: markers,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        onLongPress: (LatLng latLng) {
          defineMarker(latLng);
          mapController.animateCamera(CameraUpdate.newLatLng(latLng));
          final provider = context.read<StoriesProvider>();
          provider.setPickedLocation(latLng);
        },
      ),
    );
  }

  void defineMarker(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    String street = place.street!;
    String address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(title: street, snippet: address),
    );
    setState(() {
      placemark = place;
      markers.clear();
      markers.add(marker);
    });
  }

  void getDeviceLocation() async {
    final Location location = Location();
    late bool isServiceEnabled;
    late PermissionStatus permissionStatus;
    late LocationData locationData;

    isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        print("You don't have permission");
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        print("Permission denied");
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }
}
