
class Category {
  final String name;
  final String image;

  Category({
    required this.name,
    required this.image,
  });
}

final List<Category> categories = [
  
  Category(
    name:"All",
    image:"assets/img/grid.png"
  ),
  Category(
    name:"Fruit",
    image:"assets/img/fruits.png"
  ),
  Category(
    name:"Vegetable",
    image:"assets/img/vegetable.png"
  ),
  Category(
    name:"Milk & Egg",
    image:"assets/img/milkegg.png"
  ),
  Category(
    name:"Meat",
    image:"assets/img/meat.png"
  ),
];