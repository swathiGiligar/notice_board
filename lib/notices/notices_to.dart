import 'package:flutter/material.dart';
import 'package:notice_board/notices/notice_modules.dart';
import 'package:notice_board/constants.dart' as constants;

class NoticeTransformer {
  Text heading = const Text("");
  Text price = const Text("");
  Text category = const Text("");
  Text areaLavel1 = const Text("");
  Text areaLevel2 = const Text("");
  Text contact = const Text("");
  Text details = const Text("");

  NoticeTransformer(Notice notice) {
    heading = Text(
      notice.heading,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    );
    String priceText = notice.price;
    if (priceText.isEmpty) priceText = constants.priceDefaultMessage;

    String detailsText = notice.details;
    if (detailsText.isEmpty) detailsText = constants.priceDefaultMessage;

    price = Text(priceText);
    category = Text(notice.category);
    areaLavel1 = Text(notice.areaLavel1);
    areaLevel2 = Text(notice.areaLevel2);
    contact = Text(notice.contact);
    details = Text(detailsText);
  }

  static List<NoticeTransformer> getNoticesTed(List<Notice> notices) {
    List<NoticeTransformer> tedNotices = List.empty(growable: true);
    var it = notices.iterator;
    while (it.moveNext()) {
      NoticeTransformer currNotice = NoticeTransformer(it.current);
      tedNotices.add(currNotice);
    }
    return tedNotices;
  }
}
