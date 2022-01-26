import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ModNotifications extends StatefulWidget {
  const ModNotifications({Key? key}) : super(key: key);

  @override
  State<ModNotifications> createState() => _ModNotificationsState();
}

class _ModNotificationsState extends State<ModNotifications> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'Уведомления',
        globalKey: _key,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          NotificationSettingsTiles(
            title: 'Отметки “Нравится”',
            onTap: () {},
          ),
          NotificationSettingsTiles(
            title: 'Новые участники',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NotificationSettingsTiles extends StatefulWidget {
  NotificationSettingsTiles({
    Key? key,
    this.onTap,
    this.title,
  }) : super(key: key);

  VoidCallback? onTap;
  // ignore: prefer_typing_uninitialized_variables
  var title;

  @override
  State<NotificationSettingsTiles> createState() =>
      _NotificationSettingsTilesState();
}

class _NotificationSettingsTilesState extends State<NotificationSettingsTiles> {
  bool? status = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kInputBorderColor.withOpacity(0.3),
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        onTap: widget.onTap,
        title: MyText(
          text: '${widget.title}',
          size: 15,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        trailing: SizedBox(
          width: 57,
          child: FlutterSwitch(
            width: 57,
            height: 30,
            activeColor: kSecondaryColor,
            inactiveColor: kInputBorderColor,
            value: status!,
            onToggle: (val) {
              setState(() {
                status = !status!;
              });
            },
          ),
        ),
      ),
    );
  }
}
