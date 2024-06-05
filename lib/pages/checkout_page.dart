import 'package:amazon_fake/db/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  late List<ProductoConCantidad> items = carrito.productos;
  List<ProductoConCantidad> selectedItems = carrito.productos;

  void updateItemSelection(int index, bool value) {
    setState(() {
      items[index].seleccionado = value;
      if (value) {
        selectedItems.add(items[index]);
      } else {
        selectedItems.remove(items[index]);
      }
    });
  }

  void incrementQuantity(int index) {
    setState(() {
      items[index].cantidad++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (items[index].cantidad > 0) {
        items[index].cantidad--;
      }
    });
  }

  void deleteSelectedItems() {
    if (selectedItems.isNotEmpty) {
      showConfirmationDialog();
    }
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar los elementos seleccionados?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  items.removeWhere((item) => item.seleccionado);
                  selectedItems.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var dias = {
      1: 'Lunes',
      2: 'Martes',
      3: 'Miércoles',
      4: 'Jueves',
      5: 'Viernes',
      6: 'Sábado',
      7: 'Domingo',
    };

    var mes = {
      1: 'enero',
      2: 'febrero',
      3: 'marzo',
      4: 'abril',
      5: 'mayo',
      6: 'junio',
      7: 'julio',
      8: 'agosto',
      9: 'septiembre',
      10: 'octubre',
      11: 'noviembre',
      12: 'diciembre',
    };

    var fechaEntrega = DateTime.now().add(const Duration(days: 3));
    // example: Domingo 19 de mayo
    var fechaEntregaString =
        '${dias[fechaEntrega.weekday]} ${fechaEntrega.day} de ${mes[fechaEntrega.month]}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito',
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: deleteSelectedItems,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (selectedItems.isNotEmpty)
                Text(
                  '${selectedItems.length} ${selectedItems.length == 1 ? 'elemento seleccionado' : 'elementos seleccionados'}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CheckoutItemRow(
                      item: items[index],
                      onSelectionChanged: (value) =>
                          updateItemSelection(index, value!),
                      onIncrement: () => incrementQuantity(index),
                      onDecrement: () => decrementQuantity(index),
                      onDelete: () => deleteItem(index),
                    );
                  },
                ),
              ),

              // datos de envio

              // Total
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${carrito.total.toStringAsFixed(2)} MXN',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // datos de envio recuperados de la sesion

              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Datos de envío'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nombre: ${db.sesion!.nombre}'),
                          Text('Dirección: ${db.sesion!.direccion}'),
                          Text('Teléfono: ${db.sesion!.telefono}'),
                          // tiempo estimado de entrega hoy + 3 dias
                          Text(
                              'Fecha de entrega estimada: $fechaEntregaString'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Checkout button
              MaterialButton(
                onPressed: () {
                  // modal de finalizacion de compra
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Compra finalizada'),
                        content: const Text(
                            '¡Gracias por tu compra! Recibirás un correo con los detalles de tu pedido.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              carrito.vaciarCarrito();
                              Navigator.pushNamed(context, '/');
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                minWidth: double.infinity,
                height: 50,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Finalizar compra',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutItemRow extends StatelessWidget {
  final ProductoConCantidad item;
  final ValueChanged<bool?> onSelectionChanged;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CheckoutItemRow({
    super.key,
    required this.item,
    required this.onSelectionChanged,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProductCheckbox(
            value: item.seleccionado,
            onChanged: onSelectionChanged,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductImage(imagePath: item.producto.imagenes[0]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        item.producto.nombre,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('\$${item.producto.precio} MXN'),
                    QuantityButtons(
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                      quantity: item.cantidad,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imagePath;

  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 50,
      height: 50,
    );
  }
}

class ProductCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const ProductCheckbox({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF96d1c7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: Color(0xFF96d1c7)),
      ),
      checkColor: Colors.white,
      tristate: false,
    );
  }
}

class QuantityButtons extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int quantity;

  const QuantityButtons({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          color: Colors.black,
          onPressed: onDecrement,
        ),
        Text('$quantity',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.black,
          onPressed: onIncrement,
        ),
      ],
    );
  }
}
