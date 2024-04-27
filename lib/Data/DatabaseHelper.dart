import '../Data/BranchModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DatabaseHelper{
  static void writeMessagesToFirebace(){
    final databaseref = FirebaseDatabase.instance.ref();//reference()
    // databaseref
    //     .child('messages')
    //     .push()
    //     .set({'messages' : 'HelloWorld'});
    databaseref
        .child('messages')
        .set({"message":"Hello World1"})
        .then((value) => print("message witten successfully"))
        .catchError((error)=> print("Failed to write message: $error"));
  }

  static void createFirebaseRealtimeDBWithUniqueIDs(String mainNodeName, List<Map<String,dynamic>>branchList){
    DatabaseReference databaseReference =FirebaseDatabase.instance.ref(mainNodeName);
    if (branchList.isNotEmpty){
      branchList.forEach((element) {
        databaseReference
            .push()
            .set(element)
            .then((value) => print("ForList data successfully saved!"))
            .catchError((error)=> print("Failed to write message: $error"));
      });
    }
    else {
      print("ForList is empty!");

    }
  }

  static Future<void> updatebranchesData(
      String key,
      BranchData branchData,
      BuildContext context) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference
        .child("Branches")
        .child(key)
        .update(branchData.toJson());
  }

  static void readFirebaseRealtimeDBMain(Function (List<Branch>) branchListCallback){
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Branches').onValue.listen((branchDataJson) {
      if (branchDataJson.snapshot.exists){
        BranchData branchData;
        Branch branch;
        List<Branch> branchList = [];
        branchDataJson.snapshot.children.forEach((element) {
          branchData = BranchData.fromJson(element.value as Map);
          branch = Branch(element.key, branchData);
          branchList.add(branch);
        });
        branchListCallback(branchList);
      } else{
        print("The data snapshot dose not exist!");
      }
    });
  }

  static Future<void> saveDataItem(BranchData branchData/*from model class*/) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return databaseReference
        .child('Branches')
        .push()
        .set(branchData.toJson())
        .then((value) => print("branch data saved successfully!"))
        .catchError((error) => print("Failed to save branch data: $error"));
  }

  static Future<void> deleteBranch(String key) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child("Branches").child(key).remove();
  }


}