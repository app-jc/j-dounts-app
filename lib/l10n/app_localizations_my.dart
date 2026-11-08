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
  String get termsOfUse => 'အသုံးပြုမှုစည်းမျဉ်းများ';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get phoneTitle => 'သင့်ဖုန်းနံပါတ်ကို ရိုက်ထည့်ပါ';

  @override
  String get otpTitle => 'သင့်ဖုန်းနံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSent(String phone) {
    return 'ပို့ထားသော ဂဏန်း ၆ လုံး OTP သည် $phone သို့ ရောက်ရှိလာပါမည်';
  }

  @override
  String get didntReceiveCode => 'ကုဒ်မရရှိဘူးလား?';

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
  String get dobTitle => 'သင့်မွေးနေ့က ဘယ်နေ့လဲ?';

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
    return '$tier ဖြစ်ရန် ပွိုင့် $n ကျန်ပါသည်';
  }

  @override
  String get youllBeHereSoon => 'မကြာမီ ဤနေရာသို့ ရောက်မည်';

  @override
  String get homeTab => 'ပင်မ';

  @override
  String get rewardTab => 'ဆုလာဘ်';
}
