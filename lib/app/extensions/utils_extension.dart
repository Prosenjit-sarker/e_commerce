import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension UtilsExtension on BuildContext {
  TextTheme get textTheme => TextTheme.of(this);
  AppLocalizations get l10n => AppLocalizations.of(this);
}
