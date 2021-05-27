class Country {
  final String name;
  final String internationalCode;
  final Set<String> mobilePrefix;
  final int sizeOfNSN;

  Country._(
    this.name,
    this.internationalCode,
    this.mobilePrefix,
    this.sizeOfNSN,
  );

  static Country hk = Country._(
    'Hong Kong',
    '+852',
    {'4', '5', '6', '7', '8', '9'},
    8,
  );

  static Country macau = Country._(
    'Macau',
    '+853',
    {'6'},
    8,
  );

  static Country kuwait = Country._(
    'Kuwait',
    '+965',
    {'5', '6', '9'},
    8,
  );

  static Map<String, Country> codeToCountryMap = {
    '+852': hk,
    '+853': macau,
    '+965': kuwait,
  };
}
