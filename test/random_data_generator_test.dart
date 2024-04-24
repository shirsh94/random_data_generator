import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_data_generator/random_data_generator.dart';

void main() {
  test('generateRandomEmail should return a valid email address', () {
    final randomData = TestRandomData();
    String email = randomData.randomEmail;
    debugPrint("email---$email");
    expect(email.contains('@'), true);
    expect(email.contains('.'), true);
    expect(email.split('@').length, 2);
    expect(email.split('@')[0].length, greaterThanOrEqualTo(1));
    expect(email.split('@')[1].length, greaterThanOrEqualTo(1));
  });
}
