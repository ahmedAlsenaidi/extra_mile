// The MapScreen is responsible for displaying the location of a specific 'castle' on a Google Map.
// It requires permission to access the user's location to show the 'My Location' button on the map.
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Data/BranchModel.dart';
import 'package:permission_handler/permission_handler.dart';
//
// // Defines a StatefulWidget as the state of the MapScreen can change based on the location permission status.
// class MapScreen extends StatelessWidget {
//   final Branch branch; // Holds the castle data passed to it upon creation.
//
//   const MapScreen({super.key, required this.branch});
//
//
//   @override
//   Widget build(BuildContext context) {
//     bool _permissionGranted = false; // Tracks the status of location permission.
//     // Asynchronously requests location permission from the user.
//     Future<void> _requestLocationPermission() async {
//       var status = await Permission.locationWhenInUse.status; // Checks the current permission status.
//       if (!status.isGranted) {
//         // If not granted, requests permission.
//         status = await Permission.locationWhenInUse.request();
//       }
//       if (mounted) {
//         // Checks if the widget is still part of the widget tree.
//         setState(() {
//           // Updates the state with the new permission status.
//           _permissionGranted = status.isGranted;
//         });
//       }
//     }
//     _requestLocationPermission(); // Requests location permission when the widget is initialized.
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Branch Location"), // Sets the app bar title.
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           // Centers the map on the castle's location.
//           target: LatLng(branch.branchData!.latitude!, branch.branchData!.longitude!),
//           zoom: 5.0, // Sets the initial zoom level.
//         ),
//         markers: {
//           Marker(
//             // Places a marker on the castle's location.
//             markerId: const MarkerId('buildingMarker'),
//             position: LatLng(0.0,0.0),//branch.branchData!.latitude!, branch.branchData!.longitude!
//             infoWindow: InfoWindow(title: branch.branchData!.name!), // Shows the branch's name.
//           ),
//         },
//         myLocationEnabled: false, // Enables the 'My Location' button.
//         myLocationButtonEnabled: false, // Shows the 'My Location' button if permission is granted.
//
//       ),
//     );
//   }
// }
//
//
//
//
//

// The MapScreen is responsible for displaying the location of a specific 'castle' on a Google Map.
// It requires permission to access the user's location to show the 'My Location' button on the map.
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

// Defines a StatefulWidget as the state of the MapScreen can change based on the location permission status.
class MapScreen extends StatefulWidget {
  final Branch branch; // Holds the castle data passed to it upon creation.

  const MapScreen({super.key, required this.branch});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _permissionGranted = false; // Tracks the status of location permission.

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Requests location permission when the widget is initialized.
  }

  // Asynchronously requests location permission from the user.
  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status; // Checks the current permission status.
    if (!status.isGranted) {
      // If not granted, requests permission.
      status = await Permission.locationWhenInUse.request();
    }
    if (mounted) {
      // Checks if the widget is still part of the widget tree.
      setState(() {
        // Updates the state with the new permission status.
        _permissionGranted = status.isGranted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Location"), // Sets the app bar title.
      ),
      body: _permissionGranted
          ? GoogleMap(
        initialCameraPosition: CameraPosition(
          // Centers the map on the castle's location.
          target: LatLng(widget.branch.branchData!.latitude!, widget.branch.branchData!.longitude!),
          zoom: 5.0, // Sets the initial zoom level.
        ),
        markers: {
          Marker(
            // Places a marker on the castle's location.
            markerId: const MarkerId('BranchMarker'),
            position: LatLng(widget.branch.branchData!.latitude!, widget.branch.branchData!.longitude!),
            infoWindow: InfoWindow(title: widget.branch.branchData!.name!), // Shows the Branch's name.
          ),
        },
        myLocationEnabled: true, // Enables the 'My Location' button.
        myLocationButtonEnabled: true, // Shows the 'My Location' button if permission is granted.
      )
          : const Center(
        child: Text("Location permission is required to show the map."),
        // Displays a message if location permission is not granted.
      ),
    );
  }
}
