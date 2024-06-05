import 'package:flutter/material.dart';
import 'package:amazon_fake/db/main.dart';
import 'package:amazon_fake/pages/product_page.dart';

// ignore: must_be_immutable
class ResultsPage extends StatelessWidget {
  String? search;
  Categoria? categoria;

  ResultsPage({super.key, this.search, this.categoria});

  @override
  Widget build(BuildContext context) {
    var placeholder =
        search != null ? 'Resultados para $search' : categoria!.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(placeholder),
      ),
      body: ProductGrid(search: search, categoria: categoria),
    );
  }
}

// ignore: must_be_immutable
class ProductGrid extends StatelessWidget {
  String? search;
  Categoria? categoria;

  ProductGrid({super.key, this.search, this.categoria});

  @override
  Widget build(BuildContext context) {
    // filtrar productos por busqueda o categoria dependiendo de cual no sea null
    List<Producto> filteredProducts = db.productos.where((producto) {
      if (search != null) {
        return producto.nombre.toLowerCase().contains(search!.toLowerCase());
      } else {
        return producto.categoria == categoria;
      }
    }).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductItem(producto: filteredProducts[index]);
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Producto producto;

  const ProductItem({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(producto: producto),
          ),
        );
      },
      child: SizedBox(
        child: Column(
          children: [
            ProductImage(imagePath: producto.imagenes[0]),
            const SizedBox(height: 5),
            ProductDetails(producto: producto),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imagePath;

  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFf0f1f2),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        height: 150,
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final Producto producto;

  const ProductDetails({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            producto.nombre,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '\$${producto.precio}',
            style: const TextStyle(
              fontSize: 18,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
