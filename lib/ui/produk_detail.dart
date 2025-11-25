import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  final Produk produk;

  const ProdukDetail({Key? key, required this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Diky'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kode : ${widget.produk.kodeProduk}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                "Nama : ${widget.produk.namaProduk}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                "Harga : Rp ${widget.produk.hargaProduk.toString()}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
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
                builder: (context) =>
                    ProdukForm(produk: widget.produk),
              ),
            );
          },
        ),

        const SizedBox(width: 20),

        // Tombol Delete
        OutlinedButton(
          child: const Text("DELETE", style: TextStyle(color: Colors.red)),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Dialog konfirmasi hapus
  void confirmHapus() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Yakin ingin menghapus produk ini?"),
          actions: [
            // Tombol Ya
            OutlinedButton(
              child: const Text("Ya"),
              onPressed: () {
                // TODO: Ganti ini dengan API hapus produk.
                Navigator.pop(context); // tutup dialog
                Navigator.pop(context); // kembali ke list
              },
            ),

            // Tombol Batal
            OutlinedButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
