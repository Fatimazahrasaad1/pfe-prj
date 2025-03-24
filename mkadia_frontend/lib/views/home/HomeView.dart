import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/views/home/widget/AllProductsPage.dart';
import 'package:mkadia/views/home/widget/SearchLoc.dart';
import 'package:mkadia/views/home/widget/productCard.dart';
import 'package:mkadia/views/home/widget/promo.dart';
import 'package:mkadia/services/api_service.dart'; // Importe le service API

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentSlider = 0;
  int selectedIndex = 0;

  List<dynamic> products = [];
  List<dynamic> categories = [];
  List<dynamic> promotions = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

Future<void> fetchData() async {
    try {
      final productsData = await ApiService.fetchProducts();
      final categoriesData = await ApiService.fetchCategories();
      final promotionsData = await ApiService.fetchPromotions();
      setState(() {
        products = productsData;
        categories = categoriesData;
        promotions = promotionsData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
  List<List<dynamic>> selectedCategories = [
    products, 
    products.where((product) => product['category_id'] == 2).toList(), 
    products.where((product) => product['category_id'] == 3).toList(), 
    products.where((product) => product['category_id'] == 4).toList(), 
    products.where((product) => product['category_id'] == 5).toList(), 
  ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: TColor.primaryColor,
                elevation: 0,
                toolbarHeight: 160,
                title: const SearchLoc(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 110,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: selectedIndex == index
                                    ? Colors.amber
                                    : Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 68,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade300, width: 2),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        categories[index]['image_url'],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    categories[index]['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),


                  Promo(
                    currentSlide: currentSlider,
                    onChange: (value) {
                      setState(() {
                        currentSlider = value;
                      });
                    },
                    promotions: promotions, 
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Popular products",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductsPage(
                                products: selectedCategories[selectedIndex],
                                categoryName: categories[selectedIndex]['name'],
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "see all",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),

                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: selectedCategories[selectedIndex].take(8).length,
                    itemBuilder: (context, index) {
                      final product = selectedCategories[selectedIndex][index];
                      if (product['image_url'] == null || product['image_url'].isEmpty) {
                        return Placeholder(); // Ou un widget d'erreur
                      }
                      return ProductCard(product: product);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}