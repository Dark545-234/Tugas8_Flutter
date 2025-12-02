class ApiUrl {
  static const String baseUrl = 'http://localhost/toko-api/public';

  // AUTH
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';

  // PRODUK
  static const String listProduk = '$baseUrl/produk';
  static const String createProduk = '$baseUrl/produk';

  static String updateProduk(int id) => '$baseUrl/produk/$id';

  static String showProduk(int id) => '$baseUrl/produk/$id';

  static String deleteProduk(int id) => '$baseUrl/produk/$id';
}
