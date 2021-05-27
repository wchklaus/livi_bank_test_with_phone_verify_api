# livi_bank_test

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Tasks:
- There will be a selection box which allows customers to choose which area code they are in. E.g. Hong Kong should be +852. You may want to find the corresponding flags.


// Define is the 
- To ease the customers, we may want to pre-select +852 to save customers time. (Or potentially replaceable with an API where we can detect the customer's location to find the most close match. API part is not needed here, just to leave a room for future enhancement)

- Area code should allow keyboard typing for quick navigation or alternatively scroll down the list


flutter clean
flutter pub cache repair
flutter pub run build_runner clean
flutter pub run build_runner build


# About ----- $ flutter packages pub run build_runner build
  analyzer:
    dependency: transitive
    description:
      name: analyzer
      url: "https://pub.dartlang.org"
    source: hosted
    version: "1.5.0"

# About ---- reset the Hive
- Delete the adapters created
- run flutter clean
- delete the app from the emulator
- create the new adapters with flutter packages pub run build_runner build



Your mobile application should be written in Flutter which can be rendered on Android and IOS devices