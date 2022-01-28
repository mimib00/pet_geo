import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/bindings/auth_binding.dart';
import 'package:pet_geo/utils/translations.dart';
import 'package:pet_geo/view/about_us/about_us.dart';
import 'package:pet_geo/view/about_us/privacy_policy/privacy_policy.dart';
import 'package:pet_geo/view/about_us/terms_and_conditions/terms_and_conditions.dart';
import 'package:pet_geo/view/animal_communities/animal_communities.dart';
import 'package:pet_geo/view/bonus_space/bonus_space.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/comments/comments.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/events_feed/events_feed.dart';
import 'package:pet_geo/view/friends/friends.dart';
import 'package:pet_geo/view/likes/likes.dart';
import 'package:pet_geo/view/map/map_page_main.dart';
import 'package:pet_geo/view/offer_help/offer_help.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:pet_geo/view/pet_geo_guest_profile/pet_geo_guest_profile.dart';
import 'package:pet_geo/view/pet_news_community_profile/pet_new_community_profile.dart';
import 'package:pet_geo/view/pets_profile/pets_profile.dart';
import 'package:pet_geo/view/place_an_add/found_a_pet.dart';
import 'package:pet_geo/view/place_an_add/place_an_add.dart';
import 'package:pet_geo/view/place_an_add/place_an_add_widget.dart';
import 'package:pet_geo/view/settings/settings.dart';
import 'package:pet_geo/view/splash_screen/splash_screen.dart';
import 'package:pet_geo/view/stories/stories.dart';
import 'package:pet_geo/view/user/user.dart';
import 'package:pet_geo/view/user_profile/user_profile_profile_image/profile_image.dart';
import 'package:pet_geo/view/user_profile/user_profile_with_offer_help.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const PetGeo());
}

class PetGeo extends StatelessWidget {
  const PetGeo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(GetStorage().read("lang"));
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Pet Geo',
      theme: ThemeData(
        fontFamily: 'Open Sans',
        scaffoldBackgroundColor: kPrimaryColor,
        primaryColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: kSecondaryColor,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: kSecondaryColor.withOpacity(0.1),
        ),
      ),
      themeMode: ThemeMode.light,
      initialRoute: '/splash_screen',
      locale: GetStorage().read("lang") != null ? Locale(GetStorage().read("lang")) : const Locale("en"),
      fallbackLocale: const Locale("en"),
      translations: Translation(),
      getPages: [
        GetPage(name: '/splash_screen', page: () => const SplashScreen()),
        GetPage(name: '/on_boarding_screen', page: () => OnBoardingScreen()),
        GetPage(name: '/user', page: () => const Authentication()),
        GetPage(name: '/bottom_nav_bar', page: () => BottomNavBar()),
        GetPage(name: '/map_page_main', page: () => MapPageMain()),
        GetPage(name: '/place_an_add', page: () => const PlaceAnAdd()),
        GetPage(name: '/place_an_add_widget', page: () => PlaceAnAddWidget()),
        GetPage(name: '/found_a_pet', page: () => FoundAPet()),
        GetPage(name: '/events_feed', page: () => const EventsFeed()),
        GetPage(name: '/profile_image', page: () => const ProfileImage()),
        GetPage(name: '/pet_geo_guest_profile', page: () => const PetGeoGuestProfile()),
        GetPage(name: '/user_profile_with_offer_help', page: () => UserProfileWithOferHelp()),
        GetPage(name: '/pets_profile', page: () => const PetsProfile()),
        GetPage(name: '/settings', page: () => Settings()),
        GetPage(name: '/animal_communities', page: () => AnimalCommunities()),
        GetPage(name: '/pet_news_community_profile', page: () => const PetNewsCommunityProfile()),
        GetPage(name: '/offer_help', page: () => const OfferHelp()),
        GetPage(name: '/likes', page: () => Likes()),
        GetPage(name: '/comments', page: () => const Comments()),
        GetPage(name: '/stories', page: () => const Stories()),
        GetPage(name: '/friends', page: () => Friends()),
        GetPage(name: '/about_us', page: () => AboutUs()),
        GetPage(name: '/privacy_policy', page: () => PrivacyPolicy()),
        GetPage(name: '/terms_and_conditions', page: () => TermsAndConditions()),
        GetPage(name: '/bonus_space', page: () => BonusSpace()),
      ],
    );
  }
}
