import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/controller/database_controller.dart';
import 'package:flutter_note_get/core/data/model/text_note_model.dart';
import 'package:flutter_note_get/presentation/screen/detail/detail_screen.dart';
import 'package:flutter_note_get/presentation/screen/design/take_note_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(DatabaseController());
  List<TextNoteModel> listModel = <TextNoteModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text(
          "My Notebook",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.off(TakeNoteScreen());
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
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            Get.off(TakeNoteScreen(
                                              model: listModel[index],
                                            ));
                                          },
                                          backgroundColor: const Color.fromARGB(
                                              255, 11, 224, 19),
                                          foregroundColor: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          icon: Icons.edit,
                                          label: 'Edit',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) async {
                                            await controller.deleteData(
                                              id: listModel[index].id!.value,
                                            );
                                            listModel =
                                                await controller.getAllData();
                                            Get.snackbar(
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Image.asset(
                                                    "asset/animation/clean.gif"),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 1700),
                                              "Success",
                                              "Your note has been deleted successfully.",
                                            );
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.off(DetailScreen(
                                          mode: listModel[index],
                                        ));
                                      },
                                      child: Container(
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.pink[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listModel[index].title.value,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                listModel[index]
                                                    .description
                                                    .value,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                listModel[index].date.value,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
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
