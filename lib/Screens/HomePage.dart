import 'package:flutter/material.dart';
import '../Data/BranchModel.dart';
import 'AboutUs.dart';
import 'BranchesCreatUpdate.dart';
import 'Home.dart';


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
    // DatabaseHelper.writeMessagesToFirebace();
    // if (branchList.isNotEmpty){
    //   DatabaseHelper.createFirebaseRealtimeDBWithUniqueIDs("Branches", branchList);
    // } else {
    //   print("Data cannot therefore be saved into Firebases");
    // }
    _widgetOptions = <Widget>[
      Home(onUpdateBranch: (Branch branch, bool isUpdate) {
          _updateBranch(branch, isUpdate);
        },
      ),
      AddUpdateBranchDataInToFirebaseScreen(
          onUpdateBranch:(
              Branch branch, bool isUpdate) {}),//Add page
      AboutUs(),//About Us
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




