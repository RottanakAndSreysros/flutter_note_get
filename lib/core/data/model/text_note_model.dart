import 'package:get/get.dart';

class TextNoteModel extends GetxController {
  late RxInt? id;
  final RxString title;
  final RxString description;
  final RxString date;

  TextNoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id?.value,
      'title': title.value,
      'description': description.value,
      'date_time': date.value,
    };
  }

  TextNoteModel.fromJson(Map<String, dynamic> map)
      : id = RxInt(map['id']),
        title = RxString(map['title']),
        description = RxString(map['description']),
        date = RxString(map['date_time']);
}
