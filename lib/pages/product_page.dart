import 'package:amazon_fake/db/main.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Producto producto;

  const ProductPage({super.key, required this.producto});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  late int cantidad = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      body: SizedBox(
        // LA IMAGEN SE EXTIENDE A LO LARGO DE LA PANTALLA SOBRE EL APPBAR
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // IMAGEN
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: PageView.builder(
                      itemCount: widget.producto.imagenes.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          widget.producto.imagenes[index],
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                  // DETALLES
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NOMBRE
                        Text(
                          widget.producto.nombre,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // RATING
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // RATING

                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[500]!, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Color(0xFF96d1c7),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.producto.rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    '117 reviews',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // CANTIDAD
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              builder: (context) {
                                return SizedBox(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Cantidad',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  cantidad = index + 1;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: index + 1 == cantidad
                                                      ? Colors.grey[100]
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .hoverColor),
                                                ),
                                                child: Text(
                                                  '${index + 1} Unidad${index + 1 > 1 ? 'es' : ''}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        index + 1 == cantidad
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Cantidad: $cantidad (${widget.producto.stock} disponibles)',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // PRECIO Y DESCRIPCION
                        Text(
                          '\$${widget.producto.precio}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.producto.descripcion,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        var producto = widget.producto;

                        carrito.agregarProducto(producto, cantidad);

                        // BOTTOM SEET DE PRODUCTO AGREGADO AL CARRITO Y OPCION DE IR AL CARRITO O CONTINUAR COMPRANDO
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Producto agregado al carrito',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            producto.nombre,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Cantidad: $cantidad',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          leading: Image.asset(
                                            producto.imagenes[0],
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, '/checkout');
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          child: const Text("Ir al carrito",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                          ),
                                          child: const Text("Seguir comprando",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                      ),
                      child: const Text("Agregar al carrito",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        var producto = widget.producto;

                        carrito.agregarProducto(producto, cantidad);

                        Navigator.pushNamed(context, '/checkout');
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text("Comprar ahora",
                          style: TextStyle(color: Colors.white)),
                    ),
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
