import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:taskk/mlodel/MainResponse.dart';
import 'package:taskk/productprovider.dart';

import 'mlodel/Products.dart';

// Provider class to manage product data

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProducts(1),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the UI is initialized
    Provider.of<ProductProvider>(context, listen: false).fetchProducts(1);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: GridView.builder(
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return Container(
            height: 210,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  right:10,
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   width: 1,
                      // ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                          child: Image.network('${product.image}', fit: BoxFit.fitWidth,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                                                );
                                              }),
                        ),
                  ),
                ),
                Positioned(
                  top: 140,
                    left: 10,
                    child: Text('${product!.title}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),maxLines: 1,)),
                Positioned(
                    top: 156,
                    left: 10,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children:  <TextSpan>[

                          TextSpan(text: 'Type:',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 12),),
                          TextSpan(text: ' ${product!.type}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),)

                        ],
                      ),
                    )
                   ),
                Positioned(
                    top: 172,
                    left: 10,
                    child: Text('Rs.${product!.price}',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 12),maxLines: 1,)),
              ],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
      ),
    );
  }
}
