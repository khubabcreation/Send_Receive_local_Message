// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SecondScreen extends StatefulWidget {
//   const SecondScreen({super.key});

//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }

// class _SecondScreenState extends State<SecondScreen> {
//   final phoneController = TextEditingController();
//   SharedPreferences? pref;
//   List<String> list = <String>[];
//   @override
//   void initState() {
//     super.initState();
//     assighnInstance();
//   }

//   assighnInstance() async {
//     pref = await SharedPreferences.getInstance();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height - kToolbarHeight;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Store Number'),
//         centerTitle: true,
//       ),
//       body: Container(
//         height: height,
//         width: width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: phoneController,
//               ),
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   list = pref!.getStringList('phone')!;
//                   String phoneNumber = phoneController.text.trim();
//                   list.add(phoneNumber);
//                   pref!.setStringList('phone', list);

//                   List? oldlist = pref!.getStringList('phone');

//                   print(oldlist);
//                 },
//                 child: Text('Save Number'))
//           ],
//         ),
//       ),
//     );
//   }
// }
