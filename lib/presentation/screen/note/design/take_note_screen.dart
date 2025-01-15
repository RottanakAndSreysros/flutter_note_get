import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/controller/note_controller/database_controller.dart';
import 'package:flutter_note_get/core/data/model/text_note_model.dart';
import 'package:flutter_note_get/presentation/screen/landing_screen.dart';
import 'package:flutter_note_get/presentation/widget/snackbar_widget.dart';
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
            Get.off(LandingScreen());
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
                    return snackbarWidget(
                      image: "assets/animation/document.gif",
                      title: "Successful!",
                      subtitle: "Your note has been updated successfully.",
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
                    return snackbarWidget(
                      image: "assets/animation/document.gif",
                      title: "Successful!",
                      subtitle: "Your note has been saved successfully.",
                    );
                  },
                );
              }
              listModel = await controller.getAllData();
            },
            icon: Container(
              height: 60,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
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
                      hintText: "ចំណងជើង/Title",
                      hintStyle: TextStyle(color: Colors.grey[500]),
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
                      hintText:
                          "កត់ចំណាំអ្វីដែលអ្នកបានរៀន​ បានអាន​ ឬអ្វីផ្សេងទៀតនៅទីនេះ ព្រោះវាផ្ដល់ភាពងាយស្រួលដល់អ្នកក្នុងការដឹងពីអ្វីដែលអ្នកបានធ្វើ និងត្រូវការធ្វើបន្ត។/Discription",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    maxLines: 20,
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
