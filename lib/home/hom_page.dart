// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Customized Packages
import 'package:country_code_picker/country_code_picker.dart';

// Project Packages
import 'package:livi_bank_test/common/widgets/circle_button.dart';
import 'package:livi_bank_test/home/util/phone_notifier.dart';
import 'package:livi_bank_test/home/widgets/change_theme_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({required this.title});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController numberController = TextEditingController();
  GlobalKey _textFormText = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent.withOpacity(0.95),
        body: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Container(
                      width: 125,
                      alignment: Alignment.center,
                      child: Text(
                        "LIVI BANK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 15,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "EN",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 30.0,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.more_horiz_rounded),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "午安",
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                      StatefulBuilder(
                        key: _textFormText,
                        builder: (context, rebuild) {
                          return TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              errorText: PhoneNotifier().phoneNum.error,
                              labelText: "手提電話號碼",
                              prefixIcon: Container(
                                child: CountryCodePicker(
                                  searchDecoration: InputDecoration(
                                    prefixStyle: TextStyle(),
                                  ),
                                  onChanged: (CountryCode code) {
                                    PhoneNotifier().setCountryCode(
                                      code,
                                      () => rebuild(() {}),
                                    );
                                    numberController.clear();
                                  },
                                  dialogTextStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  searchStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  initialSelection: 'HK',
                                  showFlagDialog: true,
                                  comparator: (a, b) =>
                                      a.name!.compareTo(b.name!),
                                ),
                              ),
                              suffixIcon: CircleButton(
                                onTapCallBack: () => numberController.clear(),
                                size: Size(15, 15),
                                iconData: Icons.close_rounded,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: new BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: new BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              Response response;
                              String path =
                                  "${env['url']}${env['access_key']}${env['number']}${numberController.text}${env['country_code']}${PhoneNotifier().countryCode.code}${env['format']}";
                              response = await Dio().get(path);
                              PhoneNotifier().changePhoneNum(
                                context,
                                response.data,
                                () =>
                                    _textFormText.currentState!.setState(() {}),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 50,
                              width: 250,
                              child: Text(
                                "Validation",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ChangeThemeWidget(),
      ),
    );
  }
}
