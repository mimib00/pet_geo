import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/filter_controller/filter_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class Filter extends StatelessWidget {
  VoidCallback? onTap;

  Filter({Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      init: FilterController(),
      builder: (logic) {
        return Drawer(
          child: Container(
            color: kPrimaryColor,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: [
                MyText(
                  paddingTop: 40.0,
                  paddingLeft: 15.0,
                  paddingBottom: 20.0,
                  text: 'Фильтрация',
                  size: 18,
                  color: kDarkGreyColor,
                  fontFamily: 'Roboto',
                ),
                MyText(
                  paddingLeft: 15.0,
                  text: 'Вид животного',
                  size: 15,
                  color: kDarkGreyColor,
                  weight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: logic.animalTypes.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = logic.animalTypes[index];
                    return animalTypes(
                      data.petImg,
                      data.selectedPetImage,
                      data.petType,
                      index,
                    );
                  },
                ),
                MyText(
                  paddingTop: 20.0,
                  paddingLeft: 15.0,
                  text: 'Категории поиска',
                  size: 15,
                  color: kDarkGreyColor,
                  weight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: logic.searchCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = logic.searchCategories[index];
                    return SearchCategories(
                      activeColor: data.activeColor,
                      title: data.title,
                      value: data.isSelected,
                    );
                  },
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: MyButton(
                    height: 47,
                    btnBgColor: kSecondaryColor,
                    text: 'Посмотреть',
                    textColor: kPrimaryColor,
                    weight: FontWeight.w700,
                    radius: 12.0,
                    onPressed: onTap,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget animalTypes(
      var animalImg, selectedAnimalImage, animalType, var index) {
    return GetBuilder<FilterController>(
      init: FilterController(),
      builder: (logic) {
        return Material(
          color: kPrimaryColor,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0,
            ),
            onTap: () => logic.selectedAnimal(index),
            leading: Image.asset(
              logic.currentIndex == index ? animalImg : selectedAnimalImage,
              height: 35,
            ),
            title: MyText(
              text: animalType,
              size: 15,
              fontFamily: 'Roboto',
              color: kDarkGreyColor,
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class SearchCategories extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var activeColor, title;
  bool? value;

  SearchCategories({Key? key,
    this.activeColor,
    this.title,
    this.value = false,
  }) : super(key: key);

  @override
  State<SearchCategories> createState() => _SearchCategoriesState();
}

class _SearchCategoriesState extends State<SearchCategories> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      init: FilterController(),
      builder: (logic) {
        return ListTile(
          leading: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: kDarkGreyColor,
              ),
            ),
            child: GestureDetector(
              onTap: () => setState(() {
                widget.value = !widget.value!;
                if (kDebugMode) {
                  print(widget.title);
                }
              }),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                      widget.value == true ? widget.activeColor : kPrimaryColor,
                ),
              ),
            ),
          ),
          title: MyText(
            text: '${widget.title}',
            size: 15,
            fontFamily: 'Roboto',
            color: kDarkGreyColor,
          ),
        );
      },
    );
  }
}
