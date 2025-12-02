import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  // ============================
  // GET LIST PRODUK
  // ============================
  static Future<List<Produk>> getProduks() async {
    final String apiUrl = ApiUrl.listProduk;

    final response = await Api().get(apiUrl);
    final jsonObj = json.decode(response.body);

    final List<dynamic> listProduk = jsonObj['data'];

    return listProduk.map((item) => Produk.fromJson(item)).toList();
  }

  // ============================
  // ADD PRODUK
  // ============================
  static Future<bool> addProduk({required Produk produk}) async {
    final String apiUrl = ApiUrl.createProduk;

    final body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    final response = await Api().post(apiUrl, body);
    final jsonObj = json.decode(response.body);

    return jsonObj['status'];
  }

  // ============================
  // UPDATE PRODUK
  // ============================
  static Future<bool> updateProduk({required Produk produk}) async {
    final String apiUrl = ApiUrl.updateProduk(int.parse(produk.id!));

    final body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    final response = await Api().put(apiUrl, jsonEncode(body));
    final jsonObj = json.decode(response.body);

    return jsonObj['status'];
  }

  // ============================
  // DELETE PRODUK
  // ============================
  static Future<bool> deleteProduk({required int id}) async {
    final String apiUrl = ApiUrl.deleteProduk(id);

    final response = await Api().delete(apiUrl);
    final jsonObj = json.decode(response.body);

    return jsonObj['data'];
  }
}
