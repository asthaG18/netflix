import 'dart:async';

abstract class Bloc<T> {
  late T _state;
  final StreamController<T> _streamController = StreamController<T>.broadcast();

  Stream<T>? get strem => _streamController.stream;
  T get state => _state;

  Bloc() {
    _state = initDefaultValue();
    _streamController.sink.add(_state);
  }

  T initDefaultValue();

  void emit(T data) {
    if (!_streamController.isClosed) {
      _state = data;
      _streamController.sink.add(data);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
