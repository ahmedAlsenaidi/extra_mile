import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extra_mile/Data/BranchModel.dart';
import 'package:extra_mile/ReusableCode/AppStyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import 'map.dart';
import '../ReusableCode/Helper.dart';
import 'package:flutter/material.dart';
import '../Data/DatabaseHelper.dart';
import '../ReusableCode/BranchDecoration.dart';

class Home extends StatefulWidget {
  final Function(Branch, bool) onUpdateBranch;
  final currentUser = FirebaseAuth.instance;
  Home({Key? key,  required this.onUpdateBranch}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Branch> branchList = [];
  String name = "";
  @override
  void initState() {
    super.initState();
    DatabaseHelper.readFirebaseRealtimeDBMain((branchList) {
      setState(() {
        this.branchList = branchList;
      });
    });
    getUserInfo();
  }

  void _handleDeleteBuilding(String key) async {
    try {
      await DatabaseHelper.deleteBranch(key);
      setState(() {
        branchList.removeWhere((branch) => branch.key == key);
      });
      //notification
      await Helper.showNotification(
          localNotificationsPlugin: flutterLocalNotificationsPlugin,
          title: 'Success',
          body: 'Building Deleted successfully!',
          id: 1);
      //
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "building deleted successfully!",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      //notification
      await Helper.showNotification(
          localNotificationsPlugin: flutterLocalNotificationsPlugin,
          title: 'Error',
          body: 'Errot deleting a building : ${e.toString()}',
          id: 2);
      //
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error deleting a building:${e.toString()}",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleShowMap(Branch branch) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MapScreen(branch: branch)));
  }

  Future<void> _handleUpdateBuildingRating(Branch branch, double newRating) async {
    String key = branch.key!;
    try {
      //Find the Building with given key
      final branchIndex = branchList.indexWhere((branch) => branch.key == key);
      if (branchIndex == -1) {
        throw Exception("not found");
      }
      //check if not null
      BranchData? nullableBranchData = branchList[branchIndex].branchData;
      if (nullableBranchData == null) {
        throw Exception("dat not found");
      }
      //update rating
      BranchData updateBranchData = nullableBranchData;
      updateBranchData.starRating = newRating;
      //update in the database
      await DatabaseHelper.updatebranchesData(key, updateBranchData, context);
      //update local branch list
      setState(() {
        branchList[branchIndex].branchData = updateBranchData;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Updated successfully!",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error Updating rating : ${e.toString()}",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  void getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userInfo =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        name = userInfo.get('name') ?? ''; // Replace 'username' with the field in Firestore where the username is stored
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (branchList.isEmpty) {
      print("branchList is empty!");
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(color: AppStyles.Black1C, fontSize: 15),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
                name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppStyles.Black1C,
                  fontSize: 20),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      // appBar: AppBar(
      //   backgroundColor: AppStyles.Black1C,
      //   title: Center(child: Text("Extra Mile",style: AppStyles.Gray,)),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  "Branches",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppStyles.Black1C,
                      fontSize: 45),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (int i = 0; i < branchList.length; i++)
                        BranchDecoration(
                          branch: branchList[i],
                          onDelete: _handleDeleteBuilding,
                          onShowMap: _handleShowMap,
                          onUpdateRating: _handleUpdateBuildingRating,
                          onUpdateBranch: (Branch, bool) {},
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}
