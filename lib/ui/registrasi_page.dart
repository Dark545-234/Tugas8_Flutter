import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _konfirmasiTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaTextField(),
                _emailTextField(),
                _passwordTextField(),
                _passwordKonfirmasiTextField(),
                const SizedBox(height: 20),
                _buttonRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TextField Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      controller: _namaTextboxController,
      validator: (value) {
        if (value == null || value.length < 3) {
          return "Nama minimal 3 karakter";
        }
        return null;
      },
    );
  }

  // TextField Email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }

        // Validasi email RegEx
        final regex = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
            r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }

        return null;
      },
    );
  }

  // TextField Password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Password minimal 6 karakter";
        }
        return null;
      },
    );
  }

  // TextField Konfirmasi Password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Konfirmasi Password"),
      obscureText: true,
      controller: _konfirmasiTextboxController,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi password tidak sama";
        }
        return null;
      },
    );
  }

  // Tombol Registrasi
  Widget _buttonRegistrasi() {
    return ElevatedButton(
      onPressed: _isLoading ? null : () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });

          // TODO: panggil API registrasi di sini
          // Setelah selesai:
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Registrasi"),
    );
  }
}
