class FlakeUuid {
  static const int _timestampBits = 41;
  static const int _workerIdBits = 10;
  static const int _sequenceBits = 12;

  static const int _maxWorkerId = (1 << _workerIdBits) - 1;
  static const int _maxSequence = (1 << _sequenceBits) - 1;

  static const int _workerIdShift = _sequenceBits;
  static const int _timestampShift = _workerIdBits + _sequenceBits;

  int _lastTimestamp = -1;
  int _sequence = 0;

  int workerId;

  FlakeUuid(this.workerId) {
    if (workerId < 0 || workerId > _maxWorkerId) {
      throw ArgumentError('Worker ID must be between 0 and $_maxWorkerId');
    }
  }

  int generate() {
    int timestamp = _currentMillis();
    if (timestamp < _lastTimestamp) {
      throw StateError(
          'Clock is moving backwards. Rejecting requests until $_lastTimestamp.');
    }

    if (timestamp == _lastTimestamp) {
      _sequence = (_sequence + 1) & _maxSequence;
      if (_sequence == 0) {
        timestamp = _tilNextMillis(_lastTimestamp);
      }
    } else {
      _sequence = 0;
    }

    _lastTimestamp = timestamp;

    return ((timestamp << _timestampShift) & ((1 << 64) - 1)) |
    ((workerId << _workerIdShift) & ((1 << 64) - 1)) |
    (_sequence & _maxSequence);
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
}
