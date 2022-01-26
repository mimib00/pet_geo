class PetsModel {
  // ignore: prefer_typing_uninitialized_variables
  var petImage, title, subtitle;
  bool? bookMarked;

  PetsModel({
    this.title,
    this.subtitle,
    this.petImage,
    this.bookMarked = false,
  });
}
