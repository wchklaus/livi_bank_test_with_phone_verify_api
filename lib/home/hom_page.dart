import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:country_code_picker/country_code_picker.dart';

import 'package:livi_bank_test/common/widgets/circle_button.dart';
import 'package:livi_bank_test/home/util/phone_notifier.dart';
import 'package:livi_bank_test/home/widgets/change_theme_widget.dart';
import 'package:livi_bank_test/validation/validation_manager.dart';
import 'package:livi_bank_test/validation/validation_page.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({required this.title});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController numberController = TextEditingController();

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
                      Consumer<PhoneNotifier>(
                        builder: (context, phoneValidation, child) {
                          return TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            onChanged: phoneValidation.changePhoneNum,
                            decoration: InputDecoration(
                              errorText: phoneValidation.phoneNum.error,
                              labelText: "手提電話號碼",
                              prefixIcon: Container(
                                child: CountryCodePicker(
                                  searchDecoration: InputDecoration(
                                    prefixStyle: TextStyle(),
                                  ),
                                  onChanged: (CountryCode code) {
                                    phoneValidation.setCountryCode(code);
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
                              TwilioPhoneVerify _twilioPhoneVerify;
                              _twilioPhoneVerify = new TwilioPhoneVerify(
                                  accountSid:
                                      'AC94aa85bc82e708d5d6c916a37a1c2dd6', // replace with Account SID
                                  authToken:
                                      '682ba56458836018d4b90f7657233f29', // replace with Auth Token
                                  serviceSid:
                                      'IS6f67dfcd2f9d4dcb9e831f1a86277a36' // replace with Service SID
                                  );
                              // print(PhoneNotifier().countryCode.dialCode! +
                              //     PhoneNotifier().phoneNum.value!);
                              var result = await _twilioPhoneVerify.sendSmsCode(
                                  PhoneNotifier().countryCode.dialCode! +
                                      PhoneNotifier().phoneNum.value!);
                              if (result['message'] == 'success') {
                                print(result.toString());
                                // code sent
                              } else {
                                // error
                                print(
                                    '${result['statusCode']} : ${result['message']}');
                              }
                              // await ValidationManager.addValidation();
                              // if (PhoneNotifier().isValid) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) {
                              //         return ValidationPage();
                              //       },
                              //     ),
                              //   );
                              // }
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
