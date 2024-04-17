import 'package:extra_mile/Data/BranchModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';
import '../main.dart';
import 'map.dart';
import '../ReusableCode/Helper.dart';
// import 'reusableCode/AppRowData.dart';
import 'package:flutter/material.dart';
import '../Data/DatabaseHelper.dart';
import '../ReusableCode/BranchDecoration.dart';


class Home extends StatefulWidget {
  final Function(Branch,bool) onUpdateBranch;

  const Home({Key?key, required this.onUpdateBranch}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Branch> branchList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.readFirebaseRealtimeDBMain((branchList) {
      setState(() {this.branchList = branchList;});
    });
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
  void _handleShowMap(Branch branch){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MapScreen(branch: branch)));
  }
  Future<void> _handleUpdateBuildingRating(Branch branch, double newRating) async {
    String key = branch.key!;
    try{
      //Find the Building with given key
      final branchIndex = branchList.indexWhere((branch) => branch.key == key);
      if (branchIndex == -1){
        throw Exception("not found");
      }
      //check if not null
      BranchData? nullableBranchData = branchList[branchIndex].branchData;
      if (nullableBranchData == null){
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text("Updated successfully!",
            textAlign: TextAlign.center,
          ),
            backgroundColor: Colors.green,

          )
      );

    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          "Error Updating rating : ${e.toString()}",
          textAlign: TextAlign.center,
        ),
          backgroundColor: Colors.red,
        ),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    if (branchList.isEmpty) {
      print("branchList is empty!");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(234, 223, 180, 100),//rgb(234, 223, 180)
        title: const Center(child: Text("Extra Mile")),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children:[
            const Text('Signed in'),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();

                // DatabaseHelper.writeMessagesToFirebace();
                // if (branchList.isNotEmpty){
                //   DatabaseHelper.createFirebaseRealtimeDBWithUniqueIDs("Branches", branchList);
                // } else {
                //   print("Data cannot therefore be saved into Firebases");
                // }
              },
              child: const Text('Sign Out'),
            ),
            Column(
              children:[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       'Name',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //     Text(
                //       'Country',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //     Text(
                //       'Age',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       '====',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //     Text(
                //       '=======',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //     Text(
                //       '===',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //   ],
                // ),
                //const Gap(10),
                // const AppRowData(name: "Haitham", country: "Oman", age: 35),
                // const AppRowData(name: "Naif", country: "UAE", age: 8),
                // const AppRowData(name: "Noor", country: "KSA", age: 10),
                // const AppRowData(name: "Aisha", country: "Qatar", age: 33),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       '====',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //     Text(
                //       '=======',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //     Text(
                //       '===',
                //       style: Theme.of(context).textTheme.headlineLarge,
                //     ),
                //   ],
                // ),
                // const Gap(20),
                const Text(
                  "Branch",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
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
                          onUpdateBranch: (Branch , bool ) {  },

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
/*
void readFirebaseRealtimeDBMain() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("architecture").onValue.listen((buildingDataJson) {
      print("Key: ${buildingDataJson.snapshot.key}");
      //print("Data: " + castleDataJson.snapshot.value.toString());

      if (buildingDataJson.snapshot.exists) {
        //Attempt 1

        BuildingData buildingData;
        Building castle;
        if (buildingList.isNotEmpty) {
          buildingList.clear();
        }

        buildingDataJson.snapshot.children.forEach((element) {
          print("Element Key: ${element.key}");
          print("Element: ${element.value}");

          buildingData = BuildingData.fromJson(element.value as Map);
          castle = Building(element.key, buildingData);
          buildingList.add(castle);
        });
        setState(() {});
        print("castleList Length: ${buildingList.length}");
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }*/
}

//
// **************************
