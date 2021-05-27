// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project Modules
import 'package:livi_bank_test/common/hive/boxes.dart';
import 'package:livi_bank_test/common/model/phone_validation_result.dart';
import 'package:livi_bank_test/validation/widgets/animated_slide_in_row.dart';

class ValidationPage extends StatelessWidget {
  static final _listsOfHeaders = [
    "Created Date",
    'Region',
    'DialCode',
    'Tel.No',
    'isValid'
  ];

  Widget _headerTextStyle(context, {required String title}) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6!.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent(context, List<PhoneValidationResult> result) {
    if (result.isEmpty) {
      return Center(
        child: Text(
          'No Phone Validation Result Yet!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: 30,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _listsOfHeaders
                        .map(
                          (header) => _headerTextStyle(context, title: header),
                        )
                        .toList()),
              ),
            ),
            if (result.length >= 1)
              Expanded(
                child: StatefulBuilder(
                  builder: (context, rebuild) {
                    return Scrollbar(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: result
                            .map(
                              (value) => AnimatedSlideInRow(
                                ValueKey(value.createdDate!.toString()),
                                result.indexOf(value),
                                value,
                                (index) {
                                  rebuild(() {
                                    final temp = result[index];
                                    temp.delete();
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    }
  }

  void dispose() {
    Hive.box('PhoneValidationResult').close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Validation Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<PhoneValidationResult>>(
        valueListenable: Boxes.getPhoneValidationResult().listenable(),
        builder: (context, box, _) {
          final validationResults =
              box.values.toList().cast<PhoneValidationResult>();
          return _buildContent(context, validationResults);
        },
      ),
    );
  }
}
