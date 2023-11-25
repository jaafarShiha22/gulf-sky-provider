extension IterableFirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    try {
      return firstWhere(test);
    } catch (_) {}
    return null;
  }

  E? get firstOrNull {
    try {
      return first;
    } catch (_) {}
    return null;
  }

  E? get lastOrNull {
    try {
      return last;
    } catch (_) {}
    return null;
  }
}

extension ListFirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    try {
      return firstWhere(test);
    } catch (_) {}
    return null;
  }

  E? get firstOrNull {
    try {
      return first;
    } catch (_) {}
    return null;
  }

  E? get lastOrNull {
    try {
      return last;
    } catch (_) {}
    return null;
  }
}
