import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  test('loads English and Burmese translations with placeholders', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final burmese = await AppLocalizations.delegate.load(const Locale('my'));

    expect(english.continueLabel, 'Continue');
    expect(english.otpSent('+95912345678'), contains('+95912345678'));
    expect(burmese.continueLabel, 'ဆက်ရန်');
    expect(burmese.otpSent('+95912345678'), contains('+95912345678'));
  });
}
