import 'package:amazon_fake/db/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fieldDecoration = BoxDecoration(
        //border: Border.all(color: Colors.grey),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Fake Amazon",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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

            CupertinoTextField(
              obscureText: true,
              controller: _passwordController,
              placeholder: 'Contraseña',
              placeholderStyle: TextStyle(color: Colors.grey.shade700),
              keyboardType: TextInputType.emailAddress,
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

                if (email.isEmpty || password.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content:
                            const Text('Por favor, llena todos los campos'),
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
                  var usuario = db.checkUser(email);
                  db.setSession(usuario);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Usuario registrado correctamente'),
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
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'No tienes una cuenta?, dale click aqui',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      )),
    );
  }
}
