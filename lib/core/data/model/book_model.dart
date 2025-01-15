import 'package:get/get.dart';

class BookModel extends GetxController {
  final RxInt id;
  final RxString author;
  final RxString authorImage;
  final RxString bookCover;
  final RxString path;
  final RxString bookName;
  final RxString fileName;
  final RxString category;

  BookModel({
    required this.id,
    required this.author,
    required this.authorImage,
    required this.bookCover,
    required this.path,
    required this.bookName,
    required this.fileName,
    required this.category,
  });
}

// RxList<BookModel> listViewBook = <BookModel>[].obs;
// final RxString bookPath = "".obs;

RxList<BookModel> listBook = <BookModel>[
  BookModel(
    id: 1.obs,
    author: "ផាត់ ភារិន".obs,
    authorImage: "assets/books/math/integral_1/ផាត់ភារិន.jpg".obs,
    bookCover: "assets/books/math/integral_1/IntegralCover1.png".obs,
    path: "assets/books/math/integral_1/mathIntegral.pdf".obs,
    bookName: "អាំង​ តេក្រាល(INTEGRAL)".obs,
    fileName: "mathIntegral.pdf".obs,
    category: "គណិតវិទ្យា".obs,
  )
].obs;
