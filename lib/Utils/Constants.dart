import 'package:flutter/material.dart';

import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Constants extends State {
  static bool showingHud = false;

  showHud({String message = "Loading..."}) {
    if (!showingHud) {
      final progress = ProgressHUD.of(context);
      progress?.showWithText(message);
      showingHud = true;
    }
  }

  dismissHud() {
    if (showingHud) {
      final progress = ProgressHUD.of(context);
      progress?.dismiss();
      showingHud = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
