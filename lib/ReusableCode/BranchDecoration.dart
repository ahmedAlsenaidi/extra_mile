import 'package:extra_mile/ReusableCode/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Data/BranchModel.dart';
import '../Screens/Details.dart';
import 'AppStyles.dart';
import 'Helper.dart';

class BranchDecoration extends StatelessWidget {
  final Branch branch;
  final Function(Branch, bool) onUpdateBranch;
  final Function(String key) onDelete;
  final Function(Branch) onShowMap;
  final Function(Branch, double) onUpdateRating;
  const BranchDecoration({
    Key? key,
    required this.onUpdateBranch,
    required this.onDelete,
    required this.onShowMap,
    required this.onUpdateRating, required this.branch,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        //
        child: GestureDetector(
          onTap: () {
            // Navigate to another page when photo is clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => detail(branch:branch ,)
              ),
            );
          },

          child: Container(
            height: 125,
            width: 0.90 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppStyles.TealC,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: 80,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:AppStyles.GrayC,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Location:", style: TextStyle(color: AppStyles.Black1C),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      branch.branchData!.name.toString(),
                                      style: TextStyle(color: AppStyles.Black1C),
                                    ),
                                    // Text(
                                    //   branch.branchData!.phoneNumber.toString(),
                                    //   style: AppStyles.headlineStyle1,
                                    // ),
                                  ],
                                ),
                              ],

                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 10,
                      //   left: 110,
                      //   child: IconButton(
                      //     icon: const Icon(
                      //       Icons.delete,
                      //       color: Colors.black,
                      //     ),
                      //     onPressed: () => onDelete(branch.key!),
                      //   ),
                      // ),
                      // Positioned(
                      //   bottom: 10,
                      //   left: 50,
                      //   child: IconButton(
                      //     icon: const Icon(
                      //       Icons.edit,
                      //       color: Colors.black,
                      //     ),
                      //     onPressed: () {
                      //       onUpdateBranch(branch, true);
                      //     },
                      //   ),
                      // ),
                      // Positioned(
                      //   bottom: 10,
                      //   left: 80,
                      //   child: IconButton(
                      //     icon: const Icon(
                      //       Icons.delete,
                      //       color: Colors.black,
                      //     ),
                      //     onPressed: () => onDelete(branch.key!),
                      //   ),
                      // ),
                      Positioned(bottom: 0,
                        left: 0,
                        child:IconButton(
                          icon:  Icon(
                              Icons.map,
                            color: AppStyles.Black1C,
                          ), onPressed: ()  => onShowMap(branch),
                        ),
                      ),

                      // Positioned(
                      //   bottom: -2,
                      //   left: 50,
                      //   child: RatingBar.builder(
                      //     initialRating: branch.branchData!.starRating!,
                      //     minRating: 0,
                      //     direction: Axis.horizontal,
                      //     allowHalfRating: true,
                      //     itemCount: 5,
                      //     itemSize: 30.0,
                      //     itemPadding: EdgeInsets.zero,
                      //     itemBuilder: (context, _) => const Icon(
                      //       Icons.star,
                      //       color: Colors.amber,
                      //     ),
                      //     onRatingUpdate: (rating) {
                      //       onUpdateRating(branch, rating);
                      //     },
                      //   ),
                      //
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppStyles.GrayC,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/extra-mile-logo.png", //${branch.branchData!.image.toString()}
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),

          ),

        )
    );

  }
}
/*
child : Container(
            child: Column(
              children: [
              Positioned(
                        bottom: 10,
                        left: 50,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            onUpdateBranch(branch, true);
                          },
                        ),
                      ),
                Positioned(
                  bottom: 10,
                  left: 80,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () => onDelete(branch.key!),
                  ),
                ),
                Positioned(bottom: 10,
                  left: 110,
                  child:IconButton(
                    icon: const Icon(
                        Icons.map,
                        color: Colors.purple
                    ), onPressed: ()  => onShowMap(branch),
                  ),
                ),
                Positioned(bottom: 10,
                  left: 140,
                  child:IconButton(
                    icon: const Icon(
                        Icons.sms,
                        color: Colors.amber
                    ), onPressed: () {
                    Helper.sendSMS(
                        '96313502',
                        "Hi i like" '${branch.branchData!.name} branch',
                        context);
                  },
                  ),
                ),
                Positioned(bottom: 10,
                  left: 170,
                  child:IconButton(
                    icon: const Icon(
                        Icons.email,
                        color: Colors.amber
                    ), onPressed: () {
                    Helper.sendEmail(
                        's129108@student.squ.edu.om',
                        'branch info',
                        "Hi i like" '${branch.branchData!.name} branch give me more information',
                        context);
                  },
                  ),
                ),
                Positioned(
                  bottom: -2,
                  left: 50,
                  child: RatingBar.builder(
                    initialRating: branch.branchData!.starRating!,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      onUpdateRating(branch, rating);
                    },
                  ),

                ),

*/

