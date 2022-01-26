import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class FilterController extends GetxController {
  var currentIndex = 0;
  RxList<PetTypesModel> animalTypes = [
    PetTypesModel(
      petType: 'Кошки',
      selectedPetImage: 'assets/images/selected Icon Cat.png',
      petImg: 'assets/images/Icon Cat.png',
    ),
    PetTypesModel(
      petType: 'Собаки',
      selectedPetImage: 'assets/images/Selected Icon Dog.png',
      petImg: 'assets/images/Icon Dog.png',
    ),
    PetTypesModel(
      petType: 'Кролики',
      selectedPetImage: 'assets/images/selected Icon Rabbit.png',
      petImg: 'assets/images/Icon Rabbit.png',
    ),
    PetTypesModel(
      petType: 'Птицы',
      selectedPetImage: 'assets/images/selected Icon Bird.png',
      petImg: 'assets/images/Icon Bird.png',
    ),
    PetTypesModel(
      petType: 'Лошади',
      selectedPetImage: 'assets/images/selected Icon horse.png',
      petImg: 'assets/images/Icon horse.png',
    ),
    PetTypesModel(
      petType: 'Другие',
      selectedPetImage: 'assets/images/selected Icon Bird.png',
      petImg: 'assets/images/Icon Bird.png',
    ),
  ].obs;
  RxList<SearchCategories> searchCategories = [
    SearchCategories(
      activeColor: kGreenColor,
      title: 'Нашел питомца',
    ),
    SearchCategories(
      activeColor: kRedColor,
      title: 'Потерял питомца',
    ),
    SearchCategories(
      activeColor: kSkyBlueColor,
      title: 'Отдам в добрые руки',
    ),
    SearchCategories(
      activeColor: kSkyBlueColor,
      title: 'Отдам на передержку',
    ),
    SearchCategories(
      activeColor: kPurpleColor,
      title: 'Возьму на передержку',
    ),
    SearchCategories(
      activeColor: kSecondaryColor,
      title: 'Возьму в семью',
    ),
    SearchCategories(
      activeColor: kBrownColor,
      title: 'Могу погулять с питомцем',
    ),
    SearchCategories(
      activeColor: kYellowColor,
      title: 'Нужен выгул питомца ',
    ),
    SearchCategories(
      activeColor: kInputBorderColor,
      title: 'Услуги',
    ),
  ].obs;

  void selectedAnimal(var index) {
    currentIndex = index;
    update();
  }
}

class SearchCategories extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var activeColor, title;
  bool? isSelected;

  SearchCategories({
    this.activeColor,
    this.title,
    this.isSelected = false,
  });
}

class PetTypesModel {
  // ignore: prefer_typing_uninitialized_variables
  var petImg, selectedPetImage, petType;

  PetTypesModel({
    this.petImg,
    this.selectedPetImage,
    this.petType,
  });
}
