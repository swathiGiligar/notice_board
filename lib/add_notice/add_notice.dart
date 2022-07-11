import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notice_board/constants.dart' as constants;
import 'package:notice_board/notices/notice_modules.dart';
import 'package:notice_board/notices/notices.dart';

class PlaceNewNotice extends StatefulWidget {
  const PlaceNewNotice({Key? key}) : super(key: key);

  @override
  State<PlaceNewNotice> createState() => _PlaceNewNoticeState();
}

class _PlaceNewNoticeState extends State<PlaceNewNotice> {
  final _formKey = GlobalKey<FormState>();
  String? chosenValue;
  Future<Notice>? _futureNotice;
  bool isButtonPressed = false;

  final headingController = TextEditingController();
  final priceController = TextEditingController();
  final areaLavel1Controller = TextEditingController();
  final areaLevel2Controller = TextEditingController();
  final contactController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  void dispose() {
    headingController.dispose();
    priceController.dispose();
    areaLavel1Controller.dispose();
    areaLevel2Controller.dispose();
    contactController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Board Home'),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.all(5.0),
            child: ListView(
              children: <Widget>[
                //HEADING
                TextFormField(
                  enabled: !isButtonPressed,
                  controller: headingController,
                  decoration: const InputDecoration(
                      hintText: constants.headingHintText,
                      labelText: constants.headingLabel),
                  maxLength: constants.headingMaxLength,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return constants.headingNoInputError;
                    }
                    return null;
                  },
                ),

                //PRICE
                TextFormField(
                  enabled: !isButtonPressed,
                  controller: priceController,
                  maxLength: constants.priceMaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.priceHintText,
                      labelText: constants.priceLabel),
                ),

                //CATEGORY
                DropdownButton<String>(
                  disabledHint:
                      Text(chosenValue ?? constants.categoryDefaultSelection),
                  value: chosenValue,
                  items: constants.categoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text(constants.categoryHintText),
                  onChanged: !isButtonPressed
                      ? (String? newValue) {
                          setState(() {
                            chosenValue = newValue!;
                          });
                        }
                      : null,
                ),

                //AREA LEVEL 1
                TextFormField(
                  enabled: !isButtonPressed,
                  controller: areaLavel1Controller,
                  maxLength: constants.areaLevel1MaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.areaLevel1HintText,
                      labelText: constants.areaLavel1Label),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return constants.areaLevel1NoInputError;
                    }
                    return null;
                  },
                ),

                //AREA LEVEL 2
                TextFormField(
                  enabled: !isButtonPressed,
                  controller: areaLevel2Controller,
                  maxLength: constants.areaLevel2MaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.areaLevel2HintText,
                      labelText: constants.areaLavel2Label),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return constants.areaLevel2NoInputError;
                    }
                    return null;
                  },
                ),

                //CONTACT
                TextFormField(
                  enabled: !isButtonPressed,
                  controller: contactController,
                  maxLength: constants.contactMaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.contactHintText,
                      labelText: constants.contactLabel),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return constants.contactNoInputError;
                    }
                    return null;
                  },
                ),

                //DETAILS
                TextFormField(
                  enabled: !isButtonPressed,
                  controller: detailsController,
                  maxLength: constants.detailsMaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.detailsHintText,
                      labelText: constants.detailsLabel),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: !isButtonPressed
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              String categoryValue = chosenValue ??
                                  constants.categoryDefaultSelection;
                              Notice newNotice = Notice(
                                noticeId: '',
                                heading: headingController.text,
                                price: priceController.text,
                                category: categoryValue,
                                areaLavel1: areaLavel1Controller.text,
                                areaLevel2: areaLevel2Controller.text,
                                contact: contactController.text,
                                details: detailsController.text,
                              );
                              _futureNotice = createNotice(newNotice);
                              setState(() {
                                isButtonPressed = true;
                              });
                            }
                          }
                        : null,
                    child: const Text('Submit'),
                  ),
                ),
                if (isButtonPressed) buildFutureBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Notice> createNotice(Notice newNotice) async {
    final response = await http.post(
      Uri.parse(constants.serverURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'heading': newNotice.heading,
        'price': newNotice.price,
        'category': newNotice.category,
        'area_level_1': newNotice.areaLavel1,
        'area_level_2': newNotice.areaLevel2,
        'contact': newNotice.contact,
        'details': newNotice.details,
      }),
    );

    if (response.statusCode == 201) {
      return Notice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Notice.');
    }
  }

  FutureBuilder<Notice> buildFutureBuilder() {
    return FutureBuilder<Notice>(
      future: _futureNotice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const Text('Notice Created Succcessfully!'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoticeBoardHome()),
                    );
                  },
                  child: const Text('Go Back'))
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              const Text('Notice Creation Failed. Please Try Again'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoticeBoardHome()),
                    );
                  },
                  child: const Text('Go Back'))
            ],
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
