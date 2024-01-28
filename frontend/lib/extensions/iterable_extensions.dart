part of 'extensions.dart';

typedef SeparatorBuilder<T> = T Function(({int prev, int next}) between);

extension IterableExtensions<E> on Iterable<E> {
  List<E> separated<T extends E>(SeparatorBuilder<T> separatorBuilder) {
    final elements = toList();
    final result = <E>[];

    for (var i = 0; i < length; i++) {
      final element = elements[i];
      final separator = separatorBuilder((prev: i, next: i + 1));

      result.add(element);
      if (i < length - 1) result.add(separator);
    }

    return result;
  }
}
