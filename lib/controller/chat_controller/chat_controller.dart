import 'package:get/get.dart';
import 'package:pet_geo/model/chat_model/chat_model.dart';

class ChatController extends GetxController {
  bool search = false;

  void showSearch() {
    search = !search;
    update();
  }

  List<ChatHeadModel> chatHeadModel = [
    ChatHeadModel(
      name: 'Леонид Белов',
      msg: 'Хорошо',
      time: '5 мин.',
    ),
    ChatHeadModel(
      name: 'Лиана Высоцкая',
      msg: 'Вы: Я тебя поняла',
      time: '1 ч.',
      haveNewMsg: true,
    ),
    ChatHeadModel(
      name: 'Ксения Урывина',
      msg: 'ОК',
      time: '1 ч.',
      msgCounter: true,
    ),
  ];

  List<ChatHeadModel> get getChatHeadModel => chatHeadModel;
}
