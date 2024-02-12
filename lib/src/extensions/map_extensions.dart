// ignore_for_file: inference_failure_on_collection_literal

import 'package:cloud_firestore/cloud_firestore.dart';

extension MapExtensions on Map<String, dynamic> {
  T? getValueOrNull<T>(String key) {
    if (!containsKey(key)) {
      return null;
    }

    if (this[key] is! T) {
      if (T == String) {
        return '' as T;
      } else if (T == int) {
        return 0 as T;
      } else if (T == double) {
        return 0.0 as T;
      } else if (T == num) {
        return 0 as T;
      } else if (T == bool) {
        return false as T;
      } else if (T == Map) {
        return {} as T;
      } else if (T == List) {
        return [] as T;
      } else if (T == Timestamp) {
        return Timestamp.now() as T;
      } else {
        return null as T;
      }
    }

    return this[key] as T;
  }

  T getValueOrDefault<T>(String key, T defaultValue) {
    if (!containsKey(key) || this[key] == null) {
      return defaultValue;
    }

    if (this[key] is! T) {
      if (T == String) {
        return '' as T;
      } else if (T == int) {
        return 0 as T;
      } else if (T == double) {
        return 0.0 as T;
      } else if (T == num) {
        return 0 as T;
      } else if (T == bool) {
        return false as T;
      } else if (T == Map) {
        return {} as T;
      } else if (T == List) {
        return [] as T;
      } else if (T == Timestamp) {
        return Timestamp.now() as T;
      } else {
        return null as T;
      }
    }

    return this[key] as T;
  }
}
