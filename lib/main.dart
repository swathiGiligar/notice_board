// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'notices/notices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colourScheme = const ColorScheme(
        background: Colors.lightBlue,
        brightness: Brightness.light,
        error: Colors.red,
        onBackground: Colors.lightGreen,
        onError: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.amberAccent,
        primary: Color.fromRGBO(46, 125, 50, 1.0),
        secondary: Color.fromRGBO(119, 84, 71, 1.0),
        surface: Colors.orangeAccent);

    var titleStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 20.0,
    );

    var appBarTheme = AppBarTheme(
        backgroundColor: const Color.fromRGBO(46, 125, 50, 1.0),
        titleTextStyle: titleStyle);

    var themeData = ThemeData(
      colorScheme: colourScheme,
      appBarTheme: appBarTheme,
    );

    return MaterialApp(
      title: 'Notice Board',
      theme: themeData,
      home: const NoticeBoardHome(),
    );
  }
}
