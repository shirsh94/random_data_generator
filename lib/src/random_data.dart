import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:random_data_generator/src/raw_data.dart';
import 'flake_uuid.dart';
import 'xid.dart';

enum UuidVersion { v1, v2, v3, v4, v5 }

enum UuidVariant { ncs, rfc4122, microsoft }

// Snowflake ID
int _snowflakeDatacenterId = 1;
int _snowflakeWorkerId = 1;
int _snowflakeSequence = 0;
int _snowflakeLastTimestamp = -1;

class RandomData {
  static int generateRandomIntBetween(int start, int end) {
    Random random = Random();
    return start + random.nextInt(end - start + 1);
  }

  static double generateRandomDoubleBetween(double start, double end) {
    Random random = Random();
    return start + random.nextDouble() * (end - start);
  }

  String generateRandomLowercaseAlphabet() {
    Random random = Random();
    int randomNumber = random.nextInt(26);
    String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    return alphabet[randomNumber];
  }

  static String generateRandomCapitalAlphabet() {
    Random random = Random();
    int randomNumber = random.nextInt(26);
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return alphabet[randomNumber];
  }

  static String quote() {
    Random random = Random();

    int index = random.nextInt(quotes.length);
    return quotes[index];
  }

  static String languageName() {
    Random random = Random();
    int index = random.nextInt(languageNames.length);
    return languageNames[index];
  }

  static String getRandomHexColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  static List<int> getRandomRGBColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return [r, g, b];
  }

  static List<int> getRandomRGBAColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    int a = random.nextInt(256);
    return [r, g, b, a];
  }

  static List<double> getRandomHSLColor() {
    Random random = Random();
    double h = random.nextDouble() * 360;
    double s = random.nextDouble() * 100;
    double l = random.nextDouble() * 100;
    return [h, s, l];
  }

  static List<double> getRandomHSVColor() {
    Random random = Random();
    double h = random.nextDouble() * 360;
    double s = random.nextDouble() * 100;
    double v = random.nextDouble() * 100;
    return [h, s, v];
  }

  static List<int> getRandomCMYKColor() {
    Random random = Random();
    int c = random.nextInt(101);
    int m = random.nextInt(101);
    int y = random.nextInt(101);
    int k = random.nextInt(101);
    return [c, m, y, k];
  }

  static String generateRandomEmail() {
    String username = generateRandomEmailName();
    String domain = domains[Random().nextInt(domains.length)];
    return '$username@$domain';
  }

  static String generateRandomEmailName() {
    List<String> characters = 'abcdefghijklmnopqrstuvwxyz0123456789'.split('');
    String username = '';
    for (int i = 0; i < 10; i++) {
      username += characters[Random().nextInt(characters.length)];
    }
    return username;
  }

  static String generateEasyPassword({int passwordLength = 8}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(passwordLength,
          (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  static String generateMediumPassword({int passwordLength = 10}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(passwordLength,
          (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  static String generateStrongPassword({int passwordLength = 12}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_-+=[]{}|;:,.<>?';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(passwordLength,
          (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  static String generateRandomAnimalName() {
    final random = Random();
    return animalNames[random.nextInt(animalNames.length)];
  }

  static String generateAncientAnimalName() {
    final random = Random();
    return ancientAnimalNames[random.nextInt(ancientAnimalNames.length)];
  }

  static String generateRandomColorName() {
    final random = Random();
    final index = random.nextInt(colorNames.length);
    return colorNames[index];
  }

  static String generateRandomBikeNameWithCompany() {
    final random = Random();
    final index = random.nextInt(bikeNames.length);
    final bikeName = bikeNames[index];
    final companyName = bikeCompanyNames[index];
    return "$bikeName by $companyName";
  }

  static String generateRandomBikeCompanyName() {
    final random = Random();
    final index = random.nextInt(bikeCompanyNames.length);
    final companyName = bikeCompanyNames[index];
    return companyName;
  }

  static String generateRandomBikeName() {
    final random = Random();
    final index = random.nextInt(bikeNames.length);
    final bikeName = bikeNames[index];
    return bikeName;
  }

  static String generateRandomCarNameWithCompany() {
    final random = Random();
    final index = random.nextInt(carNames.length);
    final carName = carNames[index];
    final companyName = carCompanyNames[index];
    return "$carName by $companyName";
  }

  static String generateRandomCarCompanyName() {
    final random = Random();
    final index = random.nextInt(carCompanyNames.length);
    final companyName = carCompanyNames[index];
    return companyName;
  }

  static String generateRandomCarName() {
    final random = Random();
    final index = random.nextInt(carNames.length);
    final bikeName = carNames[index];
    return bikeName;
  }

  static String generateRandomFruitName() {
    final random = Random();
    final index = random.nextInt(fruitNames.length);
    return fruitNames[index];
  }

  static String generateRandomVegetableName() {
    final random = Random();
    final index = random.nextInt(vegetableNames.length);
    return vegetableNames[index];
  }

  static String generateRandomDrinkName() {
    final random = Random();
    final index = random.nextInt(drinkNames.length);
    return drinkNames[index];
  }

  static String generateRandomCountryName() {
    final random = Random();
    final index = random.nextInt(countryNames.length);
    return countryNames[index];
  }

  static String generateRandomCurrencyNamWithSign() {
    final random = Random();
    final index = random.nextInt(currencyNames.length);
    final currencyName = currencyNames[index];
    final currencySign = currencySigns[index];
    return "$currencyName ($currencySign)";
  }

  static String generateRandomCurrencyName() {
    final random = Random();
    final index = random.nextInt(currencyNames.length);
    final currencyName = currencyNames[index];
    return currencyName;
  }

  static String generateRandomCurrencySign() {
    final random = Random();
    final index = random.nextInt(currencySigns.length);
    final currencySign = currencySigns[index];
    return currencySign;
  }

  static String generateRandomCompanyName() {
    final random = Random();
    final index = random.nextInt(companyNames.length);
    return companyNames[index];
  }

  static String getRandomTechnologyCompany() {
    return getRandomItem(technologyCompanies);
  }

  static String getRandomFinanceCompany() {
    return getRandomItem(financeCompanies);
  }

  static String getRandomRetailCompany() {
    return getRandomItem(retailCompanies);
  }

  static String getRandomAutomotiveCompany() {
    return getRandomItem(automotiveCompanies);
  }

  static String getRandomFoodAndBeverageCompany() {
    return getRandomItem(foodAndBeverageCompanies);
  }

  static String getRandomPharmaceuticalCompany() {
    return getRandomItem(pharmaceuticalCompanies);
  }

  static String getRandomAerospaceCompany() {
    return getRandomItem(aerospaceCompanies);
  }

  static String getRandomConsultingCompany() {
    return getRandomItem(consultingCompanies);
  }

  static String getRandomEnergyCompany() {
    return getRandomItem(energyCompanies);
  }

  static String getRandomManufacturingCompany() {
    return getRandomItem(manufacturingCompanies);
  }

  static String getRandomItem(List<String> list) {
    final random = Random();
    final index = random.nextInt(list.length);
    return list[index];
  }

  static String generateOTP({int otpLength = 6}) {
    const chars = "0123456789";
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        otpLength, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateUniqueIdentifier() {
    final random = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        random.nextInt(999999).toString().padLeft(6, '0');
  }

  static String generateRandomToken({int length = 16}) {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateInvoiceNumber() {
    final random = Random();
    return "INV" +
        DateTime.now().year.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generatePhoneNumberVerificationCode() {
    final random = Random();
    return random.nextInt(999999).toString().padLeft(6, '0');
  }

  static String generateDocumentNumber() {
    final random = Random();
    return "DOC" +
        DateTime.now().year.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generateTrackingNumber() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "TRK" +
        DateTime.now().year.toString() +
        String.fromCharCodes(Iterable.generate(
            8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateEmployeeId() {
    final random = Random();
    return "EMP" +
        DateTime.now().year.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generateOrderNumber() {
    final random = Random();
    return "ORD" +
        DateTime.now().year.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generateAccountNumber() {
    final random = Random();
    return "ACC" +
        DateTime.now().year.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generateTransactionId() {
    final random = Random();
    return "TXN" +
        DateTime.now().year.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generateCouponCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "COUPON" +
        String.fromCharCodes(Iterable.generate(
            6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateVoucherCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "VOUCHER" +
        String.fromCharCodes(Iterable.generate(
            8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateDiscountCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "DISCOUNT" +
        String.fromCharCodes(Iterable.generate(
            6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generatePromoCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "PROMO" +
        String.fromCharCodes(Iterable.generate(
            6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateReferralCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "REF" +
        String.fromCharCodes(Iterable.generate(
            8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateVerificationCode() {
    final random = Random();
    return random.nextInt(999999).toString().padLeft(6, '0');
  }

  static String generateTrackingCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "TRACK" +
        String.fromCharCodes(Iterable.generate(
            8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generateAuthCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "AUTH" +
        String.fromCharCodes(Iterable.generate(
            6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static String generatePinCode() {
    final random = Random();
    return random.nextInt(9999).toString().padLeft(4, '0');
  }

  static String generateSecretCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#%^&*()";
    final random = Random();
    return "SECRET${String.fromCharCodes(Iterable.generate(10, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateAccessCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "ACCESS${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateSessionId() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "SESSION${String.fromCharCodes(Iterable.generate(12, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateCustomerNumber() {
    final random = Random();
    return "CUS${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generateReservationCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "RES${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateTransactionCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "TRX${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateRefundCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "REFUND${String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateEnrollmentCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "ENROLL${String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateUuid(UuidVersion version, UuidVariant variant) {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));

    // Set version
    bytes[6] = (bytes[6] & 0x0F) | ((version.index + 1) << 4);

    // Set variant
    bytes[8] = (bytes[8] & 0x3F) | (variant.index << 6);

    const hexDigits = '0123456789abcdef';
    final uuid = StringBuffer();
    for (int i = 0; i < 16; i++) {
      uuid.write(hexDigits[(bytes[i] & 0xF0) >> 4]);
      uuid.write(hexDigits[bytes[i] & 0x0F]);
      if (i == 3 || i == 5 || i == 7 || i == 9) {
        uuid.write('-');
      }
    }
    return uuid.toString();
  }

  static String getVersionDescription(UuidVersion version) {
    switch (version) {
      case UuidVersion.v1:
        return 'Time-based version (version 1)';
      case UuidVersion.v2:
        return 'DCE Security version (version 2)';
      case UuidVersion.v3:
        return 'Name-based version using MD5 hashing (version 3)';
      case UuidVersion.v4:
        return 'Randomly generated version (version 4)';
      case UuidVersion.v5:
        return 'Name-based version using SHA-1 hashing (version 5)';
      default:
        return 'Unknown version';
    }
  }

  static String getVariantDescription(UuidVariant variant) {
    switch (variant) {
      case UuidVariant.ncs:
        return 'Reserved, NCS backward compatibility (variant 0)';
      case UuidVariant.rfc4122:
        return 'RFC 4122/DCE variant (variant 1)';
      case UuidVariant.microsoft:
        return 'Reserved, Microsoft Corporation backward compatibility (variant 2)';
      default:
        return 'Unknown variant';
    }
  }

  static String generatePasscode({int length = 6}) {
    final random = Random.secure();
    const chars = "0123456789";
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

// GUID (Globally Unique Identifier)
  static String generateGuid() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0F) | 0x40; // Version 4
    bytes[8] = (bytes[8] & 0x3F) | 0x80; // Variant 1

    final hexDigits = '0123456789abcdef';
    final uuid = StringBuffer();
    for (int i = 0; i < 16; i++) {
      uuid.write(hexDigits[(bytes[i] & 0xF0) >> 4]);
      uuid.write(hexDigits[bytes[i] & 0x0F]);
      if (i == 3 || i == 5 || i == 7 || i == 9) {
        uuid.write('-');
      }
    }
    return uuid.toString();
  }

// ULID (Universally Unique Lexicographically Sortable Identifier)
  static String generateUlid() {
    const alphabet = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
    final random = Random.secure();
    final timePart = DateTime.now()
        .millisecondsSinceEpoch
        .toRadixString(36)
        .padLeft(10, '0');
    final randPart =
        List.generate(16, (_) => alphabet[random.nextInt(32)]).join();
    return '$timePart$randPart';
  }

  static int generateSnowflakeId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (timestamp < _snowflakeLastTimestamp) {
      throw StateError(
          'Clock is moving backwards. Rejecting requests until $_snowflakeLastTimestamp.');
    }

    if (timestamp == _snowflakeLastTimestamp) {
      _snowflakeSequence = (_snowflakeSequence + 1) & 0xFFF;
      if (_snowflakeSequence == 0) {
        _snowflakeLastTimestamp = tilNextMillis(_snowflakeLastTimestamp);
      }
    } else {
      _snowflakeSequence = 0;
    }

    _snowflakeLastTimestamp = timestamp;

    return ((timestamp - 1609459200000) << 22) |
        (_snowflakeDatacenterId << 17) |
        (_snowflakeWorkerId << 12) |
        _snowflakeSequence;
  }

  static int tilNextMillis(int lastTimestamp) {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    while (timestamp <= lastTimestamp) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    }
    return timestamp;
  }

// Hash-Based ID
  static String generateHashBasedId(String input) {
    return input.hashCode.toRadixString(16);
  }

// Nano ID
  static String generateNanoId({int size = 21}) {
    const alphabet =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        size, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))));
  }

  // UDID (Unique Device Identifier).
  static String generateUDID() {
    Random random = Random();
    String udid = '';
    for (int i = 0; i < 32; i++) {
      udid += random.nextInt(16).toRadixString(16);
    }
    return udid;
  }

// Random String ID
  static String generateRandomStringId({int size = 10}) {
    const alphabet =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        size, (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length))));
  }

// Timestamp ID
  static String generateTimestampId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

// Secure Random ID
  static String generateSecureRandomId({int size = 16}) {
    final random = Random.secure();
    final values = List<int>.generate(size, (_) => random.nextInt(256));
    return values.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  }

// Composite ID
  static String generateCompositeId() {
    final timestampId = generateTimestampId();
    final randomStringId = generateRandomStringId();
    return '$timestampId-$randomStringId';
  }

// Collision-Resistant ID
  static String generateCollisionResistantId(String input) {
    return input.hashCode.toUnsigned(32).toRadixString(16);
  }

// Distributed ID
  static String generateDistributedId() {
    final uniqueId = UniqueKey().toString();
    final randomStringId = generateRandomStringId();
    return '$uniqueId-$randomStringId';
  }

// Secure Hash ID
  static String generateSecureHashId() {
    final secureRandomId = generateSecureRandomId();
    return secureRandomId.hashCode.toUnsigned(32).toRadixString(16);
  }

// Cluster ID
  static String generateClusterId(String clusterName) {
    final timestampId = generateTimestampId();
    return '$clusterName-$timestampId';
  }

// Consistent Hash ID
  static String generateConsistentHashId(String input) {
    return input.hashCode.toUnsigned(32).toRadixString(16);
  }

// Time-based ID
  static String generateTimeBasedId() {
    final timestampId = generateTimestampId();
    final randomStringId = generateRandomStringId();
    return '$timestampId-$randomStringId';
  }

// Unique Key ID
  static String generateUniqueKeyId(String key) {
    final timestampId = generateTimestampId();
    return '$key-$timestampId';
  }

// Permutation ID
  static String generatePermutationId(List<String> elements) {
    final shuffledElements = elements.toList()..shuffle();
    return shuffledElements.join('-');
  }

// Secure Timestamp ID
  static String generateSecureTimestampId() {
    final secureRandomId = generateSecureRandomId();
    final timestampId = generateTimestampId();
    return '$secureRandomId-$timestampId';
  }

  // generate random institute name like   'Massachusetts Institute of Technology (MIT), USA',
  static String generateWorldwideEducationInstitutes() {
    return getRandomItem(institutes);
  }

  static String generateRandomPhoneNumber() {
    final random = Random();
    final areaCode =
        100 + random.nextInt(900); // Generate a random 3-digit area code
    final exchangeCode =
        100 + random.nextInt(900); // Generate a random 3-digit exchange code
    final subscriberNumber = 1000 +
        random.nextInt(9000); // Generate a random 4-digit subscriber number
    return '(${areaCode.toString().padLeft(3, '0')}) ${exchangeCode.toString().padLeft(3, '0')}-${subscriberNumber.toString().padLeft(4, '0')}';
  }

  static String generateSlugId(String inputValue) {
    // Convert input to lowercase and replace spaces with dashes
    String slug = inputValue.toLowerCase().replaceAll(' ', '-');

    // Remove any special characters or symbols
    slug = slug.replaceAll(RegExp(r'[^a-z0-9-]'), '');

    // Trim dashes from the start and end of the slug
    slug = slug.replaceAll(RegExp(r'(^-+)|(-+$)'), '');

    // Add a random suffix for uniqueness
    final randomSuffix =
        DateTime.now().millisecondsSinceEpoch.toRadixString(36).substring(4);
    slug = '$slug-$randomSuffix';

    return slug;
  }

  static int generateFlakeUuid(int workerId) {
    final flakeUuid = FlakeUuid(workerId);
    return flakeUuid.generate();
  }

  static String generateXid() {
    final xidGenerator = XidGenerator();
    return xidGenerator.generate();
  }

  String generateUuidv6() {
    final random = Random();

    // Generate a 48-bit timestamp (milliseconds since epoch)
    final milliseconds = DateTime.now().millisecondsSinceEpoch;
    final timestamp = Uint8List(6)
      ..buffer.asByteData().setInt64(0, milliseconds, Endian.big);

    // Generate a 16-bit random value for the clock sequence
    final clockSequence = Uint8List(2)
      ..buffer.asByteData().setUint16(0, random.nextInt(0xFFFF), Endian.big);

    // Generate a 48-bit node identifier (random)
    final node = Uint8List(6);
    for (int i = 0; i < 6; i++) {
      node[i] = random.nextInt(0xFF);
    }

    // Combine the timestamp, clock sequence, and node identifier
    final bytes = Uint8List.fromList([...timestamp, ...clockSequence, ...node]);

    // Convert the bytes to a hexadecimal string
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  }
}
