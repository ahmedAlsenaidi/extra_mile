import 'package:flutter/material.dart';
import '../data/DatabaseHelper.dart';
import '../Data/BranchModel.dart';
import '../ReusableCode/AppStyles.dart';
import 'Home.dart';
import 'HomePage.dart';

class AddUpdateBranchDataInToFirebaseScreen extends StatelessWidget {
  final Branch? branch;
  final bool isUpdate;
  final void Function(Branch branch, bool isUpdate) onUpdateBranch;

  AddUpdateBranchDataInToFirebaseScreen({
    super.key,
    this.branch,
    this.isUpdate = false,
    required this.onUpdateBranch,
  });

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    if (isUpdate && branch != null) {
      nameController.text = branch!.branchData!.name ?? "";
      phoneNumberController.text = branch!.branchData!.phoneNumber.toString();
      latitudeController.text = branch!.branchData!.latitude?.toString() ?? "";
      longitudeController.text =
          branch!.branchData!.longitude?.toString() ?? "";
    }

    return Builder(
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Create/Update',
                  style: AppStyles.Gray,
                ),
              ),
              backgroundColor: AppStyles.Black1C,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: AppStyles.Black2C),
                        // Change label color
                        hintStyle: TextStyle(color: AppStyles.Black2C),
                        // Change hint (placeholder) color
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppStyles.Black2C),
                        ),
                        // Change border color
                      ),
                      cursorColor: AppStyles.Black2C,
                    ),
                    TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: AppStyles.Black2C),
                        hintStyle: TextStyle(color: AppStyles.Black2C),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppStyles.Black2C),
                        ),
                      ),
                      cursorColor: AppStyles.Black2C, // Change cursor color
                    ),
                    TextField(
                      controller: latitudeController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Latitude',
                        labelStyle: TextStyle(color: AppStyles.Black2C),
                        hintStyle: TextStyle(color: AppStyles.Black2C),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppStyles.Black2C),
                        ),
                      ),
                      cursorColor: AppStyles.Black2C,
                    ),
                    TextField(
                      controller: longitudeController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Longitude',
                        labelStyle: TextStyle(color: AppStyles.Black2C),
                        hintStyle: TextStyle(color: AppStyles.Black2C),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppStyles.Black2C),
                        ),
                      ),
                      cursorColor: AppStyles.Black2C,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyles.Black2C),
                      child: Text(
                        'Save',
                        style: AppStyles.Gray.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      onPressed: () {
                        int? phoneNumber;
                        double? latitude;
                        double? longitude;

                        try {
                          phoneNumber = int.parse(phoneNumberController.text);
                          latitude = double.parse(latitudeController.text);
                          longitude = double.parse(longitudeController.text);
                        } catch (e) {
                          _scaffoldMessengerKey.currentState?.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Invalid input. Please enter valid numbers.',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (phoneNumber == null ||
                            latitude == null ||
                            longitude == null) {
                          _scaffoldMessengerKey.currentState?.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Invalid input. Please enter valid Value.',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        BranchData branchData = BranchData(
                          nameController.text,
                          phoneNumber,
                          latitude,
                          longitude,
                          0.0,
                        );

                        if (isUpdate && branch != null) {
                          DatabaseHelper.updatebranchesData(
                                  branch!.key!, branchData, context)
                              .then((_) {
                            _scaffoldMessengerKey.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text(
                                "Data updated successfully",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                            ));
                            Navigator.pop(
                                context); // Navigate back to the home screen
                          }).catchError((error) {
                            _scaffoldMessengerKey.currentState?.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to update data: $error',
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        } else {
                          DatabaseHelper.saveDataItem(branchData).then((_) {
                            // Navigate back to the Home page
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      onUpdateBranch: (Branch, bool) {})),
                              (Route<dynamic> route) => false,
                            );
                            _scaffoldMessengerKey.currentState?.showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Data saved successfully',
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Navigate back to the Home page
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      onUpdateBranch: (Branch, bool) {})),
                              (Route<dynamic> route) => false,
                            );
                          }).catchError((error) {
                            _scaffoldMessengerKey.currentState?.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to save data: $error',
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
