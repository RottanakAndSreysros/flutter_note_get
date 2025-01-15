import 'package:flutter/material.dart';
import 'package:flutter_note_get/presentation/screen/home/home/home_screen.dart';
import 'package:flutter_note_get/presentation/screen/note/note/note_screen.dart';
import 'package:get/get.dart';

class LandingScreenController extends GetxController {
  RxList<Widget> listScreen = <Widget>[
    HomeScreen(),
    NoteScreen(),
  ].obs;
}
