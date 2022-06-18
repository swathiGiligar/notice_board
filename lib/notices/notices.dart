import 'package:flutter/material.dart';
import 'package:notice_board/notices/notice_modules.dart';
import 'package:notice_board/notices/notices_to.dart';

class _NoticeBoardHomeState extends State<NoticeBoardHome> {
  late Future<List<Notice>> futureNoticesForDisplay;

  @override
  void initState() {
    super.initState();
    futureNoticesForDisplay = fetchNotices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notice>>(
      future: futureNoticesForDisplay,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var noticesFromServer = snapshot.data;
          List<NoticeTransformer> noticesForDisplay =
              getNoticesForDisplay(noticesFromServer!);
          ListView noticeList = ListView.separated(
            itemCount: noticesForDisplay.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(12.0),
                      margin: EdgeInsets.all(5.0),
                      // decoration: BoxDecoration(border: Border.all(),),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: noticesForDisplay[index].heading),
                          Row(children: [
                            Text(
                              "Price: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            noticesForDisplay[index].price
                          ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Details: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child: noticesForDisplay[index].details)
                              ]),
                          Row(children: [
                            Text(
                              "Contact Inforomation: ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            noticesForDisplay[index].contact
                          ]),
                        ],
                      )),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
          return noticeList;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
    return const CircularProgressIndicator();
  }
}

class NoticeBoardHome extends StatefulWidget {
  const NoticeBoardHome({Key? key}) : super(key: key);

  @override
  State<NoticeBoardHome> createState() => _NoticeBoardHomeState();
}

List<NoticeTransformer> getNoticesForDisplay(List<Notice> notices) {
  {
    return NoticeTransformer.getNoticesTed(notices);
  }
}
