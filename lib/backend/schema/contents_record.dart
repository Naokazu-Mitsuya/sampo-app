import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContentsRecord extends FirestoreRecord {
  ContentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "time_stamp" field.
  DateTime? _timeStamp;
  DateTime? get timeStamp => _timeStamp;
  bool hasTimeStamp() => _timeStamp != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "post_user" field.
  DocumentReference? _postUser;
  DocumentReference? get postUser => _postUser;
  bool hasPostUser() => _postUser != null;

  // "likes" field.
  List<DocumentReference>? _likes;
  List<DocumentReference> get likes => _likes ?? const [];
  bool hasLikes() => _likes != null;

  // "reactions" field.
  List<DocumentReference>? _reactions;
  List<DocumentReference> get reactions => _reactions ?? const [];
  bool hasReactions() => _reactions != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _timeStamp = snapshotData['time_stamp'] as DateTime?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _postUser = snapshotData['post_user'] as DocumentReference?;
    _likes = getDataList(snapshotData['likes']);
    _reactions = getDataList(snapshotData['reactions']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contents');

  static Stream<ContentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContentsRecord.fromSnapshot(s));

  static Future<ContentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContentsRecord.fromSnapshot(s));

  static ContentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContentsRecordData({
  String? title,
  String? description,
  DateTime? timeStamp,
  String? photoUrl,
  DocumentReference? postUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'time_stamp': timeStamp,
      'photo_url': photoUrl,
      'post_user': postUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContentsRecordDocumentEquality implements Equality<ContentsRecord> {
  const ContentsRecordDocumentEquality();

  @override
  bool equals(ContentsRecord? e1, ContentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.timeStamp == e2?.timeStamp &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.postUser == e2?.postUser &&
        listEquality.equals(e1?.likes, e2?.likes) &&
        listEquality.equals(e1?.reactions, e2?.reactions);
  }

  @override
  int hash(ContentsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.timeStamp,
        e?.photoUrl,
        e?.postUser,
        e?.likes,
        e?.reactions
      ]);

  @override
  bool isValidKey(Object? o) => o is ContentsRecord;
}
