import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Localize on BuildContext {
  AppLocalizations? get localize => AppLocalizations.of(this);
}
