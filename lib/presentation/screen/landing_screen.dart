import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/controller/landing_screen_controller.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  final controller = Get.put(LandingScreenController());
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return controller.listScreen[_selectedIndex.value];
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.folder),
                label: "Book",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_document),
                label: "Note",
              ),
            ],
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex.value,
            onTap: (value) {
              _selectedIndex.value = value;
            },
          );
        },
      ),
    );
  }
}
