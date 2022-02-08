import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PetController extends GetxController {
  List<String> gender = [
    'male_title',
    'female_title',
  ];
  List<String> petTypes = [
    'cat_title',
    'dog_title',
    'rabbit_title',
    'bird_title',
    'horse_title',
    'other_title',
  ];
  List<String> ages = [
    'adult_title',
    'little_title',
  ];

  RxString selectedGender = 'gender_title'.obs;
  RxString selectedAnimal = 'type_title'.obs;
  RxString adType = ''.obs;
  RxString age = 'age_title'.obs;

  XFile? _image;

  XFile? get image => _image;
  RxString status = "".obs;

  final CollectionReference<Map<String, dynamic>> _petRef = FirebaseFirestore.instance.collection("pets");

  void selectGender(int index) => selectedGender.value = gender[index];
  void selectType(int index) => selectedAnimal.value = petTypes[index];
  void selectAge(int index) => age.value = ages[index];

  void getImage(bool fromCamera) async {
    final ImagePicker _picker = ImagePicker();
    if (fromCamera) {
      _image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      _image = await _picker.pickImage(source: ImageSource.gallery);
    }
    update();
  }
}
