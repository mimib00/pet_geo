import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/place_an_add/adopt_a_pet.dart';
import 'package:pet_geo/view/place_an_add/found_a_pet.dart';
import 'package:pet_geo/view/place_an_add/look_for_a_family_for_my_pet.dart';
import 'package:pet_geo/view/place_an_add/look_for_kennels.dart';
import 'package:pet_geo/view/place_an_add/lost_a_pet.dart';
import 'package:pet_geo/view/place_an_add/need_walking_a_dog.dart';
import 'package:pet_geo/view/place_an_add/offer_kennels.dart';
import 'package:pet_geo/view/place_an_add/offer_walking_a_dog.dart';

class PlaceAnAddController extends GetxController {
  var currentIndex = 0.obs;
  RxList addCategory = [
    'found_pet_title'.tr,
    'lost_pet_title'.tr,
    'family_pet_title'.tr,
    'kennels_title'.tr,
    'kennels_offer_title'.tr,
    'adopt_title'.tr,
    'pet_walk_title'.tr,
    'pet_walk_offer_title'.tr,
  ].obs;
  RxList categoryColor = [
    kGreenColor,
    kRedColor,
    kSkyBlueColor,
    kSkyBlueColor,
    kPurpleColor,
    kSecondaryColor,
    kYellowColor,
    kBrownColor,
  ].obs;

  void currentCategory(var index) {
    var currentIndex = index;
    switch (currentIndex) {
      case 0:
        {
          Get.to(() => FoundAPet());
        }
        break;

      case 1:
        {
          Get.to(() => const LostAPet());
        }
        break;
      case 2:
        {
          Get.to(() => const LookForAFamilyForMyPet());
        }
        break;
      case 3:
        {
          Get.to(() => const LookForKennels());
        }
        break;
      case 4:
        {
          Get.to(() => const OfferKennels());
        }
        break;
      case 5:
        {
          Get.to(() => const AdoptAPet());
        }
        break;
      case 6:
        {
          Get.to(() => const NeedWalkingADog());
        }
        break;
      case 7:
        {
          Get.to(() => const OfferWalkingADog());
        }
        break;
      default:
        {
          // ignore: avoid_print
          print('Last Index');
        }
        break;
    }
    update();
  }
}
