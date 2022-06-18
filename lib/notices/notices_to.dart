import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notice_board/notices/notice_modules.dart';
import 'package:notice_board/constants.dart' as Constants;

class NoticeTransformer {
  Text heading = Text("");
  Text price = Text("");
  Text category = Text("");
  Text areaLavel1 = Text("");
  Text areaLevel2 = Text("");
  Text contact = Text("");
  Text details = Text("");

  NoticeTransformer(Notice notice) {
    heading = Text(
      notice.heading,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    );
    price = Text(notice.price ?? Constants.priceDefaultMessage);
    category = Text(notice.category);
    areaLavel1 = Text(notice.areaLavel1);
    areaLevel2 = Text(notice.areaLevel2);
    contact = Text(notice.contact);
    details = Text(notice.details ?? Constants.detailsDefaultMessage);
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
