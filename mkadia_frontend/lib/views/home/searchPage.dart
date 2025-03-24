import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:mkadia/provider/searchProvider.dart';
import 'package:mkadia/views/cart/cart.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/views/detail/detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.clear();

    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.clearSearchResults();
  }

  @override
  void dispose() {
    _searchController.dispose();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.clearSearchResults(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              height: 160, 
              color: TColor.primaryText, 
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 24),),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search in Mkadia',
                              hintStyle: TextStyle(color: TColor.placeholder),
                              prefixIcon: const Icon(Icons.search, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              searchProvider.searchProducts(value);
                            },
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                searchProvider.addSearchTerm(value);
                              }
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Stack(
                          children: [
                            const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 38),
                            if (finalList.isNotEmpty)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(0.25),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 15,
                                    minHeight: 15,
                                  ),
                                  child: Text(
                                    finalList.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Cart()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          if (searchProvider.isLoading)
            const Center(child: CircularProgressIndicator())
            
          else if (searchProvider.searchResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: searchProvider.searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchProvider.searchResults[index];
                  return ListTile(
                    leading: product['image_url'] != null 
                      ? Image.network(product['image_url'], width: 50, height: 50)
                      : const Icon(Icons.image, size: 50),
                    title: Text(product['name'] ?? 'Unnamed Product'),
                    subtitle: Text('\$${product['price'] ?? '0.00'}'),
                    onTap: () {
                      // Ajouter le terme de recherche à l'historique
                      searchProvider.addSearchTerm(_searchController.text);

                      final productId = int.tryParse(product['id'].toString());
                      if (productId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(productId: productId),
                          ),
                        );
                      } else {
                        print('Invalid product ID');
                      }
                    },
                  );
                },
              ),
            )
          
          // Historique de recherche
          else if (_searchController.text.isEmpty && searchProvider.searchHistory.isNotEmpty)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Searches',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TColor.primaryText,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            searchProvider.clearSearchHistory();
                          },
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: searchProvider.searchHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.history, color: Colors.grey),
                          title: Text(searchProvider.searchHistory[index]),
                          trailing: const Icon(Icons.north_east, size: 16),
                          onTap: () {
                            _searchController.text = searchProvider.searchHistory[index];
                            searchProvider.searchProducts(_searchController.text);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search for items',
                      style: TextStyle(
                        fontSize: 18,
                        color: TColor.placeholder,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}