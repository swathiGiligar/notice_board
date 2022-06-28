import 'package:flutter/material.dart';
import 'package:notice_board/constants.dart' as constants;

class PlaceNewNotice extends StatefulWidget {
  const PlaceNewNotice({Key? key}) : super(key: key);

  @override
  State<PlaceNewNotice> createState() => _PlaceNewNoticeState();
}

class _PlaceNewNoticeState extends State<PlaceNewNotice> {
  final _formKey = GlobalKey<FormState>();
  String? chosenValue;
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
                  maxLength: constants.priceMaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.priceHintText,
                      labelText: constants.priceLabel),
                ),

                //CATEGORY
                DropdownButton<String>(
                  value: chosenValue,
                  items: constants.categoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text(constants.categoryHintText),
                  onChanged: (String? newValue) {
                    setState(() {
                      chosenValue = newValue!;
                    });
                  },
                ),

                //AREA LEVEL 1
                TextFormField(
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
                  maxLength: constants.detailsMaxLength,
                  decoration: const InputDecoration(
                      hintText: constants.detailsHintText,
                      labelText: constants.detailsLabel),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
