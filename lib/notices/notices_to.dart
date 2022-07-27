import 'package:flutter/material.dart';
import 'package:notice_board/notices/notice_modules.dart';
import 'package:notice_board/constants.dart' as constants;
import 'package:intl/intl.dart';

class NoticeTransformer {
  String noticeId = "";
  Text heading = const Text("");
  Text price = const Text("");
  Text category = const Text("");
  Text areaLevel = const Text("");
  Text areaLevel1 = const Text("");
  Text areaLevel2 = const Text("");
  Text contact = const Text("");
  Text details = const Text("");
  Text createdOn = const Text("");

  NoticeTransformer(Notice notice) {
    noticeId = notice.noticeId;
    heading = Text(
      notice.heading,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    );
    String priceText = notice.price;
    if (priceText.isEmpty) priceText = constants.priceDefaultMessage;

    String detailsText = notice.details;
    if (detailsText.isEmpty) detailsText = constants.priceDefaultMessage;

    var localTime = notice.createdOn?.toLocal();
    var createdOnDate = DateFormat.yMMMd().format(localTime!);
    var createdOnTime = DateFormat.jms().format(localTime);

    price = Text(priceText);
    category = Text(notice.category);
    areaLevel1 = Text(notice.areaLevel1);
    areaLevel2 = Text(notice.areaLevel2);
    areaLevel = Text('${notice.areaLevel1} / ${notice.areaLevel2}');
    contact = Text(notice.contact);
    details = Text(detailsText);
    createdOn = Text('$createdOnDate $createdOnTime');
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
