import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notice_board/constants.dart' as constants;

class Notice {
  final String noticeId;
  final String heading;
  final String price;
  final String category;
  final String areaLevel1;
  final String areaLevel2;
  final String contact;
  final String details;
  final DateTime? createdOn;

  const Notice(
      {required this.noticeId,
      required this.heading,
      required this.price,
      required this.category,
      required this.areaLevel1,
      required this.areaLevel2,
      required this.contact,
      required this.details,
      this.createdOn});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
        noticeId: json['notice_id'],
        heading: json['heading'],
        price: json['price'],
        category: json['category'],
        areaLevel1: json['area_level_1'],
        areaLevel2: json['area_level_2'],
        contact: json['contact'],
        details: json['details'],
        createdOn: DateTime.parse(json['created_on']));
  }
}

Future<List<Notice>> fetchNotices() async {
  final response = await http.get(Uri.parse(constants.serverURL));

  if (response.statusCode == 200) {
    final List<dynamic> notices = jsonDecode(response.body);

    List<Notice> noticesForDisplay = List.empty(growable: true);

    var itr = notices.iterator;
    while (itr.moveNext()) {
      noticesForDisplay.add(Notice.fromJson(itr.current));
    }

    return noticesForDisplay;
  } else {
    throw Exception('Failed to load notices');
  }
}

class Notices {
  List<Notice> notices = List.empty();

  void fillList(noticesData) {
    notices = List.from(noticesData);
  }
}
