import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc/auth_bloc_bloc.dart';
import '../blocs/product/bloc/product_bloc_bloc.dart';
import '../widgets/custom_searchbutton.dart';
import '../widgets/product_card.dart';
import 'login_screen.dart';
import 'productdetailpage.dart';
import 'user_profile.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
 
  static const String iimage =
      'https://media.istockphoto.com/id/1021908014/photo/word-writing-text-free-sample-business-concept-for-portion-of-products-given-to-consumers-in.webp?s=2048x2048&w=is&k=20&c=DJ_ISzjoE0CseFdjdEheJ62XtPllJx0tR_reNV3yOFw=';

  final List<Map<String, dynamic>> defaultProducts = [
    {
      'title': 'COSRX Vitamin C 13 Serum',
      'thumbnail': iimage,
      'price': 1200.00,
      'description': 'A revitalizing serum designed to illuminate your skin.',
      'detailPage': const ProductDetailPage(
        title: 'COSRX Vitamin C 13 Serum',
        description: 'Full product description here...',
        price: 1200.00,
        thumbnail: iimage,
      ),
    },
    {
      'title': 'Product 2',
      'thumbnail': iimage,
      'price': 800.00,
      'description': 'This is another product.',
      'detailPage': const ProductDetailPage(
        title: 'Product 2',
        description: 'Full description here...',
        price: 800.00,
        thumbnail: iimage,
      ),
    },
  ];

  @override
  void initState() {
    super.initState();
    context
        .read<ProductBlocBloc>()
        .add(const FetchAllProductBlocEvent(limit: 50));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
      
              context.read<AuthBlocBloc>().add(LogoutRequested());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, 
              );
            },
            icon: const Icon(Icons.logout),
          ),
          BlocBuilder<ProductBlocBloc, ProductBlocState>(
            builder: (context, state) {
              if (state is AllProductBlocLoded) {
                final products = state.product;
                return IconButton(
                  onPressed: () {
                   
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(products: products),
                    );
                  },
                  icon: const Icon(Icons.search),
                );
              } else {
               
                return const SizedBox.shrink();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle), 
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductBlocBloc, ProductBlocState>(
        listener: (context, state) {
         
        },
        builder: (context, state) {
          
          if (state is ProductBlocLoding) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AllProductBlocLoded) {
            final products = state.product;
            if (products.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProductBlocBloc>()
                      .add(const FetchAllProductBlocEvent(limit: 2));
                },
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      title: product.title,
                      thumbnail: iimage,
                      price: product.price,
                      description: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              title: product.title,
                              description: product.description,
                              price: product.price,
                              thumbnail: iimage,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
