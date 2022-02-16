import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/bindings/auth_binding.dart';
import 'package:pet_geo/utils/translations.dart';
import 'package:pet_geo/view/about_us/about_us.dart';
import 'package:pet_geo/view/about_us/privacy_policy/privacy_policy.dart';
import 'package:pet_geo/view/about_us/terms_and_conditions/terms_and_conditions.dart';
import 'package:pet_geo/view/animal_communities/animal_communities.dart';
import 'package:pet_geo/view/bonus_space/bonus_space.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notification",
  description: "This channel is used for important notifications",
  importance: Importance.high,
  playSound: true,
);

Future<void> firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgoundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(const PetGeo());
}

class PetGeo extends StatefulWidget {
  const PetGeo({Key? key}) : super(key: key);

  @override
  State<PetGeo> createState() => _PetGeoState();
}

class _PetGeoState extends State<PetGeo> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel.id,
              androidNotificationChannel.name,
              channelDescription: androidNotificationChannel.description,
              color: Colors.blue,
              playSound: true,
              icon: "@mipmap/ic_launcher",
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if (notification != null && androidNotification != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.title!),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body!)
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      onInit: () {
        String pathToReference = "petAds";
        Geofire.initialize(pathToReference);
      },
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
