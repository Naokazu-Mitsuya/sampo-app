import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'emoji_bottom_sheet_model.dart';
export 'emoji_bottom_sheet_model.dart';

class EmojiBottomSheetWidget extends StatefulWidget {
  const EmojiBottomSheetWidget({
    Key? key,
    required this.contentRef,
  }) : super(key: key);

  final DocumentReference? contentRef;

  @override
  _EmojiBottomSheetWidgetState createState() => _EmojiBottomSheetWidgetState();
}

class _EmojiBottomSheetWidgetState extends State<EmojiBottomSheetWidget> {
  late EmojiBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmojiBottomSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 9.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Container(
                  width: 60.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F7F9),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 600.0,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height * 0.8,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7.0,
                        color: Color(0x5D000000),
                        offset: Offset(0.0, -2.0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 20.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final emoji = FFAppState()
                                        .emojilist
                                        .map((e) => e)
                                        .toList();
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: emoji.length,
                                      itemBuilder: (context, emojiIndex) {
                                        final emojiItem = emoji[emojiIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.outputReaction =
                                                await queryReactionRecordOnce(
                                              queryBuilder: (reactionRecord) =>
                                                  reactionRecord
                                                      .where('contentRef',
                                                          isEqualTo:
                                                              widget.contentRef)
                                                      .where('emoji',
                                                          isEqualTo: emojiItem),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            if (_model.outputReaction
                                                    ?.reference !=
                                                null) {
                                              if (_model
                                                      .outputReaction?.reactedBy
                                                      ?.contains(
                                                          currentUserReference) ==
                                                  true) {
                                                await _model
                                                    .outputReaction!.reference
                                                    .update({
                                                  'reacted_by':
                                                      FieldValue.arrayRemove([
                                                    currentUserReference
                                                  ]),
                                                  'count': FieldValue.increment(
                                                      -(1)),
                                                });
                                              } else {
                                                await _model
                                                    .outputReaction!.reference
                                                    .update({
                                                  'reacted_by':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ]),
                                                  'count':
                                                      FieldValue.increment(1),
                                                });
                                              }
                                            } else {
                                              await ReactionRecord.collection
                                                  .doc()
                                                  .set({
                                                ...createReactionRecordData(
                                                  emoji: emojiItem,
                                                  count: 1,
                                                  contentRef: widget.contentRef,
                                                ),
                                                'reacted_by': [
                                                  currentUserReference
                                                ],
                                              });
                                            }

                                            Navigator.pop(context);

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Text(
                                              emojiItem,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 36.0,
                                                      ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
