import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'architecture_model.dart';

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

  // static void createFirebaseRealtimeDBWithUniqueIDs(
  //     String mainNodeName, List<Map<String,dynamic>>forList){
  //   DatabaseReference databaseReference =FirebaseDatabase.instance.ref(mainNodeName);
  //   if (forList.isNotEmpty){
  //     forList.forEach((element) {
  //       databaseReference
  //           .push()
  //           .set(element)
  //           .then((value) => print("ForList data successfully saved!"))
  //           .catchError((error)=> print("Failed to write message: $error"));
  //     });
  //   }
  //   else {
  //     print("ForList is empty!");
  //
  //   }
  // }
  // static void readFirebaseRealtimeDBMain(Function (List<Building>) buildingListCallback){
  //   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  //   databaseReference.child('architecture').onValue.listen((buildingDataJson) {
  //     if (buildingDataJson.snapshot.exists){
  //       BuildingData buildingData;
  //       Building building;
  //       List<Building> buildingList = [];
  //       buildingDataJson.snapshot.children.forEach((element) {
  //         buildingData = BuildingData.fromJson(element.value as Map);
  //         building = Building(element.key, buildingData);
  //         buildingList.add(building);
  //       });
  //       buildingListCallback(buildingList);
  //     } else{
  //       print("The data snapshot dose not exist!");
  //     }
  //   });
  // }
  //
  // static Future<void> saveDataItem(BuildingData buildingData/*from model class*/) {
  //   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  //   return databaseReference
  //       .child('architecture')
  //       .push()
  //       .set(buildingData.toJson())
  //       .then((value) => print("Castle data saved successfully!"))
  //       .catchError((error) => print("Failed to save castle data: $error"));
  // }
  // static Future<void> updatebuildingData(
  //     String key, BuildingData buildingData, BuildContext context) async {
  //   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  //   await databaseReference
  //       .child("architecture")
  //       .child(key)
  //       .update(buildingData.toJson());
  // }
  //
  // static Future<void> deleteBuilding(String key) async {
  //   DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  //   await databaseReference.child("architecture").child(key).remove();
  // }


}