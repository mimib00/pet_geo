import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/send_box.dart';

// ignore: must_be_immutable
class CommentOnPost extends StatelessWidget {
  bool? haveSlider;

  CommentOnPost({Key? key,
    this.haveSlider = true,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        title: 'Комментарии',
        onTitleTap: () {},
        showSearch: () {},
        globalKey: _key,
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              MyText(
                text: 'Отдам питомца',
                size: 18,
                weight: FontWeight.w700,
                color: kSecondaryColor,
                paddingLeft: 15,
                paddingTop: 15,
              ),
              MyText(
                text: 'Кошка по кличке неизвестно\nКому бенгалов?\nКонтакты',
                size: 12,
                fontFamily: 'Roboto',
                color: kDarkGreyColor,
                paddingLeft: 15,
                paddingTop: 15,
              ),
              MyText(
                text: 'Ссылка',
                size: 12,
                fontFamily: 'Roboto',
                color: kSecondaryColor,
                paddingLeft: 15,
                paddingTop: 10,
                paddingBottom: 10.0,
              ),
              haveSlider == true
                  ? GetBuilder<EventsFeedController>(
                      init: EventsFeedController(),
                      builder: (logic) {
                        return SizedBox(
                          height: 353,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              PageView.builder(
                                controller: logic.pageController,
                                onPageChanged: logic.currentIndex,
                                itemCount: 2,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/download 1.png',
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            2,
                                            (index) => Container(
                                              width: 6,
                                              height: 6,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color:
                                                    logic.currentIndex.value ==
                                                            index
                                                        ? kPrimaryColor
                                                        : kPrimaryColor
                                                            .withOpacity(0.3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      })
                  : Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 353,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'assets/images/download 1.png',
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              CommentsTiles(
                personImage: 'assets/images/profile.png',
                comment: 'Да, осталась 1',
                time: '20 мин.',
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 85,
                width: Get.width,
                color: kPrimaryColor,
                child: Center(
                  child: SendBox(
                    hintText: 'Напишите комментарий',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CommentsTiles extends StatelessWidget {
  CommentsTiles({
    Key? key,
    this.personImage,
    this.comment,
    this.time,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var personImage, comment, time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          '$personImage',
          height: 37,
          width: 37,
          fit: BoxFit.cover,
        ),
      ),
      title: MyText(
        text: '$comment',
        size: 12,
        color: kDarkGreyColor,
        fontFamily: 'Roboto',
      ),
      subtitle: MyText(
        text: '$time',
        size: 12,
        color: kInputBorderColor,
        fontFamily: 'Roboto',
      ),
      trailing: MyText(
        text: 'Ответить',
        size: 12,
        color: kInputBorderColor,
        fontFamily: 'Roboto',
        weight: FontWeight.w900,
      ),
    );
  }
}
