import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/contents/emoji_bottom_sheet/emoji_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reaction_slider_model.dart';
export 'reaction_slider_model.dart';

class ReactionSliderWidget extends StatefulWidget {
  const ReactionSliderWidget({
    Key? key,
    required this.reactions,
    required this.contentRef,
  }) : super(key: key);

  final List<DocumentReference>? reactions;
  final DocumentReference? contentRef;

  @override
  _ReactionSliderWidgetState createState() => _ReactionSliderWidgetState();
}

class _ReactionSliderWidgetState extends State<ReactionSliderWidget> {
  late ReactionSliderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReactionSliderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<List<ReactionRecord>>(
              stream: queryReactionRecord(
                queryBuilder: (reactionRecord) => reactionRecord
                    .where('contentRef', isEqualTo: widget.contentRef),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<ReactionRecord> listViewReactionRecordList =
                    snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: listViewReactionRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewReactionRecord =
                        listViewReactionRecordList[listViewIndex];
                    return Visibility(
                      visible: listViewReactionRecord.count != 0,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (listViewReactionRecord.reactedBy
                                    .contains(currentUserReference) ==
                                true) {
                              await listViewReactionRecord.reference.update({
                                'reacted_by': FieldValue.arrayRemove(
                                    [currentUserReference]),
                                'count': FieldValue.increment(-(1)),
                              });
                            } else {
                              await listViewReactionRecord.reference.update({
                                'reacted_by': FieldValue.arrayUnion(
                                    [currentUserReference]),
                                'count': FieldValue.increment(1),
                              });
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F7F9),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listViewReactionRecord.emoji,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16.0,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        listViewReactionRecord.count.toString(),
                                        '0',
                                      ),
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: EmojiBottomSheetWidget(
                        contentRef: widget.contentRef!,
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF5DB075),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Color(0xFFF4F7F9),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 18.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
