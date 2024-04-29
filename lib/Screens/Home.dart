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

  Home({Key? key, required this.onUpdateBranch}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Branch> branchList = [];
  String name = "";
  double generalRating = 0.0; // Add this line

  @override
  void initState() {
    getUserInfo();
    fetchBranchList();
    getUserRating();
    fetchGeneralRating();
    super.initState();
  }

  void fetchBranchList() {
    DatabaseHelper.readFirebaseRealtimeDBMain((branchList) {
      setState(() {
        this.branchList = branchList;
      });
    });
  }

  void getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userInfo =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        name = userInfo.get('name') ?? '';
      });
    }
  }

  Future<double?> getUserRating() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        dynamic ratingData = userDoc.data()?['rating'];
        if (ratingData is int) {
          // Handle integer rating values
          return ratingData.toDouble();
        } else if (ratingData is double) {
          // Handle double rating values
          return ratingData;
        }
      }
    } catch (e) {
      print('Error fetching user rating: $e');
    }
    return null;
  }

  Future<void> fetchGeneralRating() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      // Extract ratings from each user document
      List<double> ratings = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['rating'])
          .whereType<num>() // Filter out non-numeric values
          .map((rating) => rating.toDouble())
          .toList();

      // Calculate the general rating
      double calculatedRating = calculateGeneralRating(ratings);

      // Update the general rating in the state
      setState(() {
        generalRating = calculatedRating;
      });
    } catch (e) {
      print('Error fetching general rating: $e');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Increase the height here
        child: AppBar(
          backgroundColor: AppStyles.Black1C,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Welcome",
                style: TextStyle(color: AppStyles.GrayC, fontSize: 15),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppStyles.GrayC,
                    fontSize: 20),
              ),
              SizedBox(
                height: 4.0,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon:  Icon(Icons.logout),
              color: AppStyles.GrayC,
            )
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                SizedBox(height: 20), // Add some space
                Text(
                  'General Rating: $generalRating',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleDeleteBuilding(String key) async {
    try {
      await DatabaseHelper.deleteBranch(key);
      setState(() {
        branchList.removeWhere((branch) => branch.key == key);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Building deleted successfully!",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error deleting building: ${e.toString()}",
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
    // Implementation of updating building rating
  }
}

// Function to calculate general rating
double calculateGeneralRating(List<double> ratings) {
  if (ratings.isEmpty) return 0.0;
  double sum = ratings.reduce((a, b) => a + b);
  return sum / ratings.length;
}
