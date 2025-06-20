import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dosen.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.100.213:8000/api/dosen'; // ganti sesuai IP kamu

  static Future<List<Dosen>> getDosen() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => Dosen.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  static Future<bool> tambahDosen(Dosen dosen) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: dosen.toJson(),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateDosen(int no, Dosen dosen) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$no'),
      body: dosen.toJson(),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteDosen(int no) async {
    final response = await http.delete(Uri.parse('$baseUrl/$no'));
    return response.statusCode == 200;
  }
}
