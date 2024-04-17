// The MapScreen is responsible for displaying the location of a specific 'castle' on a Google Map.
// It requires permission to access the user's location to show the 'My Location' button on the map.
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Data/BranchModel.dart';
// import 'package:permission_handler/permission_handler.dart';

// Defines a StatefulWidget as the state of the MapScreen can change based on the location permission status.
class MapScreen extends StatelessWidget {
  final Branch branch; // Holds the castle data passed to it upon creation.

  const MapScreen({super.key, required this.branch});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Location"), // Sets the app bar title.
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          // Centers the map on the castle's location.
          target: LatLng(branch.branchData!.latitude!, branch.branchData!.longitude!),
          zoom: 5.0, // Sets the initial zoom level.
        ),
        markers: {
          Marker(
            // Places a marker on the castle's location.
            markerId: const MarkerId('buildingMarker'),
            position: LatLng(branch.branchData!.latitude!, branch.branchData!.longitude!),
            infoWindow: InfoWindow(title: branch.branchData!.name!), // Shows the branch's name.
          ),
        },
        myLocationEnabled: true, // Enables the 'My Location' button.
        myLocationButtonEnabled: true, // Shows the 'My Location' button if permission is granted.

      ),
    );
  }
}





