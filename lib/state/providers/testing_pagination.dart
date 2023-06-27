// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:marketplace/models/products_models.dart';
// import 'package:marketplace/utils/constants/firebase_constants.dart';
// import 'package:marketplace/utils/helpers/small_text.dart';
// import 'package:marketplace/utils/helpers/title_text.dart';

// class SearchFunctionality {
//   Future<List<ProductModel>> searchProduct(
//       {required String productName}) async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection(FirebaseConstants.productsCollection)
//         .orderBy('productName')
//         .startAt([productName]).endAt(['$productName\uf8ff']).get();

//     final documents = snapshot.docs;
//     return documents.map((doc) => ProductModel.fromJson(doc)).toList();
//   }
// }

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   late TextEditingController controller;
//   late List<ProductModel> products;
//   getSearches(String product) async {
//     final result =
//         await SearchFunctionality().searchProduct(productName: product);
//     log(products.toString());
//     setState(() {
//       products.addAll(result);
//     });
//     // log(result.toString());
//   }

//   @override
//   void initState() {
//     controller = TextEditingController();
//     products = [];
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const TitleText(text: 'Search'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             CupertinoSearchTextField(
//               controller: controller,
//               onSubmitted: (value) {
//                 if (value.isNotEmpty) {
//                   getSearches(value);
//                 }
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     color: Colors.blue,
//                     width: 200,
//                     height: 120,
//                     child: SmallText(text: products[index].productName),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
