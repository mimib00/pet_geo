// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pet_geo/controller/pets_controller/pets_controller.dart';
// import 'package:pet_geo/model/map_model/list_page_model/list_page_model_all.dart';
// import 'package:pet_geo/view/constant/constant.dart';
// import 'package:pet_geo/view/drawer/my_drawer.dart';
// import 'package:pet_geo/view/map/specific_post.dart';
// import 'package:pet_geo/view/pets_profile/pets_profile.dart';
// import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
// import 'package:pet_geo/view/widget/my_text.dart';
// import 'package:pet_geo/view/widget/search_box.dart';
//
// class Pets extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PetsController>(
//       init: PetsController(),
//       builder: (logic) {
//         return Scaffold(
//           key: _key,
//           drawer: MyDrawer(),
//           appBar: CustomAppBar2(
//             haveSearch: true,
//             haveTitle: true,
//             onTitleTap: () {},
//             showSearch: () => logic.showSearch(),
//             title: 'Питомцы',
//             globalKey: _key,
//           ),
//           body: Stack(
//             children: [
//               ListView.separated(
//                 separatorBuilder: (context, index) => Container(
//                   height: 1,
//                   color: kInputBorderColor.withOpacity(0.3),
//                 ),
//                 itemCount: logic.getPets.length,
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   var data = logic.getPets[index];
//                   return Tiles(data: data);
//                 },
//               ),
//               logic.search == true
//                   ? SearchBox(
//                       hintText: 'Поиск',
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class Tiles extends StatefulWidget {
//   Tiles({
//     Key? key,
//     required this.data,
//   }) : super(key: key);
//
//   final PetsModel data;
//
//   @override
//   State<Tiles> createState() => _TilesState();
// }
//
// class _TilesState extends State<Tiles> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () => Get.to(
//         () => SpecificPost(
//           showBluePin: true,
//           bluePinOnTap: () => Get.to(
//             () => PetsProfile(),
//           ),
//         ),
//       ),
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: Image.asset(
//           widget.data.petImage,
//           height: 48,
//           width: 48,
//         ),
//       ),
//       title: MyText(
//         text: widget.data.title,
//         size: 16,
//         weight: FontWeight.w600,
//         color: kDarkGreyColor,
//       ),
//       subtitle: MyText(
//         text: widget.data.subtitle,
//         size: 14,
//         color: kInputBorderColor,
//       ),
//       trailing: Container(
//         width: 25,
//         height: 22,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(2),
//           color: kSecondaryColor,
//         ),
//         child: Center(
//           child: Image.asset(
//             'assets/images/Map Logo.png',
//             height: 13,
//             color: kPrimaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
