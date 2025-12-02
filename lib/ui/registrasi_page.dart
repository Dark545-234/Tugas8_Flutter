import 'package:flutter/material.dart';
import 'package:tokokita/bloc/registrasi_bloc.dart';
import 'package:tokokita/widget/success_dialog.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrasi")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _namaTextField(),
              _emailTextField(),
              _passwordTextField(),
              _passwordKonfirmasiTextField(),
              const SizedBox(height: 16),
              _buttonRegistrasi(),
            ],
          ),
        ),
      ),
    );
  }

  // TextField Nama
  Widget _namaTextField() {
    return TextFormField(
      controller: _namaController,
      decoration: const InputDecoration(labelText: "Nama"),
      validator: (value) {
        if (value == null || value.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  // TextField Email
  Widget _emailTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email harus diisi";
        }

        final regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
          r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
          r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        );

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
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(labelText: "Password"),
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
      obscureText: true,
      decoration: const InputDecoration(labelText: "Konfirmasi Password"),
      validator: (value) {
        if (value != _passwordController.text) {
          return "Konfirmasi password tidak sama";
        }
        return null;
      },
    );
  }

  /// Tombol Registrasi
  Widget _buttonRegistrasi() {
    return ElevatedButton(
      onPressed: () {
        final isValid = _formKey.currentState!.validate();
        if (isValid && !_isLoading) {
          _submit();
        }
      },
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Registrasi"),
    );
  }

  /// Submit ke API
  void _submit() {
    setState(() => _isLoading = true);

    RegistrasiBloc.registrasi(
      nama: _namaController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          description: "Registrasi berhasil, silahkan login",
          okClick: () {
            Navigator.pop(context);
          },
        ),
      );
    }).catchError((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const WarningDialog(
          description: "Registrasi gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }
}
