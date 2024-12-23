import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/controller/database_controller.dart';
import 'package:flutter_note_get/core/data/model/text_note_model.dart';
import 'package:flutter_note_get/presentation/screen/home/home_screen.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TakeNoteScreen extends StatelessWidget {
  TakeNoteScreen({super.key, this.model});

  TextNoteModel? model;
  final controller = Get.put(DatabaseController());
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () {
            Get.off(HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32,
          ),
        ),
        centerTitle: true,
        title: model != null
            ? const Text(
                "Edit note",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text(
                "Save note",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () async {
              final title = _title.text.obs;
              final description = _description.text.obs;
              final date = DateTime.now();
              // ignore: no_leading_underscores_for_local_identifiers
              final String _time = "${date.day}/${date.month}/${date.year}";
              if (model != null) {
                await controller
                    .updateData(
                  model: TextNoteModel(
                    id: model?.id,
                    title: title,
                    description: description,
                    date: _time.obs,
                  ),
                )
                    .then(
                  (value) {
                    return Get.snackbar(
                      icon: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset("asset/animation/notebook.gif"),
                      ),
                      duration: const Duration(milliseconds: 1700),
                      "Success",
                      "Your note has been updated successfully.",
                    );
                  },
                );
              } else {
                await controller
                    .insertData(
                  model: TextNoteModel(
                    title: title,
                    description: description,
                    date: _time.obs,
                  ),
                )
                    .then(
                  (value) {
                    return Get.snackbar(
                      icon: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset("asset/animation/notebook.gif"),
                      ),
                      duration: const Duration(milliseconds: 1700),
                      "Success",
                      "Your note has been saved successfully.",
                    );
                  },
                );
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
      body: GetBuilder<DatabaseController>(
        initState: (state) {
          if (model != null) {
            _title.text = model!.title.value;
            _description.text = model!.description.value;
          }
        },
        builder: (controller) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Title",
                    ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Description",
                    ),
                    maxLines: 26,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
