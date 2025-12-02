import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  const ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    final produk = widget.produk!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kode : ${produk.kodeProduk}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Nama : ${produk.namaProduk}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Harga : Rp ${produk.hargaProduk}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            _tombolAksi(produk),
          ],
        ),
      ),
    );
  }

  /// Tombol Edit & Delete
  Widget _tombolAksi(Produk produk) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: produk),
              ),
            );
          },
        ),

        const SizedBox(width: 10),

        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => _confirmHapus(produk),
        ),
      ],
    );
  }

  /// Dialog Konfirmasi Hapus
  void _confirmHapus(Produk produk) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol YA
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            ProdukBloc.deleteProduk(id: int.parse(produk.id!)).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProdukPage()),
              );
            }, onError: (_) {
              showDialog(
                context: context,
                builder: (_) => const WarningDialog(
                  description: "Hapus gagal, silahkan coba lagi",
                ),
              );
            });
          },
        ),

        // Tombol BATAL
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }
}
