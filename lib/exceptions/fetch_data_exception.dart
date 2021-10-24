class FetchDataException implements Exception {
  final String? _message;
  FetchDataException([this._message]);

  @override
  String toString() {
    if (_message == null) return 'Internet error';
    return _message!;
  }
}
