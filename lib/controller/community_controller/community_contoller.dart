import 'package:get/get.dart';
import 'package:pet_geo/model/community_model/community_model.dart';
import 'package:pet_geo/view/pet_geo_community_profile_for_mods/pet_geo_community_profile_for_mods.dart';
import 'package:pet_geo/view/pet_geo_guest_profile/pet_geo_guest_profile.dart';
import 'package:pet_geo/view/pet_news_community_profile/pet_new_community_profile.dart';

class CommunityController extends GetxController {
  bool? search = false;

  void showSearch() {
    search = !search!;
    update();
  }

  List<CommunityModel> communityModel = [
    CommunityModel(
      communityLogo: 'assets/images/Depositphotos_14094278_ds (1) 1.png',
      communityName: 'PetGeo',
      onTap: () => Get.to(() => const PetGeoGuestProfile()),
    ),
    CommunityModel(
      communityLogo: 'assets/images/Depositphotos_250473480_ds 1.png',
      communityName: 'PetNews',
      onTap: () => Get.to(() => const PetNewsCommunityProfile()),
    ),
    CommunityModel(
      communityLogo: 'assets/images/Events Logo.png',
      communityName: 'Example For Mod',
      onTap: () => Get.to(() => const PetGeoCommunityProfileForMods()),
    ),
  ];
  List<MessagesModel> msgs = [
    MessagesModel(
      name: 'Леонид Белов',
    ),
    MessagesModel(
      name: 'Лиана Высоцкая',
      add: true,
    ),
    MessagesModel(
      name: 'Ксения Урывина',
      add: true,
    ),
    MessagesModel(
      name: 'Лиана Высоцкая',
      add: true,
    ),
  ];

  List<MessagesModel> get getMessagesModel => msgs;

  List<CommunityModel> get getCommunityModel => communityModel;
}
