import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class MapScreen extends StatefulWidget {
  MapScreen({super.key, this.lat, this.lon});

  final lat;
  final lon;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();

    storyPosition = LatLng(widget.lat, widget.lon);

    defineMarker(storyPosition);
  }

  geo.Placemark? placemark;
  late LatLng storyPosition;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: storyPosition, zoom: 18),
              myLocationEnabled: true,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: markers,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                child: Icon(Icons.my_location),
                onPressed: () {
                  onMyLocationButtonPressed();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void defineMarker(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];

    final street = place.street;
    final address =
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

  void onMyLocationButtonPressed() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location is Not Available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }
}
