import 'package:amazon_fake/db/main.dart';
import 'package:amazon_fake/pages/results_page.dart';
import 'package:amazon_fake/widgets/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (db.isLogged())
                      Text("Hola ${db.sesion!.nombre}!",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const CategorySlider(),
                    const Flexible(child: ProductList())
                  ],
                ))));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          const Expanded(flex: 7, child: CupertinoSearchField()),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    db.logout();
                    Navigator.pushNamed(context, "/login");
                  },
                  icon: const Icon(Icons.exit_to_app_rounded)))
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }
}

class CupertinoSearchField extends StatelessWidget {
  const CupertinoSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      placeholder: 'Search',
      padding: const EdgeInsets.all(8.0),
      prefixIcon: const Icon(Icons.search_rounded),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      onSubmitted: (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(search: value),
          ),
        );
      },
    );
  }
}

//

class CategorySlider extends StatelessWidget {
  const CategorySlider({super.key});

  @override
  Widget build(BuildContext context) {
    // db.categorias
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: db.categorias.length,
        itemBuilder: (context, index) {
          return CategoryItem(categoria: db.categorias[index]);
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Categoria categoria;

  const CategoryItem({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    // categoria en un circulo con un emoji de la categoria

    var categoriaStr = categoria.toString();
    var titulo = categoriaStr
        .replaceAll("Categoria.", "")
        .replaceAll("_", " ")
        .toLowerCase();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(categoria: categoria),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 80,
            height: 80,
            child: Icon(Icons.category_rounded),
          ),
          Text(
            titulo,
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
