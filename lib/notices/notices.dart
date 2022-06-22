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
          final noticeList = ListView.separated(
            itemCount: noticesForDisplay.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.all(5.0),
                      // decoration: BoxDecoration(border: Border.all(),),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: noticesForDisplay[index].heading),
                          Row(children: [
                            const Text(
                              "Price: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            noticesForDisplay[index].price
                          ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Details: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child: noticesForDisplay[index].details)
                              ]),
                          Row(children: [
                            const Text(
                              "Contact Inforomation: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notice Board Home'),
            ),
            body: Align(
              alignment: Alignment.topLeft,
              child: noticeList,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => setState(() {
                futureNoticesForDisplay = fetchNotices();
              }),
              tooltip: 'Refresh',
              child: const Icon(Icons.refresh),
            ),
          );
          // return noticeList;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
    // return const CircularProgressIndicator();
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
