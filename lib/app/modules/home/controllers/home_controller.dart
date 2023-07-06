import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';

class HomeController extends GetxController {
  final authC = AuthController.instance;
  final customSearchDelegate = CustomSearch.instance;
}

class CustomSearch extends SearchDelegate {
  static CustomSearch get instance => CustomSearch();
  @override
  List<Widget>? buildActions(BuildContext context) {
    // ini untuk tombol yang ada disebelah kanan search
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search_off),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // ini untuk tombol yang ada di sebelah kiri
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Ini untuk memunculkan hasil pencarian saat tombol enter ditekan
    return ListTile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Ini untuk memunculkan hasil saran pencarian saat kolom teks diisi
    return ListTile();
  }
}
