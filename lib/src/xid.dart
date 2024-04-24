import 'dart:typed_data';
import 'dart:math';

class XidGenerator {
  static const int _counterBits = 24;
  static const int _machineBits = 24;
  static const int _processBits = 16;

  static const int _counterMax = (1 << _counterBits) - 1;
  static const int _machineMax = (1 << _machineBits) - 1;
  static const int _processMax = (1 << _processBits) - 1;

  int _lastTimestamp = -1;
  int _counter = 0;

  String generate() {
    int timestamp = _currentMillis();
    if (timestamp < _lastTimestamp) {
      throw StateError(
          'Clock is moving backwards. Rejecting requests until $_lastTimestamp.');
    }

    if (timestamp == _lastTimestamp) {
      _counter = (_counter + 1) & _counterMax;
      if (_counter == 0) {
        timestamp = _tilNextMillis(_lastTimestamp);
      }
    } else {
      _counter = 0;
    }

    _lastTimestamp = timestamp;

    return _buildXid(timestamp);
  }

  int _currentMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  int _tilNextMillis(int lastTimestamp) {
    var timestamp = _currentMillis();
    while (timestamp <= lastTimestamp) {
      timestamp = _currentMillis();
    }
    return timestamp;
  }

  String _buildXid(int timestamp) {
    final random = Random();
    final machineId = random.nextInt(_machineMax);
    final processId = random.nextInt(_processMax);
    final idBytes = Uint8List(12);

    idBytes[0] = (timestamp >> 24) & 0xFF;
    idBytes[1] = (timestamp >> 16) & 0xFF;
    idBytes[2] = (timestamp >> 8) & 0xFF;
    idBytes[3] = timestamp & 0xFF;

    idBytes[4] = (machineId >> 16) & 0xFF;
    idBytes[5] = (machineId >> 8) & 0xFF;
    idBytes[6] = machineId & 0xFF;

    idBytes[7] = (processId >> 8) & 0xFF;
    idBytes[8] = processId & 0xFF;

    idBytes[9] = (_counter >> 16) & 0xFF;
    idBytes[10] = (_counter >> 8) & 0xFF;
    idBytes[11] = _counter & 0xFF;

    return Uint8List.fromList(idBytes)
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
