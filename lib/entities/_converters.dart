/// JsonConverters partagés par les entités sérialisées.
///
/// Préférer ces types aux conversions inline : ils centralisent la forme
/// du JSON et évitent les divergences entre entités (`Set<int>` encodé
/// différemment selon les classes par exemple).
library;

import 'package:json_annotation/json_annotation.dart';

/// `Duration` ↔ JSON `int` (millisecondes).
class DurationMsConverter implements JsonConverter<Duration, int> {
  const DurationMsConverter();
  @override
  Duration fromJson(int ms) => Duration(milliseconds: ms);
  @override
  int toJson(Duration d) => d.inMilliseconds;
}

/// `Duration?` ↔ JSON `int?` (millisecondes). `null`/négatif → `null`.
class NullableDurationMsConverter implements JsonConverter<Duration?, int?> {
  const NullableDurationMsConverter();
  @override
  Duration? fromJson(int? ms) =>
      (ms == null || ms < 0) ? null : Duration(milliseconds: ms);
  @override
  int? toJson(Duration? d) => d?.inMilliseconds;
}

/// `Set<int>` ↔ JSON `List<dynamic>`.
/// Utilisé pour `givens`, `revealedErrors`, `validatedCorrect`.
class IntSetConverter implements JsonConverter<Set<int>, List<dynamic>> {
  const IntSetConverter();
  @override
  Set<int> fromJson(List<dynamic> json) =>
      json.map((e) => (e as num).toInt()).toSet();
  @override
  List<int> toJson(Set<int> s) => s.toList();
}

/// `Map<int, Set<int>>` ↔ JSON `Map<String, dynamic>`.
/// Les clés `int` sont stringifiées (JSON ne supporte que `String` en clé).
/// Utilisé pour `notes`.
class NotesMapConverter
    implements JsonConverter<Map<int, Set<int>>, Map<String, dynamic>> {
  const NotesMapConverter();
  @override
  Map<int, Set<int>> fromJson(Map<String, dynamic> json) => json.map(
    (k, v) => MapEntry(
      int.parse(k),
      (v as List<dynamic>).map((e) => (e as num).toInt()).toSet(),
    ),
  );
  @override
  Map<String, dynamic> toJson(Map<int, Set<int>> m) =>
      m.map((k, v) => MapEntry(k.toString(), v.toList()));
}
