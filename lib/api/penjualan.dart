import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '/model/penjualan.dart';

class ApiPenjualan {
  final baseUrl = "http://172.20.10.3:8000/";

  Future<List<Penjualan>> apiTransaksi() async {
    final _urlTransaksi = Uri.parse(
      "${baseUrl}api/transaksi-users",
    );
    List<Penjualan> listPenjualan = [];
    try {
      var response = await http.get(_urlTransaksi);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        var data = jsonResponse['transaksi'] as List;
        print('$data');
        listPenjualan = data
            .map(
              (e) => Penjualan(
                id: e['id'],
                deskripsi: e['deskripsi'],
                gambar: baseUrl + "assets/image/" + e['gambar'],
                harga: e['harga'],
                stok: e['stock'],
                nama: e['nama'],
              ),
            )
            .toList();
        print(listPenjualan);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
    return listPenjualan;
  }
}
