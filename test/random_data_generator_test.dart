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

  group('RandomData', () {
    test('generateChecksumId generates correct checksum', () {
      // Arrange
      final id = 'test';
      final expectedChecksum = id.codeUnits.fold(0, (a, b) => a + b) % 256;

      // Act
      final result = RandomData.generateChecksumId(id);

      // Assert
      expect(result.endsWith('-$expectedChecksum'), isTrue);
    });

    test('generateChecksumId handles empty input', () {
      // Arrange
      final id = '';

      // Act
      final result = RandomData.generateChecksumId(id);

      // Assert
      expect(result, equals('-0'));
    });
  });
}
