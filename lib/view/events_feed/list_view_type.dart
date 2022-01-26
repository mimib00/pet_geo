import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/view/chat/messages.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/bottom_sheets/save_into_selection_kit.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/comments/comment_on_post.dart';
import 'package:pet_geo/view/comments/comments.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ListViewType extends StatelessWidget {
  const ListViewType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            logic.storiesHandler == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: SizedBox(
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        itemCount: logic.getStories.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var storiesData = logic.getStories[index];
                          return GestureDetector(
                            onTap: storiesData.onTap,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 7),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: storiesData.haveNewStory == true
                                      ? kGreenColor
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  '${storiesData.storyContent}',
                                  fit: BoxFit.cover,
                                  height: Get.height,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
            ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return const PostWidget();
              },
            ),
          ],
        );
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kInputBorderColor.withOpacity(0.3),
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc4c4c4),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/Group 30.png',
                      height: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                title: MyText(
                  text: 'Гость',
                  size: 12,
                  color: kDarkGreyColor,
                  weight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
                subtitle: MyText(
                  text: '17 янв в 15:00',
                  size: 12,
                  color: kInputBorderColor,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
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
            logic.simplePostSave == true
                ? SizedBox(
                    height: 353,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              'assets/images/download 1.png',
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        logic.hidePopupAfterSavingKit == true
                            ? const SizedBox()
                            : showPopupAfterSavingKit(),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 353,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          controller: logic.pageController,
                          onPageChanged: logic.currentIndex,
                          itemCount: 2,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        Obx(() {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    2,
                                    (index) => Container(
                                      width: 6,
                                      height: 6,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: logic.currentIndex.value == index
                                            ? kPrimaryColor
                                            : kPrimaryColor.withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
            logic.simplePostSave == false
                ? const SizedBox(
                    height: 0,
                  )
                : logic.storiesHandler == false
                    ? const SizedBox(
                        height: 10,
                      )
                    : GestureDetector(
                        onTap: () => Get.bottomSheet(
                          const SaveIntoSelectionKit(),
                          backgroundColor: kPrimaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          enableDrag: true,
                        ),
                        child: MyText(
                          text: 'Сохранить в подборку',
                          size: 14,
                          color: kBlackColor,
                          paddingLeft: 15,
                          paddingTop: 10.0,
                        ),
                      ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: logic.newSelectionKitSaved == true
                    ? 15
                    : logic.storiesHandler == false
                        ? 15
                        : 15,
                bottom: 15,
                right: 15,
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 22.0,
                    children: [
                      Image.asset(
                        'assets/images/dark_grey_border_Heart.png',
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const Comments()),
                        child: Image.asset(
                          'assets/images/comment.png',
                          height: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.bottomSheet(
                          const Share(),
                          backgroundColor: kPrimaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          enableDrag: true,
                        ),
                        child: Image.asset(
                          'assets/images/share.png',
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => logic.simplySavePost(),
                    child: Image.asset(
                      logic.simplePostSave == true
                          ? 'assets/images/Vector (16).png'
                          : logic.storiesHandler == false
                              ? 'assets/images/Vector (16).png'
                              : 'assets/images/Save.png',
                      height: logic.simplePostSave == true
                          ? 20
                          : logic.storiesHandler == false
                              ? 20
                              : 30,
                      color: kDarkGreyColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(
                () => Messages(
                  title: 'Нравится',
                ),
              ),
              child: MyText(
                text: 'Нравится: 55',
                size: 12,
                weight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: kDarkGreyColor,
                paddingLeft: 15,
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const Comments()),
              child: MyText(
                text: 'Посмотреть все комментарии (2)',
                size: 12,
                fontFamily: 'Roboto',
                color: kInputBorderColor,
                paddingLeft: 15.0,
                paddingTop: 10.0,
                paddingBottom: 10.0,
              ),
            ),
            ListTile(
              onTap: () => Get.to(() => CommentOnPost()),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/profile.png',
                  width: 37,
                  height: 37,
                  fit: BoxFit.cover,
                ),
              ),
              title: MyText(
                text: 'Добавьте комментарий',
                size: 12,
                color: kInputBorderColor,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget showPopupAfterSavingKit() {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.hidePopup().then(
                  (value) => Get.offAll(
                    () => BottomNavBar(
                      currentIndex: 1,
                    ),
                  ),
                );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            color: kPrimaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              width: Get.width,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/download 1.png',
                    height: 54,
                    width: 54,
                    fit: BoxFit.cover,
                  ),
                ),
                title: MyText(
                  text: 'Сохранено в подборку “Купить”',
                  size: 14,
                  color: kBlackColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
