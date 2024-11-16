import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

bool Function(S previous, S current) multiValueListener<B, S>(List<dynamic> Function(S state) selector) {
  return (previous, current) => !listEquals(selector(previous), selector(current));
}
