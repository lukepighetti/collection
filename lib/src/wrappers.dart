// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:math' as math;

import 'unmodifiable_wrappers.dart';

/// A base class for delegating iterables.
///
/// Subclasses can provide a [base] that should be delegated to. Unlike
/// [DelegatingIterable], this allows the base to be created on demand.
abstract class _DelegatingIterableBase<E> implements Iterable<E> {
  Iterable<E> get base;

  const _DelegatingIterableBase();

  @override
  bool any(bool Function(E) test) => base.any(test);

  @override
  Iterable<T> cast<T>() => base.cast<T>();

  @override
  bool contains(Object? element) => base.contains(element);

  @override
  E elementAt(int index) => base.elementAt(index);

  @override
  bool every(bool Function(E) test) => base.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E) f) => base.expand(f);

  @override
  E get first => base.first;

  @override
  E firstWhere(bool Function(E) test, {E Function()? orElse}) =>
      base.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) =>
      base.fold(initialValue, combine);

  @override
  Iterable<E> followedBy(Iterable<E> other) => base.followedBy(other);

  @override
  void forEach(void Function(E) f) => base.forEach(f);

  @override
  bool get isEmpty => base.isEmpty;

  @override
  bool get isNotEmpty => base.isNotEmpty;

  @override
  Iterator<E> get iterator => base.iterator;

  @override
  String join([String separator = '']) => base.join(separator);

  @override
  E get last => base.last;

  @override
  E lastWhere(bool Function(E) test, {E Function()? orElse}) =>
      base.lastWhere(test, orElse: orElse);

  @override
  int get length => base.length;

  @override
  Iterable<T> map<T>(T Function(E) f) => base.map(f);

  @override
  E reduce(E Function(E value, E element) combine) => base.reduce(combine);

  @Deprecated("Use cast instead")
  Iterable<T> retype<T>() => cast<T>();

  @override
  E get single => base.single;

  @override
  E singleWhere(bool Function(E) test, {E Function()? orElse}) {
    return base.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<E> skip(int n) => base.skip(n);

  @override
  Iterable<E> skipWhile(bool Function(E) test) => base.skipWhile(test);

  @override
  Iterable<E> take(int n) => base.take(n);

  @override
  Iterable<E> takeWhile(bool Function(E) test) => base.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => base.toList(growable: growable);

  @override
  Set<E> toSet() => base.toSet();

  @override
  Iterable<E> where(bool Function(E) test) => base.where(test);

  @override
  Iterable<T> whereType<T>() => base.whereType<T>();

  @override
  String toString() => base.toString();
}

/// An [Iterable] that delegates all operations to a base iterable.
///
/// This class can be used to hide non-`Iterable` methods of an iterable object,
/// or it can be extended to add extra functionality on top of an existing
/// iterable object.
class DelegatingIterable<E> extends _DelegatingIterableBase<E> {
  @override
  final Iterable<E> base;

  /// Creates a wrapper that forwards operations to [base].
  const DelegatingIterable(this.base);

  /// Creates a wrapper that asserts the types of values in [base].
  ///
  /// This soundly converts an [Iterable] without a generic type to an
  /// `Iterable<E>` by asserting that its elements are instances of `E` whenever
  /// they're accessed. If they're not, it throws a [CastError].
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in [this]. If [base] is already an `Iterable<E>`, it's returned
  /// unmodified.
  @Deprecated('Use iterable.cast<E> instead.')
  static Iterable<E> typed<E>(Iterable base) => base.cast<E>();
}

/// A [List] that delegates all operations to a base list.
///
/// This class can be used to hide non-`List` methods of a list object, or it
/// can be extended to add extra functionality on top of an existing list
/// object.
class DelegatingList<E> extends _DelegatingIterableBase<E> implements List<E> {
  @override
  final List<E> base;

  const DelegatingList(this.base);

  /// Creates a wrapper that asserts the types of values in [base].
  ///
  /// This soundly converts a [List] without a generic type to a `List<E>` by
  /// asserting that its elements are instances of `E` whenever they're
  /// accessed. If they're not, it throws a [CastError]. Note that even if an
  /// operation throws a [CastError], it may still mutate the underlying
  /// collection.
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in [this]. If [base] is already a `List<E>`, it's returned
  /// unmodified.
  @Deprecated('Use list.cast<E> instead.')
  static List<E> typed<E>(List base) => base.cast<E>();

  @override
  E operator [](int index) => base[index];

  @override
  void operator []=(int index, E value) {
    base[index] = value;
  }

  @override
  List<E> operator +(List<E> other) => base + other;

  @override
  void add(E value) {
    base.add(value);
  }

  @override
  void addAll(Iterable<E> iterable) {
    base.addAll(iterable);
  }

  @override
  Map<int, E> asMap() => base.asMap();

  @override
  List<T> cast<T>() => base.cast<T>();

  @override
  void clear() {
    base.clear();
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    base.fillRange(start, end, fillValue);
  }

  @override
  set first(E value) {
    if (isEmpty) throw RangeError.index(0, this);
    this[0] = value;
  }

  @override
  Iterable<E> getRange(int start, int end) => base.getRange(start, end);

  @override
  int indexOf(E element, [int start = 0]) => base.indexOf(element, start);

  @override
  int indexWhere(bool Function(E) test, [int start = 0]) =>
      base.indexWhere(test, start);

  @override
  void insert(int index, E element) {
    base.insert(index, element);
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    base.insertAll(index, iterable);
  }

  @override
  set last(E value) {
    if (isEmpty) throw RangeError.index(0, this);
    this[length - 1] = value;
  }

  @override
  int lastIndexOf(E element, [int? start]) => base.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(E) test, [int? start]) =>
      base.lastIndexWhere(test, start);

  @override
  set length(int newLength) {
    base.length = newLength;
  }

  @override
  bool remove(Object? value) => base.remove(value);

  @override
  E removeAt(int index) => base.removeAt(index);

  @override
  E removeLast() => base.removeLast();

  @override
  void removeRange(int start, int end) {
    base.removeRange(start, end);
  }

  @override
  void removeWhere(bool Function(E) test) {
    base.removeWhere(test);
  }

  @override
  void replaceRange(int start, int end, Iterable<E> iterable) {
    base.replaceRange(start, end, iterable);
  }

  @override
  void retainWhere(bool Function(E) test) {
    base.retainWhere(test);
  }

  @Deprecated("Use cast instead")
  @override
  List<T> retype<T>() => cast<T>();

  @override
  Iterable<E> get reversed => base.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) {
    base.setAll(index, iterable);
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    base.setRange(start, end, iterable, skipCount);
  }

  @override
  void shuffle([math.Random? random]) {
    base.shuffle(random);
  }

  @override
  void sort([int Function(E, E)? compare]) {
    base.sort(compare);
  }

  @override
  List<E> sublist(int start, [int? end]) => base.sublist(start, end);
}

/// A [Set] that delegates all operations to a base set.
///
/// This class can be used to hide non-`Set` methods of a set object, or it can
/// be extended to add extra functionality on top of an existing set object.
class DelegatingSet<E> extends _DelegatingIterableBase<E> implements Set<E> {
  @override
  final Set<E> base;

  const DelegatingSet(this.base);

  /// Creates a wrapper that asserts the types of values in [base].
  ///
  /// This soundly converts a [Set] without a generic type to a `Set<E>` by
  /// asserting that its elements are instances of `E` whenever they're
  /// accessed. If they're not, it throws a [CastError]. Note that even if an
  /// operation throws a [CastError], it may still mutate the underlying
  /// collection.
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in [this]. If [base] is already a `Set<E>`, it's returned
  /// unmodified.
  @Deprecated('Use set.cast<E> instead.')
  static Set<E> typed<E>(Set base) => base.cast<E>();

  @override
  bool add(E value) => base.add(value);

  @override
  void addAll(Iterable<E> elements) {
    base.addAll(elements);
  }

  @override
  Set<T> cast<T>() => base.cast<T>();

  @override
  void clear() {
    base.clear();
  }

  @override
  bool containsAll(Iterable<Object?> other) => base.containsAll(other);

  @override
  Set<E> difference(Set<Object?> other) => base.difference(other);

  @override
  Set<E> intersection(Set<Object?> other) => base.intersection(other);

  @override
  E? lookup(Object? element) => base.lookup(element);

  @override
  bool remove(Object? value) => base.remove(value);

  @override
  void removeAll(Iterable<Object?> elements) {
    base.removeAll(elements);
  }

  @override
  void removeWhere(bool Function(E) test) {
    base.removeWhere(test);
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    base.retainAll(elements);
  }

  @Deprecated("Use cast instead")
  @override
  Set<T> retype<T>() => cast<T>();

  @override
  void retainWhere(bool Function(E) test) {
    base.retainWhere(test);
  }

  @override
  Set<E> union(Set<E> other) => base.union(other);

  @override
  Set<E> toSet() => DelegatingSet<E>(base.toSet());
}

/// A [Queue] that delegates all operations to a base queue.
///
/// This class can be used to hide non-`Queue` methods of a queue object, or it
/// can be extended to add extra functionality on top of an existing queue
/// object.
class DelegatingQueue<E> extends _DelegatingIterableBase<E>
    implements Queue<E> {
  @override
  final Queue<E> base;

  const DelegatingQueue(Queue<E> queue) : base = queue;

  /// Creates a wrapper that asserts the types of values in [base].
  ///
  /// This soundly converts a [Queue] without a generic type to a `Queue<E>` by
  /// asserting that its elements are instances of `E` whenever they're
  /// accessed. If they're not, it throws a [CastError]. Note that even if an
  /// operation throws a [CastError], it may still mutate the underlying
  /// collection.
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in [this]. If [base] is already a `Queue<E>`, it's returned
  /// unmodified.
  @Deprecated('Use queue.cast<E> instead.')
  static Queue<E> typed<E>(Queue base) => base.cast<E>();

  @override
  void add(E value) {
    base.add(value);
  }

  @override
  void addAll(Iterable<E> iterable) {
    base.addAll(iterable);
  }

  @override
  void addFirst(E value) {
    base.addFirst(value);
  }

  @override
  void addLast(E value) {
    base.addLast(value);
  }

  @override
  Queue<T> cast<T>() => base.cast<T>();

  @override
  void clear() {
    base.clear();
  }

  @override
  bool remove(Object? object) => base.remove(object);

  @override
  void removeWhere(bool Function(E) test) {
    base.removeWhere(test);
  }

  @override
  void retainWhere(bool Function(E) test) {
    base.retainWhere(test);
  }

  @Deprecated("Use cast instead")
  @override
  Queue<T> retype<T>() => cast<T>();

  @override
  E removeFirst() => base.removeFirst();

  @override
  E removeLast() => base.removeLast();
}

/// A [Map] that delegates all operations to a base map.
///
/// This class can be used to hide non-`Map` methods of an object that extends
/// `Map`, or it can be extended to add extra functionality on top of an
/// existing map object.
class DelegatingMap<K, V> implements Map<K, V> {
  final Map<K, V> base;

  const DelegatingMap(this.base);

  /// Creates a wrapper that asserts the types of keys and values in [base].
  ///
  /// This soundly converts a [Map] without generic types to a `Map<K, V>` by
  /// asserting that its keys are instances of `E` and its values are instances
  /// of `V` whenever they're accessed. If they're not, it throws a [CastError].
  /// Note that even if an operation throws a [CastError], it may still mutate
  /// the underlying collection.
  ///
  /// This forwards all operations to [base], so any changes in [base] will be
  /// reflected in [this]. If [base] is already a `Map<K, V>`, it's returned
  /// unmodified.
  @Deprecated('Use map.cast<K, V> instead.')
  static Map<K, V> typed<K, V>(Map base) => base.cast<K, V>();

  @override
  V? operator [](Object? key) => base[key];

  @override
  void operator []=(K key, V value) {
    base[key] = value;
  }

  @override
  void addAll(Map<K, V> other) {
    base.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> entries) {
    base.addEntries(entries);
  }

  @override
  void clear() {
    base.clear();
  }

  @override
  Map<K2, V2> cast<K2, V2>() => base.cast<K2, V2>();

  @override
  bool containsKey(Object? key) => base.containsKey(key);

  @override
  bool containsValue(Object? value) => base.containsValue(value);

  @override
  Iterable<MapEntry<K, V>> get entries => base.entries;

  @override
  void forEach(void Function(K, V) f) {
    base.forEach(f);
  }

  @override
  bool get isEmpty => base.isEmpty;

  @override
  bool get isNotEmpty => base.isNotEmpty;

  @override
  Iterable<K> get keys => base.keys;

  @override
  int get length => base.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K, V) transform) =>
      base.map(transform);

  @override
  V putIfAbsent(K key, V Function() ifAbsent) =>
      base.putIfAbsent(key, ifAbsent);

  @override
  V? remove(Object? key) => base.remove(key);

  @override
  void removeWhere(bool Function(K, V) test) => base.removeWhere(test);

  @Deprecated("Use cast instead")
  Map<K2, V2> retype<K2, V2>() => cast<K2, V2>();

  @override
  Iterable<V> get values => base.values;

  @override
  String toString() => base.toString();

  @override
  V update(K key, V Function(V) update, {V Function()? ifAbsent}) =>
      base.update(key, update, ifAbsent: ifAbsent);

  @override
  void updateAll(V Function(K, V) update) => base.updateAll(update);
}

/// An unmodifiable [Set] view of the keys of a [Map].
///
/// The set delegates all operations to the underlying map.
///
/// A `Map` can only contain each key once, so its keys can always
/// be viewed as a `Set` without any loss, even if the [Map.keys]
/// getter only shows an [Iterable] view of the keys.
///
/// Note that [lookup] is not supported for this set.
class MapKeySet<E> extends _DelegatingIterableBase<E>
    with UnmodifiableSetMixin<E> {
  final Map<E, dynamic> baseMap;

  MapKeySet(this.baseMap);

  @override
  Iterable<E> get base => baseMap.keys;

  @override
  Set<T> cast<T>() {
    if (this is MapKeySet<T>) {
      return this as MapKeySet<T>;
    }
    return Set.castFrom<E, T>(this);
  }

  @override
  bool contains(Object? element) => baseMap.containsKey(element);

  @override
  bool get isEmpty => baseMap.isEmpty;

  @override
  bool get isNotEmpty => baseMap.isNotEmpty;

  @override
  int get length => baseMap.length;

  @override
  String toString() => SetBase.setToString(this);

  @override
  bool containsAll(Iterable<Object?> other) => other.every(contains);

  /// Returns a new set with the the elements of [this] that are not in [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] that are
  /// not elements of [other] according to `other.contains`.
  ///
  /// Note that the returned set will use the default equality operation, which
  /// may be different than the equality operation [this] uses.
  @override
  Set<E> difference(Set<Object?> other) =>
      where((element) => !other.contains(element)).toSet();

  /// Returns a new set which is the intersection between [this] and [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] that are
  /// also elements of [other] according to `other.contains`.
  ///
  /// Note that the returned set will use the default equality operation, which
  /// may be different than the equality operation [this] uses.
  @override
  Set<E> intersection(Set<Object?> other) => where(other.contains).toSet();

  /// Throws an [UnsupportedError] since there's no corresponding method for
  /// [Map]s.
  @override
  E lookup(Object? element) =>
      throw UnsupportedError("MapKeySet doesn't support lookup().");

  @Deprecated("Use cast instead")
  @override
  Set<T> retype<T>() => Set.castFrom<E, T>(this);

  /// Returns a new set which contains all the elements of [this] and [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] and all
  /// the elements of [other].
  ///
  /// Note that the returned set will use the default equality operation, which
  /// may be different than the equality operation [this] uses.
  @override
  Set<E> union(Set<E> other) => toSet()..addAll(other);
}

/// Creates a modifiable [Set] view of the values of a [Map].
///
/// The `Set` view assumes that the keys of the `Map` can be uniquely determined
/// from the values. The `keyForValue` function passed to the constructor finds
/// the key for a single value. The `keyForValue` function should be consistent
/// with equality. If `value1 == value2` then `keyForValue(value1)` and
/// `keyForValue(value2)` should be considered equal keys by the underlying map,
/// and vice versa.
///
/// Modifying the set will modify the underlying map based on the key returned
/// by `keyForValue`.
///
/// If the `Map` contents are not compatible with the `keyForValue` function,
/// the set will not work consistently, and may give meaningless responses or do
/// inconsistent updates.
///
/// This set can, for example, be used on a map from database record IDs to the
/// records. It exposes the records as a set, and allows for writing both
/// `recordSet.add(databaseRecord)` and `recordMap[id]`.
///
/// Effectively, the map will act as a kind of index for the set.
class MapValueSet<K, V> extends _DelegatingIterableBase<V> implements Set<V> {
  final Map<K, V> baseMap;
  final K Function(V) _keyForValue;

  /// Creates a new [MapValueSet] based on [baseMap].
  ///
  /// [_keyForValue] returns the key in the map that should be associated with
  /// the given value. The set's notion of equality is identical to the equality
  /// of the return values of [_keyForValue].
  MapValueSet(this.baseMap, this._keyForValue);

  @override
  Iterable<V> get base => baseMap.values;

  @override
  Set<T> cast<T>() {
    if (this is Set<T>) {
      return this as Set<T>;
    }
    return Set.castFrom<V, T>(this);
  }

  @override
  bool contains(Object? element) {
    if (element is! V) return false;
    var key = _keyForValue(element);

    return baseMap.containsKey(key);
  }

  @override
  bool get isEmpty => baseMap.isEmpty;

  @override
  bool get isNotEmpty => baseMap.isNotEmpty;

  @override
  int get length => baseMap.length;

  @override
  String toString() => toSet().toString();

  @override
  bool add(V value) {
    var key = _keyForValue(value);
    var result = false;
    baseMap.putIfAbsent(key, () {
      result = true;
      return value;
    });
    return result;
  }

  @override
  void addAll(Iterable<V> elements) => elements.forEach(add);

  @override
  void clear() => baseMap.clear();

  @override
  bool containsAll(Iterable<Object?> other) => other.every(contains);

  /// Returns a new set with the the elements of [this] that are not in [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] that are
  /// not elements of [other] according to `other.contains`.
  ///
  /// Note that the returned set will use the default equality operation, which
  /// may be different than the equality operation [this] uses.
  @override
  Set<V> difference(Set<Object?> other) =>
      where((element) => !other.contains(element)).toSet();

  /// Returns a new set which is the intersection between [this] and [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] that are
  /// also elements of [other] according to `other.contains`.
  ///
  /// Note that the returned set will use the default equality operation, which
  /// may be different than the equality operation [this] uses.
  @override
  Set<V> intersection(Set<Object?> other) => where(other.contains).toSet();

  @override
  V? lookup(Object? element) {
    if (element is! V) return null;
    var key = _keyForValue(element);

    return baseMap[key];
  }

  @override
  bool remove(Object? element) {
    if (element is! V) return false;
    var key = _keyForValue(element);

    if (!baseMap.containsKey(key)) return false;
    baseMap.remove(key);
    return true;
  }

  @override
  void removeAll(Iterable<Object?> elements) => elements.forEach(remove);

  @override
  void removeWhere(bool Function(V) test) {
    var toRemove = [];
    baseMap.forEach((key, value) {
      if (test(value)) toRemove.add(key);
    });
    toRemove.forEach(baseMap.remove);
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    var valuesToRetain = Set<V>.identity();
    for (var element in elements) {
      if (element is! V) continue;
      var key = _keyForValue(element);

      if (!baseMap.containsKey(key)) continue;
      valuesToRetain.add(baseMap[key] ?? null as V);
    }

    var keysToRemove = [];
    baseMap.forEach((k, v) {
      if (!valuesToRetain.contains(v)) keysToRemove.add(k);
    });
    keysToRemove.forEach(baseMap.remove);
  }

  @override
  void retainWhere(bool Function(V) test) =>
      removeWhere((element) => !test(element));

  @Deprecated("Use cast instead")
  @override
  Set<T> retype<T>() => Set.castFrom<V, T>(this);

  /// Returns a new set which contains all the elements of [this] and [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] and all
  /// the elements of [other].
  ///
  /// Note that the returned set will use the default equality operation, which
  /// may be different than the equality operation [this] uses.
  @override
  Set<V> union(Set<V> other) => toSet()..addAll(other);
}
