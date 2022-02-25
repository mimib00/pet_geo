// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';

class AdDetails extends StatelessWidget {
  AdDetails({
    Key? key,
  }) : super(key: key);

  MapController controller = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    var ad = controller.ad;
    if (ad == null) return Container();

    Widget type = const Text('');
    switch (ad.adType) {
      case "found_pet_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kGreenColor,
          ),
        );
        break;
      case "lost_pet_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kRedColor,
          ),
        );
        break;
      case "family_pet_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kSkyBlueColor,
          ),
        );
        break;
      case "kennels_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kSkyBlueColor,
          ),
        );
        break;
      case "kennels_offer_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kPurpleColor,
          ),
        );
        break;
      case "adopt_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kSecondaryColor,
          ),
        );
        break;
      case "pet_walk_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kYellowColor,
          ),
        );
        break;
      case "pet_walk_offer_title":
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kBrownColor,
          ),
        );
        break;

      default:
        type = Text(
          ad.adType.tr,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: kGreenColor,
          ),
        );
    }
    return Container(
      width: Get.width,
      height: 100,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // image
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: ad.photoUrl,
                width: 100,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),

          // details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              type,
              const SizedBox(height: 8),
              AdInfoTile(label: "type_title".tr, text: ad.animalType.tr),
              AdInfoTile(label: "gender_title".tr, text: ad.gender.tr),
              AdInfoTile(label: "breed_title".tr, text: ad.breed.tr),
              ad.color.isEmpty ? AdInfoTile(label: "Payment".tr, text: ad.payment) : AdInfoTile(label: "color_title".tr, text: ad.color),
            ],
          ),

          // close
          const Spacer(),
          IconButton(
            onPressed: () => controller.togglePanel(false),
            icon: const Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

class AdInfoTile extends StatelessWidget {
  final String label;
  final String text;
  const AdInfoTile({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
