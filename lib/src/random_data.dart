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
    return "INV${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generatePhoneNumberVerificationCode() {
    final random = Random();
    return random.nextInt(999999).toString().padLeft(6, '0');
  }

  static String generateDocumentNumber() {
    final random = Random();
    return "DOC${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generateTrackingNumber() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "TRK${DateTime.now().year}${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateEmployeeId() {
    final random = Random();
    return "EMP${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generateOrderNumber() {
    final random = Random();
    return "ORD${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generateAccountNumber() {
    final random = Random();
    return "ACC${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generateTransactionId() {
    final random = Random();
    return "TXN${DateTime.now().year}${random.nextInt(9999).toString().padLeft(4, '0')}";
  }

  static String generateCouponCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "COUPON${String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateVoucherCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "VOUCHER${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateDiscountCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "DISCOUNT${String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generatePromoCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "PROMO${String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateReferralCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "REF${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateVerificationCode() {
    final random = Random();
    return random.nextInt(999999).toString().padLeft(6, '0');
  }

  static String generateTrackingCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "TRACK${String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
  }

  static String generateAuthCode() {
    const chars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    return "AUTH${String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))))}";
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

  static DateTime randomDateInRange(DateTime start, DateTime end) {
    final random = Random();
    final range = end.difference(start).inDays;
    return start.add(Duration(days: random.nextInt(range)));
  }

  static DateTime randomDateInPast() {
    final random = Random();
    final days = random.nextInt(365 * 100); // 100 years
    return DateTime.now().subtract(Duration(days: days));
  }

  static DateTime randomDateInFuture() {
    final random = Random();
    final days = random.nextInt(365 * 100); // 100 years
    return DateTime.now().add(Duration(days: days));
  }

  static DateTime randomDateTime() {
    final random = Random();
    final days = random.nextInt(365 * 100); // 100 years
    final randomDuration = Duration(
        days: days,
        hours: random.nextInt(24),
        minutes: random.nextInt(60),
        seconds: random.nextInt(60));
    return DateTime.now().subtract(randomDuration);
  }

  static String formatDate(DateTime date, String format) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String randomDateInRangeFormatted(
      DateTime start, DateTime end, String format) {
    final randomDate = randomDateInRange(start, end);
    return formatDate(randomDate, format);
  }

  static String randomDateInPastFormatted(String format) {
    final randomDate = randomDateInPast();
    return formatDate(randomDate, format);
  }

  static String randomDateInFutureFormatted(String format) {
    final randomDate = randomDateInFuture();
    return formatDate(randomDate, format);
  }

  static String randomDateTimeFormatted(String format) {
    final randomDateTimeValue = randomDateTime();
    return '${formatDate(randomDateTimeValue, format)} ${formatTimeOfDay(TimeOfDay(hour: randomDateTimeValue.hour, minute: randomDateTimeValue.minute))}';
  }

  static String randomDateInRangeAsString(DateTime start, DateTime end) {
    final randomDate = Random().nextInt(end.difference(start).inDays);
    return start.add(Duration(days: randomDate)).toString();
  }

  static String randomDateInPastAsString() {
    final randomDays = Random().nextInt(365 * 100); // 100 years
    final pastDate = DateTime.now().subtract(Duration(days: randomDays));
    return pastDate.toString();
  }

  static String randomDateInFutureAsString() {
    final randomDays = Random().nextInt(365 * 100); // 100 years
    final futureDate = DateTime.now().add(Duration(days: randomDays));
    return futureDate.toString();
  }

  static String randomTimeOfDayAsString() {
    final randomTime =
        TimeOfDay(hour: Random().nextInt(24), minute: Random().nextInt(60));
    return randomTime.toString();
  }

  static String randomDateTimeAsString() {
    final randomDays = Random().nextInt(365 * 100); // 100 years
    final randomTime =
        TimeOfDay(hour: Random().nextInt(24), minute: Random().nextInt(60));
    final randomDateTime = DateTime.now().subtract(Duration(
        days: randomDays, hours: randomTime.hour, minutes: randomTime.minute));
    return randomDateTime.toString();
  }

  static String randomDateInRangeFormattedAsString(
      DateTime start, DateTime end, String format) {
    final randomDate = Random().nextInt(end.difference(start).inDays);
    final formattedDate = start.add(Duration(days: randomDate)).toString();
    return formatDateTimeString(formattedDate, format);
  }

  static String randomDateInPastFormattedAsString(String format) {
    final randomDays = Random().nextInt(365 * 100); // 100 years
    final pastDate = DateTime.now().subtract(Duration(days: randomDays));
    return formatDateTimeString(pastDate.toString(), format);
  }

  static String randomDateInFutureFormattedAsString(String format) {
    final randomDays = Random().nextInt(365 * 100); // 100 years
    final futureDate = DateTime.now().add(Duration(days: randomDays));
    return formatDateTimeString(futureDate.toString(), format);
  }

  static String randomTimeOfDayFormattedAsString(String format) {
    final randomTime =
        TimeOfDay(hour: Random().nextInt(24), minute: Random().nextInt(60));
    return formatDateTimeString(randomTime.toString(), format);
  }

  static String randomDateTimeFormattedAsString(String format) {
    final randomDays = Random().nextInt(365 * 100); // 100 years
    final randomTime =
        TimeOfDay(hour: Random().nextInt(24), minute: Random().nextInt(60));
    final randomDateTime = DateTime.now().subtract(Duration(
        days: randomDays, hours: randomTime.hour, minutes: randomTime.minute));
    return formatDateTimeString(randomDateTime.toString(), format);
  }

  static String formatDateTimeString(String dateTimeString, String format) {
    final dateTime = DateTime.parse(dateTimeString);
    return '${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  static String getRandomDateTime_yyyy_MM_dd() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy-MM-dd');
  }

  static String getRandomDateTime_yyyy_slash_MM_slash_dd() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy/MM/dd');
  }

  static String getRandomDateTime_MM_slash_dd_slash_yyyy() {
    return _formatDateTime(_getRandomDateTime(), 'MM/dd/yyyy');
  }

  static String getRandomDateTime_yyyyMMdd() {
    return _formatDateTime(_getRandomDateTime(), 'yyyyMMdd');
  }

  static String getRandomDateTime_HH_colon_mm_colon_ss() {
    return _formatDateTime(_getRandomDateTime(), 'HH:mm:ss');
  }

  static String getRandomDateTime_hh_colon_mm_colon_ss_a() {
    return _formatDateTime(_getRandomDateTime(), 'hh:mm:ss a');
  }

  static String getRandomDateTime_yyyy_MM_dd_HH_colon_mm_colon_ss() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy-MM-dd HH:mm:ss');
  }

  static String
      getRandomDateTime_yyyy_slash_MM_slash_dd_HH_colon_mm_colon_ss() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy/MM/dd HH:mm:ss');
  }

  static String
      getRandomDateTime_MM_slash_dd_slash_yyyy_HH_colon_mm_colon_ss() {
    return _formatDateTime(_getRandomDateTime(), 'MM/dd/yyyy HH:mm:ss');
  }

  static String getRandomDateTime_yyyyMMddHHmmss() {
    return _formatDateTime(_getRandomDateTime(), 'yyyyMMddHHmmss');
  }

  static String getRandomDateTime_yyMMddHHmmss() {
    return _formatDateTime(_getRandomDateTime(), 'yyMMddHHmmss');
  }

  static String getRandomDateTime_yyyy_MM_dd_hh_colon_mm_colon_ss_a() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy-MM-dd hh:mm:ss a');
  }

  static String
      getRandomDateTime_yyyy_slash_MM_slash_dd_hh_colon_mm_colon_ss_a() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy/MM/dd hh:mm:ss a');
  }

  static String
      getRandomDateTime_MM_slash_dd_slash_yyyy_hh_colon_mm_colon_ss_a() {
    return _formatDateTime(_getRandomDateTime(), 'MM/dd/yyyy hh:mm:ss a');
  }

  static String getRandomDateTime_MMddyyyy() {
    return _formatDateTime(_getRandomDateTime(), 'MMddyyyy');
  }

  static String getRandomDateTime_dd_MM_yyyy() {
    return _formatDateTime(_getRandomDateTime(), 'dd-MM-yyyy');
  }

  static String getRandomDateTime_HHmmss() {
    return _formatDateTime(_getRandomDateTime(), 'HHmmss');
  }

  static String getRandomDateTime_HH_colon_mm_colon_ss_dot_SSS() {
    return _formatDateTime(_getRandomDateTime(), 'HH:mm:ss.SSS');
  }

  static String getRandomDateTime_HH_colon_mm_colon_ss_dot_SSS_Z() {
    return _formatDateTime(_getRandomDateTime(), 'HH:mm:ss.SSSZ');
  }

  static String getRandomDateTime_yyyy_MM_ddTHH_colon_mm_colon_ss() {
    return _formatDateTime(_getRandomDateTime(), 'yyyy-MM-ddTHH:mm:ss');
  }

  static DateTime _getRandomDateTime() {
    final random = Random();
    return DateTime(
      random.nextInt(3000),
      // Year
      random.nextInt(12) + 1,
      // Month (1-12)
      random.nextInt(28) + 1,
      // Day (1-28)
      random.nextInt(24),
      // Hour (0-23)
      random.nextInt(60),
      // Minute (0-59)
      random.nextInt(60),
      // Second (0-59)
      random.nextInt(1000), // Millisecond (0-999)
    );
  }

  static String _formatDateTime(DateTime dateTime, String format) {
    return format
        .replaceAll('yyyy', dateTime.year.toString().padLeft(4, '0'))
        .replaceAll('yy', dateTime.year.toString().substring(2).padLeft(2, '0'))
        .replaceAll('MM', dateTime.month.toString().padLeft(2, '0'))
        .replaceAll('dd', dateTime.day.toString().padLeft(2, '0'))
        .replaceAll('HH', dateTime.hour.toString().padLeft(2, '0'))
        .replaceAll(
            'hh',
            (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour)
                .toString()
                .padLeft(2, '0'))
        .replaceAll('mm', dateTime.minute.toString().padLeft(2, '0'))
        .replaceAll('ss', dateTime.second.toString().padLeft(2, '0'))
        .replaceAll('SSS', dateTime.millisecond.toString().padLeft(3, '0'))
        .replaceAll('a', dateTime.hour < 12 ? 'AM' : 'PM');
  }

  static String getRandomDate_yyyy_MM_dd() {
    return _formatDate(_getRandomDate(), 'yyyy-MM-dd');
  }

  static String getRandomDate_yyyy_slash_MM_slash_dd() {
    return _formatDate(_getRandomDate(), 'yyyy/MM/dd');
  }

  static String getRandomDate_MM_slash_dd_slash_yyyy() {
    return _formatDate(_getRandomDate(), 'MM/dd/yyyy');
  }

  static String getRandomDate_yyyyMMdd() {
    return _formatDate(_getRandomDate(), 'yyyyMMdd');
  }

  static String getRandomDate_MMddyyyy() {
    return _formatDate(_getRandomDate(), 'MMddyyyy');
  }

  static String getRandomDate_dd_MM_yyyy() {
    return _formatDate(_getRandomDate(), 'dd-MM-yyyy');
  }

  static String getRandomDate_yyMMdd() {
    return _formatDate(_getRandomDate(), 'yyMMdd');
  }

  static String getRandomDate_yyyy_MM_ddTHH_colon_mm_colon_ss() {
    return _formatDate(_getRandomDate(), 'yyyy-MM-ddTHH:mm:ss');
  }

  static String getRandomDate_yyyy_MM_ddTHHmmss() {
    return _formatDate(_getRandomDate(), 'yyyy-MM-ddTHHmmss');
  }

  static String getRandomDate_yyyy_MM_dd_hh_colon_mm_colon_ss_a() {
    return _formatDate(_getRandomDate(), 'yyyy-MM-dd hh:mm:ss a');
  }

  static String getRandomTime_HH_colon_mm_colon_ss() {
    return _formatTime(_getRandomTime(), 'HH:mm:ss');
  }

  static String getRandomTime_hh_colon_mm_colon_ss_a() {
    return _formatTime(_getRandomTime(), 'hh:mm:ss a');
  }

  static String getRandomTime_HHmmss() {
    return _formatTime(_getRandomTime(), 'HHmmss');
  }

  static String getRandomTime_HH_colon_mm_colon_ss_dot_SSS() {
    return _formatTime(_getRandomTime(), 'HH:mm:ss.SSS');
  }

  static String getRandomTime_HH_colon_mm_colon_ss_dot_SSS_Z() {
    return _formatTime(_getRandomTime(), 'HH:mm:ss.SSSZ');
  }

  static String getRandomTime_yyyy_MM_ddTHH_colon_mm_colon_ss() {
    return _formatTime(_getRandomTime(), 'yyyy-MM-ddTHH:mm:ss');
  }

  static String getRandomTime_yyyy_MM_ddTHHmmss() {
    return _formatTime(_getRandomTime(), 'yyyy-MM-ddTHHmmss');
  }

  static String getRandomTime_yyyy_MM_dd_hh_colon_mm_colon_ss_a() {
    return _formatTime(_getRandomTime(), 'yyyy-MM-dd hh:mm:ss a');
  }

  static DateTime _getRandomDate() {
    final random = Random();
    return DateTime(
      random.nextInt(3000), // Year
      random.nextInt(12) + 1, // Month (1-12)
      random.nextInt(28) + 1, // Day (1-28)
    );
  }

  static DateTime _getRandomTime() {
    final random = Random();
    return DateTime(
      0,
      // Year
      0,
      // Month
      0,
      // Day
      random.nextInt(24),
      // Hour (0-23)
      random.nextInt(60),
      // Minute (0-59)
      random.nextInt(60),
      // Second (0-59)
      random.nextInt(1000), // Millisecond (0-999)
    );
  }

  static String _formatDate(DateTime date, String format) {
    return format
        .replaceAll('yyyy', date.year.toString().padLeft(4, '0'))
        .replaceAll('yy', date.year.toString().substring(2).padLeft(2, '0'))
        .replaceAll('MM', date.month.toString().padLeft(2, '0'))
        .replaceAll('dd', date.day.toString().padLeft(2, '0'));
  }

  static String _formatTime(DateTime time, String format) {
    return format
        .replaceAll('HH', time.hour.toString().padLeft(2, '0'))
        .replaceAll(
            'hh',
            (time.hour > 12 ? time.hour - 12 : time.hour)
                .toString()
                .padLeft(2, '0'))
        .replaceAll('mm', time.minute.toString().padLeft(2, '0'))
        .replaceAll('ss', time.second.toString().padLeft(2, '0'))
        .replaceAll('SSS', time.millisecond.toString().padLeft(3, '0'))
        .replaceAll('a', time.hour < 12 ? 'AM' : 'PM');
  }
}
