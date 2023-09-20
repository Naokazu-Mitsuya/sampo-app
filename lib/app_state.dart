import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<String> _emojilist = [
    '🥰',
    '😍',
    '👏',
    '👍',
    '😅',
    '😂',
    '💦',
    '😎',
    '😱',
    '🤤'
  ];
  List<String> get emojilist => _emojilist;
  set emojilist(List<String> _value) {
    _emojilist = _value;
  }

  void addToEmojilist(String _value) {
    _emojilist.add(_value);
  }

  void removeFromEmojilist(String _value) {
    _emojilist.remove(_value);
  }

  void removeAtIndexFromEmojilist(int _index) {
    _emojilist.removeAt(_index);
  }

  void updateEmojilistAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _emojilist[_index] = updateFn(_emojilist[_index]);
  }

  void insertAtIndexInEmojilist(int _index, String _value) {
    _emojilist.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
