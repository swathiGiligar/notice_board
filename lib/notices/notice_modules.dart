import 'dart:convert';

import 'package:http/http.dart' as http;

class Notice {
  final String noticeId;
  final String heading;
  final String price;
  final String category;
  final String areaLavel1;
  final String areaLevel2;
  final String contact;
  final String details;

  const Notice(
      {required this.noticeId,
      required this.heading,
      required this.price,
      required this.category,
      required this.areaLavel1,
      required this.areaLevel2,
      required this.contact,
      required this.details});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeId: json['notice_id'],
      heading: json['heading'],
      price: json['price'],
      category: json['category'],
      areaLavel1: json['area_level_1'],
      areaLevel2: json['area_level_2'],
      contact: json['contact'],
      details: json['details'],
    );
  }
}

Future<List<Notice>> fetchNotices() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/noticeBoard'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final List<dynamic> notices = jsonDecode(response.body);

    List<Notice> noticesForDisplay = List.empty(growable: true);

    var itr = notices.iterator;
    while (itr.moveNext()) {
      noticesForDisplay.add(Notice.fromJson(itr.current));
    }

    return noticesForDisplay;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load notices');
  }
}

class Notices {
  List<Notice> notices = List.empty();

  void fillList(noticesData) {
    notices = List.from(noticesData);
  }

  // static List<Notice> dummyData() {
  //   // Notice notice1 = Notice();

  //   // noticeData.add(notice1);
  //   // noticeData.add(notice2);

  //   return noticeData;
  // }
}
