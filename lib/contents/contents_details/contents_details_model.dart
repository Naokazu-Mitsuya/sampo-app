import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/contents/reaction_slider/reaction_slider_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContentsDetailsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for ReactionSlider component.
  late ReactionSliderModel reactionSliderModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    reactionSliderModel = createModel(context, () => ReactionSliderModel());
  }

  void dispose() {
    reactionSliderModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
