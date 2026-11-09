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
  String get legalAgreementPrefix =>
      'By continuing, you acknowledge that you have read and agree to our ';

  @override
  String get legalAgreementJoin => ' and ';

  @override
  String get legalAgreementSuffix => '.';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get placeholderActionMessage => 'This option isn\'t available yet.';

  @override
  String get phoneTitle => 'Enter your phone number';

  @override
  String get phoneHint => 'Phone number';

  @override
  String get phoneInvalid => 'Enter a valid Myanmar phone number.';

  @override
  String get phoneNotRegistered =>
      'This number isn\'t registered. Register instead.';

  @override
  String get phoneAlreadyRegistered =>
      'This number is already registered. Log in instead.';

  @override
  String get otpTitle => 'Verify your number';

  @override
  String otpSent(String phone) {
    return 'We\'ve sent 6 digit OTP to $phone';
  }

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String get resend => 'Resend code';

  @override
  String get otpWrong => 'That code is incorrect.';

  @override
  String get otpLocked => 'Too many attempts. Resend a new code to try again.';

  @override
  String get otpUnexpected =>
      'We couldn\'t verify that code. Please try again.';

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
  String get firstNameInvalid => 'Enter a valid first name.';

  @override
  String get lastNameInvalid => 'Enter a valid last name.';

  @override
  String get dobTitle => 'What\'s your date of birth?';

  @override
  String get month => 'Month';

  @override
  String get day => 'Day';

  @override
  String get year => 'Year';

  @override
  String get dobInvalid => 'Enter a valid date of birth.';

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

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settings => 'Settings';

  @override
  String get logOut => 'Log out';

  @override
  String get seedFailureTitle => 'We couldn\'t prepare the app';

  @override
  String get seedFailureMessage =>
      'Your app data couldn\'t be loaded. Please try again.';

  @override
  String get retry => 'Try again';
}
