// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'Round food for every mood';

  @override
  String get getStarted => 'Let\'s get started';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log in';

  @override
  String get legalAgreement =>
      'By continuing, you acknowledge that you have read and agree to our Terms of Use and Privacy Policy.';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get phoneTitle => 'Enter your phone number';

  @override
  String get otpTitle => 'Verify your number';

  @override
  String otpSent(String phone) {
    return 'We\'ve sent 6 digit OTP to $phone';
  }

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String resendIn(String time) {
    return 'resend in $time min';
  }

  @override
  String get nameTitle => 'What\'s your name?';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dobTitle => 'What\'s your date of birth?';

  @override
  String get continueLabel => 'Continue';

  @override
  String get welcomeTitle => 'Welcome to the world of J\'donuts';

  @override
  String get letsExplore => 'Let\'s explore';

  @override
  String pointsLeftToTier(int n, String tier) {
    return '$n points left to become $tier Member';
  }

  @override
  String get seasonalSpecials => 'Seasonal specials';

  @override
  String get popular => 'Popular';

  @override
  String get orderAgain => 'Order again';

  @override
  String nearbyShops(int n) {
    return 'There are $n J\'Donut shops near you.';
  }

  @override
  String get exploreNow => 'Explore now';

  @override
  String get orderOnline => 'Order Online';

  @override
  String tierMember(String tier) {
    return '$tier member';
  }

  @override
  String get newBadge => 'New';

  @override
  String get whatsThis => 'What\'s this?';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get rewardsTitle => 'J\' Donuts Rewards';

  @override
  String get rewards => 'Rewards';

  @override
  String get totalPoints => 'Total points';

  @override
  String get eatMoreEarnMore => 'Eat more earn more';

  @override
  String get gift => 'Gift';

  @override
  String get earn => 'EARN';

  @override
  String points(int n) {
    return '$n pts';
  }

  @override
  String get youreHereNow => 'You\'re here now';

  @override
  String pointsRemainingToTier(int n, String tier) {
    return '$n pts Remaining to become $tier';
  }

  @override
  String get youllBeHereSoon => 'You\'ll be here soon';

  @override
  String get homeTab => 'Home';

  @override
  String get rewardTab => 'Reward';
}
