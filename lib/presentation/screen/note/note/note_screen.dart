import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/controller/note_controller/database_controller.dart';
import 'package:flutter_note_get/core/data/model/text_note_model.dart';
import 'package:flutter_note_get/presentation/screen/note/detail/detail_screen.dart';
import 'package:flutter_note_get/presentation/widget/snackbar_widget.dart';
import 'package:get/get.dart';

import '../design/take_note_screen.dart';

class NoteScreen extends StatelessWidget {
  final controller = Get.put(DatabaseController());
  // List<TextNoteModel> listModel = <TextNoteModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/animation/noteBook1.gif"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: const Text(
          "My Notebook",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.to(TakeNoteScreen());
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<DatabaseController>(
        init: controller,
        initState: (state) async {
          listModel = await controller.getAllData();
        },
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: listModel.isEmpty
                    ? const Column(
                        children: [
                          SizedBox(
                            height: 400,
                          ),
                          Text(
                            "Empty",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: listModel.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Obx(
                                () {
                                  return SizedBox(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(DetailScreen(
                                          mode: listModel[index],
                                        ));
                                      },
                                      child: Container(
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.pink[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listModel[index]
                                                          .title
                                                          .value,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      listModel[index]
                                                          .description
                                                          .value,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      listModel[index]
                                                          .date
                                                          .value,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.to(TakeNoteScreen(
                                                        model: listModel[index],
                                                      ));
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.green,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await controller
                                                          .deleteData(
                                                        id: listModel[index]
                                                            .id!
                                                            .value,
                                                      );
                                                      listModel =
                                                          await controller
                                                              .getAllData();
                                                      snackbarWidget(
                                                        image:
                                                            "assets/animation/trash.gif",
                                                        title: "Successful!",
                                                        subtitle:
                                                            "Your note has been deleted successfully.",
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              )
            ],
          );
        },
      ),
    );
  }
}
