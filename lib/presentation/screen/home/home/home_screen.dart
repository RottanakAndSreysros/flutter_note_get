import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/controller/home_screen_controller.dart';
import 'package:flutter_note_get/core/data/model/book_model.dart';
import 'package:flutter_note_get/presentation/screen/home/home/pdf_view_screen.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  RxString pathPDF = "".obs;
  RxInt pages = 0.obs;
  RxInt currentPage = 0.obs;
  RxBool isReady = true.obs;
  RxString errorMessage = "".obs;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  final controller = Get.put(HomeScreenController());
  RxString bookPath = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Lim Rottanak'),
              accountEmail: Text('limrottanak8@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/image/IMG_4931.jpg"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      "សូមជម្រាបដល់អ្នកប្រើប្រាស់កម្មវិធីនេះទាំងអស់ឲបានជ្រាបថាលោកអ្នកអាចចែករំលែកនិងបង្ហាញនូវអត្ថបទរបស់ខ្លួនដោយឥតគិតថ្លៃនៅលើកម្មវិធី​ ដោយគ្រាន់តែទំនាក់ទំនងតាមរយៈ emailខាងលើ។​"),
                  SizedBox(height: 10),
                  Text(
                      "បញ្ជាក់ : អត្ថបទទាំងនោះមានដូចជា រឿង(គ្រប់ប្រភេទ ហើយដែលមានប្រយោជន៍សម្រាប់អ្នកអាន)​ មេរៀន និងលំហាត់ជាដើម។"),
                  Text("សូមអរគុណ។"),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Book"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: listBook.length,
                  itemBuilder: (context, index) {
                    final book = listBook[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(book.bookCover.value),
                          ),
                          title: Text(
                            book.bookName.value,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            book.author.value,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            bookPath.value = book.path.value;
                            controller
                                .fromAsset(
                              asset: book.path,
                              filename: book.fileName,
                            )
                                .then((file) {
                              pathPDF.value = file.path;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewerScreen(
                                      pathPDF.value, listBook[index]),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ), // Empty body since the drawer handles the book list
    );
  }
}
