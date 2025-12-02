import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _emailTextField(),
              _passwordTextField(),
              const SizedBox(height: 20),
              _buttonLogin(),
              const SizedBox(height: 30),
              _menuRegistrasi(),
            ],
          ),
        ),
      ),
    );
  }

  /// TextField Email
  Widget _emailTextField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: "Email"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email harus diisi";
        }
        return null;
      },
    );
  }

  /// TextField Password
  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(labelText: "Password"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  /// Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
      onPressed: () {
        final valid = _formKey.currentState!.validate();
        if (valid && !_isLoading) {
          _submit();
        }
      },
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Login"),
    );
  }

  /// Submit login ke API
  void _submit() {
    setState(() => _isLoading = true);

    LoginBloc.login(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(value.userID!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProdukPage()),
        );
      } else {
        _showError("Login gagal, silahkan coba lagi");
      }
    }).catchError((error) {
      _showError("Login gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  /// Menampilkan dialog error
  void _showError(String pesan) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WarningDialog(description: pesan),
    );
  }

  /// Menu ke halaman Registrasi
  Widget _menuRegistrasi() {
    return InkWell(
      child: const Text(
        "Registrasi",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegistrasiPage()),
        );
      },
    );
  }
}
