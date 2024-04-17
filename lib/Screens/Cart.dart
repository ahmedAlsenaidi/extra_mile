import 'package:extra_mile/Data/BranchModel.dart';
import 'package:gap/gap.dart';
import '../main.dart';
import 'map.dart';
import '../ReusableCode/Helper.dart';
// import 'reusableCode/AppRowData.dart';
import 'package:flutter/material.dart';
import '../Data/DatabaseHelper.dart';
import '../ReusableCode/BranchDecoration.dart';


class Cart extends StatefulWidget {


  const Cart({Key?key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Cart")),
    );
  }


  }


