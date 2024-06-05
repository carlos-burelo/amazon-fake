import 'package:amazon_fake/db/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fieldDecoration = BoxDecoration(
        color: Colors.grey[200], borderRadius: BorderRadius.circular(5));

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Fake Amazon",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                // Email
                CupertinoTextField(
                  controller: _emailController,
                  placeholder: 'Correo',
                  placeholderStyle: TextStyle(color: Colors.grey.shade700),
                  keyboardType: TextInputType.emailAddress,
                  padding: const EdgeInsets.all(10),
                  decoration: fieldDecoration,
                  autocorrect: true,
                  enableSuggestions: true,
                ),
                const SizedBox(height: 10),

                // Password
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: 'Contraseña',
                  placeholderStyle: TextStyle(color: Colors.grey.shade700),
                  padding: const EdgeInsets.all(10),
                  decoration: fieldDecoration,
                  obscureText: true,
                  autocorrect: true,
                  enableSuggestions: true,
                ),

                const SizedBox(height: 10),

                // REPETIR PASSWORD
                CupertinoTextField(
                  controller: _repeatPasswordController,
                  placeholder: 'Repetir contraseña',
                  placeholderStyle: TextStyle(color: Colors.grey.shade700),
                  padding: const EdgeInsets.all(10),
                  decoration: fieldDecoration,
                  obscureText: true,
                  autocorrect: true,
                  enableSuggestions: true,
                ),

                const SizedBox(height: 10),

                // Name
                CupertinoTextField(
                  controller: _nameController,
                  placeholder: 'Nombre',
                  placeholderStyle: TextStyle(color: Colors.grey.shade700),
                  padding: const EdgeInsets.all(10),
                  decoration: fieldDecoration,
                  autocorrect: true,
                  enableSuggestions: true,
                ),

                const SizedBox(height: 10),

                // Phone

                CupertinoTextField(
                  controller: _phoneController,
                  placeholder: 'Telefono',
                  placeholderStyle: TextStyle(color: Colors.grey.shade700),
                  keyboardType: TextInputType.phone,
                  padding: const EdgeInsets.all(10),
                  decoration: fieldDecoration,
                  autocorrect: true,
                  enableSuggestions: true,
                ),

                const SizedBox(height: 10),

                // Address

                CupertinoTextField(
                  controller: _addressController,
                  placeholder: 'Dirección',
                  placeholderStyle: TextStyle(color: Colors.grey.shade700),
                  padding: const EdgeInsets.all(10),
                  decoration: fieldDecoration,
                  autocorrect: true,
                  enableSuggestions: true,
                ),

                const SizedBox(height: 10),

                CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text('Registrarse',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final repeatPassword = _repeatPasswordController.text;
                    final name = _nameController.text;
                    final phone = _phoneController.text;
                    final address = _addressController.text;

                    if (email.isEmpty ||
                        password.isEmpty ||
                        repeatPassword.isEmpty ||
                        name.isEmpty ||
                        phone.isEmpty ||
                        address.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content:
                                const Text('Todos los campos son requeridos'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        },
                      );
                    } else if (password != repeatPassword) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Las contraseñas no coinciden'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      var usuario = Usuario(
                        email: email,
                        password: password,
                        nombre: name,
                        telefono: phone,
                        direccion: address,
                      );
                      db.addUsuario(usuario);
                      db.setSession(usuario);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Success'),
                            content:
                                const Text('Usuario registrado correctamente'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),

                // login
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Ya tienes una cuenta?, dale click aqui',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ));
  }
}
