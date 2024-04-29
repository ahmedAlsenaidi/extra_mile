import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Data/BranchModel.dart';
import '../ReuseAbleWidgets/ImageDecoration.dart';
import '../data/DatabaseHelper.dart';
import '../main.dart';
import '../reusableCode/AppStyles.dart';
import 'BranchesCreatUpdate.dart';
import 'HomePage.dart';

class detail extends StatefulWidget {
  final Branch branch;

  detail({super.key, required this.branch});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  double _runningCost = 0;

  // Define car services and their prices
  List<CarService> _carServices = [
    CarService(name: 'Oil Change', price: 12),
    CarService(name: 'Tire Rotation', price: 20),
    CarService(name: 'Brake Service', price: 5),
    CarService(name: 'Car Wash', price: 1.5),
  ];

  // Initialize a map to store selected services and their quantities
  Map<CarService, int> _selectedServices = {};

  @override
  Widget build(BuildContext context) {
    _runningCost = _calculateTotalCost();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branch.branchData?.name ?? 'Branch Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Branch Location: ${widget.branch.branchData?.name ?? 'N/A'} ",
                style: AppStyles.Black1.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                )),
            const SizedBox(height: 10),
            Text(
                'Phone Number: ${widget.branch.branchData?.phoneNumber?.toString() ?? 'N/A'}',
                style: AppStyles.Black1.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                )),
            const SizedBox(height: 50),
            // Displaying the local image
            const Box(imgPath: "extra-mile-logo.png"),
            const SizedBox(height: 50),

            // Display car services with checkboxes and sliders
            Text(
              'Car Services:',
              style: AppStyles.Black1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: _carServices.map((service) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _selectedServices.containsKey(service),
                          onChanged: (value) {
                            setState(() {
                              if (value != null && value) {
                                _selectedServices[service] = 1;
                              } else {
                                _selectedServices.remove(service);
                              }
                              _runningCost =
                                  _calculateTotalCost(); // Update total cost
                            });
                          },
                          checkColor: Colors.white, // Color of the check icon
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppStyles
                                  .TealC; // Color when checkbox is checked
                            }
                            ; // Color when checkbox is not checked
                          }),
                        ),
                        Text(service.name,
                            style: AppStyles.Black1.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            )),
                        Spacer(),
                        if (service.name == 'Brake Service')
                          Slider(
                            value: _selectedServices.containsKey(service)
                                ? _selectedServices[service]!.toDouble()
                                : 0,
                            min: 0,
                            max: 4,
                            divisions: 4,
                            onChanged: (value) {
                              setState(() {
                                _selectedServices[service] = value.toInt();
                                _runningCost =
                                    _calculateTotalCost(); // Update total cost
                              });
                            },
                            activeColor:
                                AppStyles.TealC, // Set the color of the slider
                          ),
                        if (service.name != 'Brake Service')
                          Text('${service.price} OMR '),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
            // Display total cost
            Text('Total Cost: OMR ${_runningCost.toStringAsFixed(2)}',
                style: AppStyles.Black1.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                )),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: updateBranch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.TealC,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Use min size for the Row
                children: [
                  Icon(
                    Icons.update,
                    color: AppStyles.Black1C,
                  ), // Delete icon
                  SizedBox(width: 8), // Space between icon and text
                  Text(
                    'Update',
                    style: AppStyles.Black1.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ), // Button text
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _deleteBranch(),
              style: ElevatedButton.styleFrom(backgroundColor: AppStyles.TealC),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Use min size for the Row
                children: [
                  Icon(
                    Icons.delete,
                    color: AppStyles.Black1C,
                  ), // Delete icon
                  SizedBox(width: 8), // Space between icon and text
                  Text(
                    'Delete Branch',
                    style: AppStyles.Black1.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ), // Button text
                ],
              ),
            ),

            // Existing UI code...
          ],
        ),
      ),
    );
  }

  _deleteBranch() {
    if (widget.branch.key != null && widget.branch.branchData?.name != null) {
      String branchName = widget.branch.branchData!.name!;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Confirm Deletion',style: AppStyles.Teal.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal),),
            content: Text(
              'Are you sure you want to delete the Branch $branchName?',
              style: AppStyles.Black1.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: AppStyles.Teal.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                onPressed: () async {
                  // Perform deletion
                  DatabaseHelper.deleteBranch(widget.branch.key!);

                  // Show notification
                  await _showDeletionNotification(branchName);

                  Navigator.of(context).pop(); // Close the dialog

                  // Redirect to home page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(onUpdateBranch: (branch, isUpdate) {})),
                    (Route<dynamic> route) => false,
                  );
                },
                child:  Text('Delete',style: AppStyles.Teal.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal),),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _showDeletionNotification(String branchName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('deletion_channel', 'Deletion Channel',
            channelDescription: 'Channel for deletion notifications',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'deletion_ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Branch Deletion',
      '$branchName branch has been successfully deleted',
      platformChannelSpecifics,
      payload: 'branch_deletion',
    );
  }

  void updateBranch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUpdateBranchDataInToFirebaseScreen(
          isUpdate: true,
          branch: widget.branch,
          onUpdateBranch: (building, bool isUpdate) {},
        ),
      ),
    );
  }

  double _calculateTotalCost() {
    double totalCost = 0;
    _selectedServices.forEach((service, quantity) {
      totalCost += service.price * quantity;
    });
    return totalCost;
  }
}

// Model class for car service
class CarService {
  final String name;
  final double price;

  CarService({required this.name, required this.price});
}
