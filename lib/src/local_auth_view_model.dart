import 'dart:math';

import 'package:stacked/stacked.dart';

const String _NumbersStreamKey = 'numbers-stream';
const String _StringStreamKey = 'string-stream';

class LocalAuthViewModel extends MultipleStreamViewModel {
  int _numbersStreamDelay = 500;
  int _stringStreamDelay = 2000;
  bool _numberStreamRunning = true;

  String get numberStringText => 'The random number is ${dataMap?[_NumbersStreamKey] ?? 'stream not ready'}';

  @override
  Map<String, StreamData> get streamsMap => {
    _NumbersStreamKey: StreamData<int>(_numbersStream(_numbersStreamDelay)),
    _StringStreamKey: StreamData<String>(_stringStream(_stringStreamDelay)),
  };

  Stream<int> _numbersStream([int delay = 500]) async* {
    var random = Random();
    while (_numberStreamRunning) {
      await Future.delayed(Duration(milliseconds: delay));
      yield random.nextInt(999);
    }
  }

  Stream<String> _stringStream([int delay = 2000]) async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: delay));
      var randomLength = random.nextInt(50);
      var randomString = '';
      for (var i = 0; i < randomLength; i++) {
        randomString += String.fromCharCode(random.nextInt(50));
      }
      yield randomString;
    }
  }

  void cancelNumberString() {
    _numberStreamRunning = false;
  }
}