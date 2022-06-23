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
          return renderList(snapshot);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Scaffold renderList(AsyncSnapshot<List<Notice>> snapshot) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    drawHeading(noticesForDisplay, index),
                    drawPriceRow(noticesForDisplay, index),
                    drawDetailsRow(noticesForDisplay, index),
                    drawContactInfoRow(noticesForDisplay, index),
                  ],
                )),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
    return drawMainScaffold(noticeList);
  }

  Scaffold drawMainScaffold(ListView noticeList) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Board Home'),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: noticeList,
      ),
      floatingActionButton: setRefreshAction(),
    );
  }

  FloatingActionButton setRefreshAction() {
    return FloatingActionButton(
      onPressed: () => setState(() {
        futureNoticesForDisplay = fetchNotices();
      }),
      tooltip: 'Refresh',
      child: const Icon(Icons.refresh),
    );
  }

  Row drawContactInfoRow(List<NoticeTransformer> noticesForDisplay, int index) {
    return Row(children: [
      const Text(
        "Contact Inforomation: ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      noticesForDisplay[index].contact
    ]);
  }

  Row drawDetailsRow(List<NoticeTransformer> noticesForDisplay, int index) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Details: ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Expanded(child: noticesForDisplay[index].details)
    ]);
  }

  Center drawHeading(List<NoticeTransformer> noticesForDisplay, int index) =>
      Center(child: noticesForDisplay[index].heading);

  Row drawPriceRow(List<NoticeTransformer> noticesForDisplay, int index) {
    return Row(children: [
      const Text(
        "Price: ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      noticesForDisplay[index].price
    ]);
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
