import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReactionRecord extends FirestoreRecord {
  ReactionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "emoji" field.
  String? _emoji;
  String get emoji => _emoji ?? '';
  bool hasEmoji() => _emoji != null;

  // "reacted_by" field.
  List<DocumentReference>? _reactedBy;
  List<DocumentReference> get reactedBy => _reactedBy ?? const [];
  bool hasReactedBy() => _reactedBy != null;

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  bool hasCount() => _count != null;

  // "contentRef" field.
  DocumentReference? _contentRef;
  DocumentReference? get contentRef => _contentRef;
  bool hasContentRef() => _contentRef != null;

  void _initializeFields() {
    _emoji = snapshotData['emoji'] as String?;
    _reactedBy = getDataList(snapshotData['reacted_by']);
    _count = castToType<int>(snapshotData['count']);
    _contentRef = snapshotData['contentRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reaction');

  static Stream<ReactionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReactionRecord.fromSnapshot(s));

  static Future<ReactionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReactionRecord.fromSnapshot(s));

  static ReactionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReactionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReactionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReactionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReactionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReactionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReactionRecordData({
  String? emoji,
  int? count,
  DocumentReference? contentRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'emoji': emoji,
      'count': count,
      'contentRef': contentRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReactionRecordDocumentEquality implements Equality<ReactionRecord> {
  const ReactionRecordDocumentEquality();

  @override
  bool equals(ReactionRecord? e1, ReactionRecord? e2) {
    const listEquality = ListEquality();
    return e1?.emoji == e2?.emoji &&
        listEquality.equals(e1?.reactedBy, e2?.reactedBy) &&
        e1?.count == e2?.count &&
        e1?.contentRef == e2?.contentRef;
  }

  @override
  int hash(ReactionRecord? e) => const ListEquality()
      .hash([e?.emoji, e?.reactedBy, e?.count, e?.contentRef]);

  @override
  bool isValidKey(Object? o) => o is ReactionRecord;
}
