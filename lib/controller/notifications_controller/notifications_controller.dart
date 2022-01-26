import 'package:get/get.dart';
import 'package:pet_geo/model/notifications_model/notifications_model.dart';
import 'package:pet_geo/view/notifications/new_notification_post.dart';
import 'package:pet_geo/view/comments/comment_on_post.dart';

class NotificationsController extends GetxController {
  List<NotificationsModel> notificationModel = [
    NotificationsModel(
      haveFriendRequest: true,
    ),
    NotificationsModel(
      name: 'Леонид Белов',
      notificationMsg: 'ответил на комментарий',
      time: 'вчера в 19:23',
      haveNewNotification: true,
      onTap: () => Get.to(() => CommentOnPost(haveSlider: false,)),
    ),
    NotificationsModel(
      name: 'Лиана Высоцкая',
      notificationMsg: 'понравилась ваша',
      notificationThing: 'фотография',
      time: '8 июня в 13:01',
      onTap: () => Get.to(() => NewNotificationsPost()),
    ),
  ];

  List<NotificationsModel> get getNotificationModel => notificationModel;
}
