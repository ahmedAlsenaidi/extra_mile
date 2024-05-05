// import 'package:extra_mile/ReusableCode/AppStyles.dart';
// import 'package:flutter/material.dart';
// import '../ReuseAbleWidgets/ImageDecoration.dart';
// class StaticImgList extends StatelessWidget {
//   const StaticImgList({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final List<CarService> services = [
//     CarService(
//       imagePath: 'images/oil change.jpg',
//       description: 'Oil Change',
//     ),
//     CarService(
//       imagePath: 'images/tire rotation.jpeg',
//       description: 'Tire Rotation',
//     ),
//     CarService(
//       imagePath: 'images/brake.jpg',
//       description: 'Brake Repair',
//     ),
//     CarService(
//       imagePath: 'images/car wash.jpg',
//       description: 'Car wash',
//     ),
//     // Add more services as needed
//   ];
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppStyles.Black1C,
//         title: Text('Car Services',style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: AppStyles.GrayC,
//                     fontSize: 20),),
//       ),
//       body: ListView.builder(
//         itemCount: services.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Card(
//               elevation: 4,
              
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
                
//               ),
//               color: AppStyles.TealC,
//               child: ListTile(
//                 leading: Image.asset(
                  
//                   services[index].imagePath,
//                   width: 70,
//                   height: 70,
//                 ),
//                 title: Text(
//                   services[index].description,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CarService {
//   final String imagePath;
//   final String description;

//   CarService({required this.imagePath, required this.description});
// }
import 'package:extra_mile/ReusableCode/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../ReuseAbleWidgets/ImageDecoration.dart';
class StaticImgList extends StatelessWidget {
  const StaticImgList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
              title: Center(
                child: Text(
                  'Our Services',
                  style: AppStyles.Gray,
                ),
              ),
              backgroundColor: AppStyles.Black1C,
            ),
      body:  Center(

        child: SingleChildScrollView(

          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Box(imgPath: "brake.jpg"),
              Text(
              'Brake Changing',
              style: AppStyles.Black1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
              ),
            ),
              Box(imgPath: "car wash.jpg"),
              Text(
              'Car Washing',
              style: AppStyles.Black1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
              ),
            ),
              Box(imgPath: "oil change.jpg"),
              Text(
              'Oil Changing',
              style: AppStyles.Black1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
              ),
            ),
              Box(imgPath: "tire rotation.jpeg"),
              Text(
              'Tires Repairing',
              style: AppStyles.Black1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
              ),
            ),
              // Box(imgPath: "pic_2.jpg"),
              // Box(imgPath: "pic_3.jpg"),

            ],
          ),
        ),
      ),
    );
  }
}