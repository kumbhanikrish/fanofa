import 'package:bloc/bloc.dart';

mixin ListMixin<S extends Object?> on BlocBase<S> {
  List<T> appendList<T>(Iterable<T> initialList, Iterable<T> list) {
    return List.from(initialList)..addAll(list);
  }

  List<T> insertItemAt<T>(Iterable<T> initialList, T item, int index) {
    return List.from(initialList)..insert(index, item);
  }

  List<T> replaceItemAt<T>(List<T> initialList, int index, T item) {
    return List.from(initialList)..[index] = item;
  }

  List<T> removeAt<T>(List<T> initialList, int index) {
    return List.from(initialList)..removeAt(index);
  }
}
