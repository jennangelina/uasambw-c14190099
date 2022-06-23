import 'package:http/http.dart' as http;
import 'dataclass.dart';
import 'dart:convert';

class Service {
  Future<List<cBerita>> getAllData() async {
    final response = await http.get(
        Uri.parse('https://api-berita-indonesia.vercel.app/cnbc/terbaru/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final listData = data['data']['posts'];
      List<cBerita> berita =
          listData.map<cBerita>((json) => cBerita.fromJson(json)).toList();
      return listData.map<cBerita>((json) => cBerita.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<cBerita> getDetailData(String id) async {
    final response = await http.get(Uri.parse(
        'https://6283762138279cef71d77f41.mockapi.io/api/v1/data2/$id'));

    if (response.statusCode == 200) {
      cBerita jsonResponse = cBerita.fromJson(jsonDecode(response.body));
      return jsonResponse;
    } else {
      throw Exception('Failed to get single data');
    }
  }
}
