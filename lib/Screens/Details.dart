import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Data/BranchModel.dart';
import '../ReuseAbleWidgets/ImageDecoration.dart';
import '../data/DatabaseHelper.dart';
import '../reusableCode/AppStyles.dart';
import 'BranchesCreatUpdate.dart';

class detail extends StatefulWidget {
  final Branch branch;

   detail({super.key, required this.branch});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  int _ticketQuantity = 1;
  double _ticketPrice = 0, _runningCost = 0;

  @override
  Widget build(BuildContext context) {
    // _ticketPrice = widget.branch.branchData?.ticketPrice ?? 0.0;
    // _runningCost = _ticketQuantity * _ticketPrice;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branch.branchData?.name ?? 'Branch Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Displaying the local image
            const Box(imgPath:"extra-mile-logo.png" ),//: const SizedBox(height: 200, child: Placeholder()),//widget.branch.branchData?.image != null ?
            // widget.branch.branchData!.image!
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Name: ",
                  style: AppStyles.headlineStyle1,
                ),
                Text(
                  widget.branch.branchData?.name ?? 'N/A',
                  style: AppStyles.headlineStyle2,
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(
              'Place: ${widget.branch.branchData?.phoneNumber ?? 'N/A'}',
              style: AppStyles.headlineStyle2,
            ),
            // Text(
            //   'Established: ${widget.building.buildingData?. ?? 'N/A'}',
            //   style: const TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.brown),
            // ),
            Text('Phone Number: ${widget.branch.branchData?.phoneNumber?.toString() ?? 'N/A'}',
              style: AppStyles.Black2,
            ),
            const SizedBox(height: 20),
            Text(
              'Select Ticket Quantity:',

            ),
            Slider(
              value: _ticketQuantity.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _ticketQuantity.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _ticketQuantity = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Running Cost: OMR ${_runningCost.toStringAsFixed(2)}',),
            const SizedBox(height: 20),

            // Add RatingBar here
            RatingBar.builder(
              initialRating: widget.branch.branchData?.starRating ?? 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                // Update the rating in the database
                widget.branch.branchData?.starRating = rating;
                DatabaseHelper.updatebranchesData(
                    widget.branch.key!, widget.branch.branchData!, context);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: updateBranch, child: const Text("Update")),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _deleteCastle(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),/////////////////////
              child: const Row(
                mainAxisSize: MainAxisSize.min, // Use min size for the Row
                children: [
                  Icon(Icons.delete), // Delete icon
                  SizedBox(width: 8), // Space between icon and text
                  Text('Delete Branch'), // Button text
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  _deleteCastle() {
    if (widget.branch.key != null && widget.branch.branchData?.name != null) {
      String branchName = widget.branch.branchData!.name!;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content: Text('Are you sure you want to delete the branch $branchName?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                onPressed: (){
                  DatabaseHelper.deleteBranch(widget.branch.key!);
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$branchName branch deleted')),
                  );
                  // Navigate back to the homepage
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    }
  }

  // _deleteCastle() {
  //   // FirebaseDatabase.instance.ref("castles").child(widget.castle.key!).remove();
  //
  //   if (widget.branch.key != null && widget.branch.branchData?.name != null) {
  //     String castleName = widget.branch.branchData!.name!;
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Confirm Deletion'),
  //           content:
  //           Text('Are you sure you want to delete the castle $castleName?'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('Cancel'),
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //             ),
  //             TextButton(
  //               onPressed: (){
  //                 DatabaseHelper.deleteBranch(widget.branch.key!);
  //                 Navigator.of(context).pop(); // Close the dialog
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text('$castleName branch deleted')),
  //
  //                 );
  //
  //                 Navigator.pushAndRemoveUntil(
  //                   context,
  //                   MaterialPageRoute(builder: (context) =>  HomePage(onUpdateBranch: (Branch, bool) {})),
  //                       (Route<dynamic> route) => false,
  //                 );
  //               },
  //               child: const Text('Delete'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  void updateBranch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddUpdateBranchDataInToFirebaseScreen(
              isUpdate: true, branch: widget.branch, onUpdateBranch: (building, bool isUpdate) {  },),
      ),
    );
  }
}
