class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categoriesList = [
  Category(
    title: "Mobile",
    image: "http://devapiv4.dealsdray.com/icons/cat_mobile.png",
  ),
  Category(
    title: "Laptop",
    image: "http://devapiv4.dealsdray.com/icons/cat_lap.png",
  ),
  Category(
    title: "Camera",
    image: "http://devapiv4.dealsdray.com/icons/cat_camera.png",
  ),
  Category(
    title: "LED",
    image: "http://devapiv4.dealsdray.com/icons/cat_led.png",
  ),
];
