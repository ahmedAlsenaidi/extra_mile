// import 'package:extra_mile/Data/Data.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../Data/DatabaseHelper.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Signed in'),
//             MaterialButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//
//                 // DatabaseHelper.writeMessagesToFirebace();
//                 // if (branchList.isNotEmpty){
//                 //   DatabaseHelper.createFirebaseRealtimeDBWithUniqueIDs("Branches", branchList);
//                 // } else {
//                 //   print("Data cannot therefore be saved into Firebases");
//                 // }
//               },
//               child: const Text('Sign Out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:fluentui_icons/fluentui_icons.dart' show FluentSystemIcons;
import 'package:flutter/material.dart';
import '../Data/BranchModel.dart';
import "../ReusableCode/BranchDecoration.dart";
import 'AboutUs.dart';
import 'BranchesCreatUpdate.dart';
import 'Cart.dart';
import 'Home.dart';

//import 'package:firebase_database/firebase_database.dart';
// import 'package:oman_castles_2/MyImageList.dart';
// import 'package:oman_castles_2/MyTextScreen3.dart';
// import 'package:oman_castles_2/MyTextScreen4.dart';
// import 'package:oman_castles_2/MyTextScreen5.dart';
// import 'package:oman_castles_2/MyTextScreen6.dart';
// import 'package:oman_castles_2/data/FirebaseCRUD.dart';
// import 'package:oman_castles_2/data/castle_model.dart';
//import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final void Function(Branch, bool) onUpdateBranch;

  const HomePage({Key? key, required this.onUpdateBranch}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Home(
        onUpdateBranch: (Branch branch, bool isUpdate) {
          _updateBranch(branch, isUpdate);
        },
      ),
      // Cart(),
      AddUpdateBranchDataInToFirebaseScreen(onUpdateBranch: (Branch branch, bool isUpdate) {}),
      AboutUs(),
    ];
  }

  void _updateBranch(Branch branch, bool isUpdate) {
    setState(() {
      _selectedIndex = 1;
      _widgetOptions[1] = AddUpdateBranchDataInToFirebaseScreen(
        branch: branch,
        isUpdate: isUpdate,
        onUpdateBranch: (Branch branch, bool isUpdate) {},
      );
    });
  }

  void _onTapFunction(int value) {
    setState(() {
      // Reset AddNewCastleDataToFirebase widget when 'addCastle' is clicked
      if (value == 1) {
        _widgetOptions[1] = AddUpdateBranchDataInToFirebaseScreen(
          onUpdateBranch: (Branch branch, bool isUpdate) {
            _updateBranch(branch, isUpdate);
          },
        );
      }
      _selectedIndex = value;
      print("_selectedIndex: $_selectedIndex");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        elevation: 10,
        onTap: _onTapFunction,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopping_cart_sharp),
            // label: "Cart",
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About Us",
          ),
        ],
      ),
    );
  }
}




