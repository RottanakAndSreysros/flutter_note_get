import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note_get/core/data/model/book_model.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;
  final BookModel book;

  PDFViewerScreen(this.pdfPath, this.book, {super.key});

  RxInt pages = 0.obs;
  RxInt currentPage = 0.obs;
  RxBool isReady = true.obs;
  RxString errorMessage = "".obs;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.bookName.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                Text(
                  "By : ${book.author.value}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Obx(
            () {
              return Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(book.authorImage.value),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(
        () {
          return Stack(
            children: <Widget>[
              PDFView(
                filePath: pdfPath,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                defaultPage: currentPage.value,
                fitPolicy: FitPolicy.BOTH,
                backgroundColor: Colors.black,
                // ignore: no_leading_underscores_for_local_identifiers
                onRender: (_pages) {
                  pages.value = _pages!;
                  isReady.value = true;
                },
                onError: (error) {
                  errorMessage.value = error.toString();
                },
                onPageError: (page, error) {
                  errorMessage.value = '$page: ${error.toString()}';
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onPageChanged: (int? page, int? total) {
                  currentPage.value = page ?? 0;
                },
              ),
              errorMessage.value.isEmpty
                  ? !isReady.value
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.blue))
                      : Container()
                  : Center(
                      child: Text(
                        errorMessage.value,
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
