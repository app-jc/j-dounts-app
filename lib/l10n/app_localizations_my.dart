// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'အရသာစုံလင်တဲ့ ဒိုးနတ်ဝိုင်းလေးများ';

  @override
  String get getStarted => 'စတင်လိုက်ကြစို့';

  @override
  String get alreadyHaveAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get logIn => 'ဝင်ရောက်ရန်';

  @override
  String get legalAgreement =>
      'ဆက်လက်လုပ်ဆောင်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ အသုံးပြုမှုစည်းမျဉ်းများနှင့် ကိုယ်ရေးအချက်အလက်မူဝါဒကို ဖတ်ရှုပြီး သဘောတူကြောင်း အသိအမှတ်ပြုပါသည်။';

  @override
  String get legalAgreementPrefix => 'ဆက်လက်လုပ်ဆောင်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ ';

  @override
  String get legalAgreementJoin => 'နှင့် ';

  @override
  String get legalAgreementSuffix =>
      'ကို ဖတ်ရှုပြီး သဘောတူကြောင်း အသိအမှတ်ပြုပါသည်။';

  @override
  String get termsOfUse => 'အသုံးပြုမှုစည်းမျဉ်းများ';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get continueWithGoogle => 'Google ဖြင့် ဆက်လက်ရန်';

  @override
  String get continueWithApple => 'Apple ဖြင့် ဆက်လက်ရန်';

  @override
  String get continueWithFacebook => 'Facebook ဖြင့် ဆက်လက်ရန်';

  @override
  String get placeholderActionMessage =>
      'ဤရွေးချယ်မှုကို မကြာမီ ရရှိနိုင်ပါမည်။';

  @override
  String get phoneTitle => 'သင့်ဖုန်းနံပါတ်ကို ရိုက်ထည့်ပါ';

  @override
  String get phoneHint => 'ဖုန်းနံပါတ်';

  @override
  String get phoneInvalid => 'မှန်ကန်သော မြန်မာဖုန်းနံပါတ်ကို ထည့်ပါ။';

  @override
  String get phoneNotRegistered =>
      'ဤနံပါတ်ကို မှတ်ပုံမတင်ရသေးပါ။ အကောင့်ဖွင့်ပါ။';

  @override
  String get phoneAlreadyRegistered =>
      'ဤနံပါတ်ကို မှတ်ပုံတင်ပြီးဖြစ်ပါသည်။ ဝင်ရောက်ပါ။';

  @override
  String get otpTitle => 'သင့်ဖုန်းနံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSent(String phone) {
    return 'ပို့ထားသော ဂဏန်း ၆ လုံး OTP သည် $phone သို့ ရောက်ရှိလာပါမည်';
  }

  @override
  String get didntReceiveCode => 'ကုဒ်မရရှိဘူးလား?';

  @override
  String get resend => 'ကုဒ်ကို ပြန်ပို့ရန်';

  @override
  String get otpWrong => 'ကုဒ် မှားယွင်းနေပါသည်။';

  @override
  String get otpLocked =>
      'ကြိုးစားမှုများလွန်းပါသည်။ ကုဒ်အသစ် ပြန်ပို့ပြီး ထပ်ကြိုးစားပါ။';

  @override
  String get otpUnexpected => 'ကုဒ်ကို အတည်မပြုနိုင်ပါ။ ထပ်ကြိုးစားပါ။';

  @override
  String resendIn(String time) {
    return '$time မိနစ်အတွင်း ပြန်ပို့မည်';
  }

  @override
  String get nameTitle => 'သင့်နာမည်က ဘာလဲ?';

  @override
  String get firstName => 'အမည်';

  @override
  String get lastName => 'မျိုးရိုးအမည်';

  @override
  String get firstNameInvalid => 'မှန်ကန်သော အမည်ကို ထည့်ပါ။';

  @override
  String get lastNameInvalid => 'မှန်ကန်သော မျိုးရိုးအမည်ကို ထည့်ပါ။';

  @override
  String get dobTitle => 'သင့်မွေးနေ့က ဘယ်နေ့လဲ?';

  @override
  String get month => 'လ';

  @override
  String get day => 'ရက်';

  @override
  String get year => 'နှစ်';

  @override
  String get dobInvalid => 'မှန်ကန်သော မွေးသက္ကရာဇ်ကို ထည့်ပါ။';

  @override
  String get continueLabel => 'ဆက်ရန်';

  @override
  String get welcomeTitle => 'J\'donuts ကမ္ဘာမှ ကြိုဆိုပါသည်';

  @override
  String get letsExplore => 'စူးစမ်းကြည့်ရအောင်';

  @override
  String pointsLeftToTier(int n, String tier) {
    return '$tier အဖွဲ့ဝင်ဖြစ်ရန် ပွိုင့် $n ကျန်ပါသည်';
  }

  @override
  String get seasonalSpecials => 'ရာသီအလိုက် အထူးအစီအစဉ်များ';

  @override
  String get popular => 'လူကြိုက်များသော';

  @override
  String get orderAgain => 'ထပ်မံမှာယူရန်';

  @override
  String nearbyShops(int n) {
    return 'သင့်အနီးတွင် J\'Donut ဆိုင် $n ဆိုင်ရှိပါသည်။';
  }

  @override
  String get exploreNow => 'ယခုပဲ ကြည့်ရှုပါ';

  @override
  String get orderOnline => 'အွန်လိုင်းမှ မှာယူရန်';

  @override
  String tierMember(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String get newBadge => 'အသစ်';

  @override
  String get whatsThis => 'ဒါက ဘာလဲ?';

  @override
  String get addToCart => 'ခြင်းထဲသို့ ထည့်ရန်';

  @override
  String get rewardsTitle => 'J\' Donuts ဆုလာဘ်များ';

  @override
  String get rewards => 'ဆုလာဘ်များ';

  @override
  String get totalPoints => 'စုစုပေါင်း ပွိုင့်';

  @override
  String get eatMoreEarnMore => 'များများစား၊ ပွိုင့်များများရ';

  @override
  String get gift => 'လက်ဆောင်';

  @override
  String get earn => 'ရယူရန်';

  @override
  String points(int n) {
    return 'ပွိုင့် $n';
  }

  @override
  String get youreHereNow => 'လက်ရှိအဆင့်';

  @override
  String pointsRemainingToTier(int n, String tier) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String nString = nNumberFormat.format(n);

    return '$tier ဖြစ်ရန် ပွိုင့် $nString ကျန်ပါသည်';
  }

  @override
  String get youllBeHereSoon => 'မကြာမီ ဤနေရာသို့ ရောက်မည်';

  @override
  String get homeTab => 'ပင်မ';

  @override
  String get rewardTab => 'ဆုလာဘ်';

  @override
  String get menuTab => 'မီနူး';

  @override
  String get walletTab => 'ပိုက်ဆံအိတ်';

  @override
  String get offlineBanner => 'အော့ဖ်လိုင်းမုဒ်';

  @override
  String get settingsTitle => 'ဆက်တင်များ';

  @override
  String get settings => 'ဆက်တင်များ';

  @override
  String get logOut => 'ထွက်မည်';

  @override
  String get comingSoon => 'မကြာမီလာမည်';

  @override
  String get menuPlaceholderTitle => 'အရသာရှိတဲ့အရာလေးတစ်ခု လာတော့မယ်';

  @override
  String get menuPlaceholderMessage =>
      'မီနူးအသစ်ကို ပြင်ဆင်နေပါတယ်။ မကြာမီ ပြန်လာကြည့်ပါ။';

  @override
  String get walletPlaceholderTitle => 'သင့်ပိုက်ဆံအိတ်ကို ပြင်ဆင်နေပါတယ်';

  @override
  String get walletPlaceholderMessage =>
      'သင့်ဆုလာဘ်များနှင့် ငွေပေးချေမှုရွေးချယ်စရာများကို ဤနေရာတွင် ပြသပါမည်။';

  @override
  String get settingsPlaceholderTitle => 'အက်ပ်ကို စိတ်ကြိုက်ပြင်ဆင်ပါ';

  @override
  String get settingsPlaceholderMessage =>
      'သင့်အကောင့်ဆက်တင်များကို မကြာမီ ဤနေရာတွင် ပြသပါမည်။';

  @override
  String get seedFailureTitle => 'We couldn\'t prepare the app';

  @override
  String get seedFailureMessage =>
      'Your app data couldn\'t be loaded. Please try again.';

  @override
  String get retry => 'Try again';

  @override
  String get homeSectionEmpty => 'လောလောဆယ် ဘာမျှမရှိသေးပါ။';

  @override
  String get homeSectionError => 'ဤအပိုင်းကို မရရှိနိုင်သေးပါ။';

  @override
  String get productNotFound => 'ထုတ်ကုန်ကို မတွေ့ပါ။';

  @override
  String get addedToCart => 'ခြင်းထဲသို့ ထည့်ပြီးပါပြီ။';
}
