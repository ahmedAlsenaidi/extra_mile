import 'package:flutter/material.dart';
import '../data/DatabaseHelper.dart';
import '../Data/BranchModel.dart';
import 'HomePage.dart';


class AddUpdateBranchDataInToFirebaseScreen extends StatelessWidget {
  final Branch? branch;
  final bool isUpdate;
  final void Function(Branch branch, bool isUpdate) onUpdateBranch;

  AddUpdateBranchDataInToFirebaseScreen(
      {super.key,
        this.branch,
        this.isUpdate = false,
        required this.onUpdateBranch});

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
      phoneNumberController.text =
          branch!.branchData!.phoneNumber?.toString() ?? "";
      latitudeController.text =
          branch!.branchData!.latitude?.toString() ?? "";
      longitudeController.text =
          branch!.branchData!.longitude?.toString() ?? "";
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Create/Update Demo',
      home: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Update and creat'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextField(
                    controller: latitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Latitude'),
                  ),
                  TextField(
                    controller: longitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Longitude'),
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      BranchData branchData = BranchData(
                        nameController.text,
                        int.parse(phoneNumberController.text),
                        double.parse(longitudeController.text),
                        double.parse(latitudeController.text),
                        0.0,

                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  HomePage(onUpdateBranch: (Branch, bool) {})),
                            (Route<dynamic> route) => false,
                      );

                      if (isUpdate && branch != null) {
                        DatabaseHelper.updatebranchesData(
                            branch!.key!, branchData,context)
                            .then((_) => {
                          _scaffoldMessengerKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                              "Data updated successfully",
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ))
                        })
                            .catchError((error) {
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
                          _scaffoldMessengerKey.currentState?.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Data saved successfully',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                            ),
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
      ),
    );
  }
}
