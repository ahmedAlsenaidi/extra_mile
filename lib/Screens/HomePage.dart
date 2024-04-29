import 'package:extra_mile/ReusableCode/AppStyles.dart';
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
    _widgetOptions = <Widget>[
      Home(onUpdateBranch: widget.onUpdateBranch), // Pass the onUpdateBranch function to Home widget
      AddUpdateBranchDataInToFirebaseScreen(onUpdateBranch: widget.onUpdateBranch),
      AboutUs(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    // Dispose any resources like stream subscriptions here
    super.dispose();
  }

  void _onTapFunction(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppStyles.TealC,
        unselectedItemColor: AppStyles.GrayC,
        selectedFontSize: 20,
        backgroundColor: AppStyles.Black2C,

        items: [
          BottomNavigationBarItem(

            icon: Icon(Icons.home,
              color: _selectedIndex == 0 ? AppStyles.TealC : AppStyles.GrayC,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,
              color: _selectedIndex == 1 ? AppStyles.TealC : AppStyles.GrayC,
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.info,
              color: _selectedIndex == 2 ? AppStyles.TealC : AppStyles.GrayC,
            ),
            label: "About Us",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapFunction,

      ),

    );
  }
}
/*
BottomNavigationBar(
        backgroundColor: AppStyles.Black1C,
        currentIndex: _selectedIndex,
        elevation: 10,
        onTap: _onTapFunction,

        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: AppStyles.GrayC,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,color: AppStyles.GrayC,),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info,color: AppStyles.GrayC,),
            label: "About Us",
          ),
        ],
        selectedLabelStyle: TextStyle(color: AppStyles.GrayC), // Label color when selected
        unselectedLabelStyle: TextStyle(color: AppStyles.GrayC), // Label color when not selected
      ),
* */