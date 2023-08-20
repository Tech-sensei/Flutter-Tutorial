import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSize = 0;

  @override
  void initState() {
    super.initState();
    selectedSize = (widget.product['sizes'] as List<int>).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Product\'s Details',
          style: Theme.of(context).textTheme.titleMedium,
        )),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '\$${widget.product['price']}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            label: Text(size.toString()),
                            labelStyle: size == selectedSize
                                ? const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )
                                : null,
                            backgroundColor: size == selectedSize
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add to cart',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
