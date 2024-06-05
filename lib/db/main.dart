// ignore_for_file: camel_case_types, constant_identifier_names

enum Categoria {
  ELECTRONICA,
  LINEA_BLANCA,
  HOGAR,
  DEPORTES,
  MODA,
  JUGUETES,
  MASCOTAS,
}

class Producto {
  int id;
  String nombre;
  double precio;
  List<String> imagenes;
  String descripcion;
  int stock;
  double rating;
  Categoria categoria;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.imagenes,
    required this.descripcion,
    required this.stock,
    required this.rating,
    required this.categoria,
  });
}

class Usuario {
  String nombre;
  String email;
  String telefono;
  String direccion;
  String password;

  Usuario({
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.password,
  });
}

class ProductoConCantidad {
  Producto producto;
  int cantidad;
  bool seleccionado;

  ProductoConCantidad({
    required this.producto,
    required this.cantidad,
    this.seleccionado = true,
  });
}

class db {
  static List<Producto> get productos {
    return [
      Producto(
          id: 1,
          nombre: "Smartphone Samsung Galaxy S22 Ultra",
          precio: 1299.99,
          imagenes: [
            'lib/assets/samsung_s22.webp',
          ],
          descripcion:
              'El Samsung Galaxy S22 Ultra es el último smartphone de gama alta de Samsung, con una pantalla AMOLED de 6.8 pulgadas, cámara cuádruple de 108 MP, batería de larga duración y mucho más.',
          stock: 50,
          rating: 4.8,
          categoria: Categoria.ELECTRONICA),
      Producto(
          id: 2,
          nombre: "Laptop Dell XPS 15 9500",
          precio: 1999.99,
          imagenes: [
            'lib/assets/dell_xps.png',
          ],
          descripcion:
              'La Dell XPS 15 9500 es una laptop potente y elegante con procesador Intel Core i7 de 11ª generación, pantalla táctil 4K InfinityEdge, 16 GB de RAM y 1 TB de almacenamiento SSD.',
          stock: 20,
          rating: 4.9,
          categoria: Categoria.ELECTRONICA),
      Producto(
          id: 3,
          nombre: "Smart TV Sony Bravia XR A90J",
          precio: 2999.99,
          imagenes: [
            'lib/assets/sony_bravia.webp',
          ],
          descripcion:
              'El Smart TV Sony Bravia XR A90J ofrece una experiencia de visualización impresionante con tecnología OLED, resolución 4K, procesador Cognitive XR, compatibilidad con Dolby Vision y Atmos, y mucho más.',
          stock: 10,
          rating: 4.7,
          categoria: Categoria.ELECTRONICA),
      Producto(
          id: 4,
          nombre: "Cámara Canon EOS R5",
          precio: 3899.99,
          imagenes: [
            'lib/assets/canon_eos.png',
          ],
          descripcion:
              'La cámara Canon EOS R5 es una potente cámara mirrorless de fotograma completo con capacidad de grabación de video 8K, sensor CMOS de 45 MP, estabilización de imagen de 5 ejes y ráfaga de disparo de hasta 20 fps.',
          stock: 15,
          rating: 4.9,
          categoria: Categoria.ELECTRONICA),
      Producto(
          id: 5,
          nombre: "Auriculares Bose Noise Cancelling 700",
          precio: 379.99,
          imagenes: [
            'lib/assets/bose_noise.webp',
          ],
          descripcion:
              'Los auriculares Bose Noise Cancelling 700 ofrecen un audio excepcional y cancelación de ruido ajustable, con hasta 20 horas de autonomía, controles táctiles intuitivos y un diseño elegante y cómodo.',
          stock: 30,
          rating: 4.7,
          categoria: Categoria.ELECTRONICA),
      Producto(
          id: 6,
          nombre: "Robot aspirador iRobot Roomba i7+",
          precio: 799.99,
          imagenes: [
            'lib/assets/irobot.webp',
          ],
          descripcion:
              'El robot aspirador iRobot Roomba i7+ ofrece una limpieza automatizada de alta eficiencia con navegación inteligente, capacidad de autovaciado, mapeo de habitaciones y compatibilidad con asistentes de voz.',
          stock: 5,
          rating: 4.6,
          categoria: Categoria.HOGAR),
      Producto(
          id: 7,
          nombre: "Bicicleta de montaña Specialized Stumpjumper Comp Carbon 29",
          precio: 4499.99,
          imagenes: [
            'lib/assets/bici.png',
          ],
          descripcion:
              'La bicicleta de montaña Specialized Stumpjumper Comp Carbon 29 es una máquina de trail de alto rendimiento con cuadro de fibra de carbono FACT 11m, suspensión ajustable, transmisión SRAM Eagle y ruedas de 29 pulgadas.',
          stock: 8,
          rating: 4.8,
          categoria: Categoria.DEPORTES),
      Producto(
          id: 8,
          nombre: "Barra de sonido Sonos Arc",
          precio: 799.99,
          imagenes: [
            'lib/assets/sonos.webp',
          ],
          descripcion:
              'La barra de sonido Sonos Arc ofrece un sonido envolvente impresionante para tu cine en casa, con soporte para Dolby Atmos, asistentes de voz integrados, conexión HDMI e integración perfecta con otros dispositivos Sonos.',
          stock: 12,
          rating: 4.7,
          categoria: Categoria.ELECTRONICA),
      Producto(
          id: 9,
          nombre: "Mochila North Face Borealis",
          precio: 89.99,
          imagenes: [
            'lib/assets/noth.webp',
          ],
          descripcion:
              'La mochila North Face Borealis es perfecta para aventuras al aire libre o para el día a día en la ciudad, con compartimentos organizativos, panel trasero acolchado, correas ajustables y resistencia al agua.',
          stock: 25,
          rating: 4.6,
          categoria: Categoria.DEPORTES),
      Producto(
          id: 10,
          nombre: "Impresora 3D Creality Ender 3 V2",
          precio: 299.99,
          imagenes: [
            'lib/assets/impresora_3d.png',
          ],
          descripcion:
              'La impresora 3D Creality Ender 3 V2 es una opción excelente para entusiastas de la impresión 3D, con una gran área de construcción, extrusor de calidad, pantalla táctil a color y compatibilidad con una amplia gama de materiales.',
          stock: 18,
          rating: 4.8,
          categoria: Categoria.ELECTRONICA),
    ];
  }

  static List<Categoria> get categorias {
    return Categoria.values;
  }

  static List<Usuario> usuarios = [];

  static Usuario? sesion;

  static void setSession(Usuario usuario) {
    db.sesion = usuario;
  }

  static void logout() {
    db.sesion = null;
  }

  static void addUsuario(Usuario usuario) {
    db.usuarios.add(usuario);
  }

  static Usuario checkUser(String email) {
    return db.usuarios.firstWhere((usuario) => usuario.email == email);
  }

  static bool login(String email, String password) {
    return db.usuarios.any(
        (usuario) => usuario.email == email && usuario.password == password);
  }

  static isLogged() {
    return db.sesion != null;
  }

  static Producto getProductById(int id) {
    return productos.firstWhere((producto) => producto.id == id);
  }

  static List<Producto> getProductsByCategory(Categoria categoria) {
    return productos
        .where((producto) => producto.categoria == categoria)
        .toList();
  }

  static List<Producto> getProductsBySearch(String query) {
    return productos
        .where((producto) =>
            producto.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static List<Producto> getProductsByPriceRange(double min, double max) {
    return productos
        .where((producto) => producto.precio >= min && producto.precio <= max)
        .toList();
  }

  static List<Producto> getProductsByRating(double rating) {
    return productos.where((producto) => producto.rating >= rating).toList();
  }
}

class carrito {
  static List<ProductoConCantidad> productos = [];

  static void agregarProducto(Producto producto, int cantidad) {
    final index = productos.indexWhere((p) => p.producto.id == producto.id);

    if (index != -1) {
      productos[index].cantidad += cantidad;
    } else {
      productos
          .add(ProductoConCantidad(producto: producto, cantidad: cantidad));
    }
  }

  static void eliminarProducto(int id) {
    productos.removeWhere((producto) => producto.producto.id == id);
  }

  static void vaciarCarrito() {
    productos.clear();
  }

  static double get total {
    return productos.fold(
        0,
        (total, producto) =>
            total + producto.producto.precio * producto.cantidad);
  }
}
