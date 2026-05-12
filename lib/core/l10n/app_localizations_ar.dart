// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'كتر خيرك';

  @override
  String get donateNow => 'تبرع';

  @override
  String get browseCharities => 'تصفح الجمعيات';

  @override
  String get searchHint => 'ابحث عن جمعية...';

  @override
  String campaignGoal(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return 'الهدف: $amountString جنيه';
  }

  @override
  String get donationSuccess => 'تم التبرع بنجاح! جزاك الله خيراً';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get registerTitle => 'إنشاء حساب';

  @override
  String otpSent(String phone) {
    return 'تم إرسال رمز التحقق إلى $phone';
  }

  @override
  String get zakatCalculator => 'حاسبة الزكاة';

  @override
  String get categories_health => 'الصحة';

  @override
  String get categories_education => 'التعليم';

  @override
  String get categories_orphans => 'الأيتام';

  @override
  String get categories_disaster => 'الكوارث';

  @override
  String get categories_most_needed => 'الاكثر احتياجا';

  @override
  String get categories_most_donated => 'الاكثر تبرعا';

  @override
  String get loginToYourAccount => 'تسجيل الدخول إلى حسابك';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get forgetPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get signup => 'سجل الآن';

  @override
  String get orText => 'أو';

  @override
  String get loginWithGoogle => 'الدخول باستخدام جوجل';

  @override
  String get welcomeBack => 'مرحباً بك ✨';

  @override
  String get guestUser => 'زائر';

  @override
  String get tabHome => 'الرئيسية';

  @override
  String get tabDonate => 'تبرع';

  @override
  String get tabCart => 'السلة';

  @override
  String get tabFavorite => 'المفضلة';

  @override
  String get tabProfile => 'حسابي';

  @override
  String get categoryAll => 'الكل';

  @override
  String get onboardingTitle => 'تخصيص تجربتك';

  @override
  String get onboardingSubtitle =>
      'اختر المظهر واللغة المفضلين لديك للبدء بتجربة مريحة ومخصصة تناسب أسلوبك.';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get theme => 'المظهر';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get letsStart => 'لنبدأ';

  @override
  String get supervisedBy => 'بإشراف محمد حمدي';

  @override
  String get introSkip => 'تخطي';

  @override
  String get introNext => 'التالي';

  @override
  String get introGetStarted => 'ابدأ الآن';

  @override
  String get introTitle1 => 'ابحث عن الحالات التي تلهمك';

  @override
  String get introDesc1 =>
      'انغمس في عالم من الحالات الخيرية المصممة لتناسب شغفك. اكتشف فرصاً لإحداث فرق حقيقي من حولك.';

  @override
  String get introTitle2 => 'تبرعات بكل سهولة';

  @override
  String get introDesc2 =>
      'تخلص من عناء التبرع مع منصتنا الآمنة. تبرع بسلاسة، تتبع زكاتك، وركز على ما يهم—مساعدة الآخرين.';

  @override
  String get introTitle3 => 'تتبع أثرك';

  @override
  String get introDesc3 =>
      'اجعل كل مساهمة ذات قيمة من خلال تتبع أثرك. احتفل بالتغيرات الإيجابية في مجتمعك وشارك لحظات العطاء.';

  @override
  String get createYourAccount => 'إنشاء حسابك';

  @override
  String get enterYourName => 'أدخل اسمك';

  @override
  String get confirmYourPassword => 'تأكيد كلمة المرور';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get signUpWithGoogle => 'تسجيل باستخدام جوجل';

  @override
  String get resetPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get resetPasswordBtn => 'إعادة ضبط كلمة المرور';

  @override
  String get generalDonation => 'التبرع العام';

  @override
  String get tellUsDonationAmount => 'أخبرنا عن مبلغ التبرع';

  @override
  String get enterDonationAmount => 'أدخل مبلغ التبرع';

  @override
  String get currencyEGP => 'EGP';

  @override
  String get emptyCartText => 'سلة التبرعات الخاصة بك فارغة حالياً';

  @override
  String get emptyFavoritesText =>
      'لم تقم بإضافة أي حملات إلى المفضلة حتى الآن.';

  @override
  String get chooseAccountType => 'اختر نوع الحساب';

  @override
  String get accountTypeSubtitle => 'اختر كيف تود استخدام قطر خيرك';

  @override
  String get donor => 'متبرع';

  @override
  String get donorDesc => 'أريد التبرع ومساعدة الآخرين';

  @override
  String get organization => 'مؤسسة';

  @override
  String get orgDesc => 'نحن مؤسسة نبحث عن الدعم';

  @override
  String get continueBtn => 'متابعة';

  @override
  String get orgLoginTitle => 'تسجيل دخول المؤسسة';

  @override
  String get orgEmailHint => 'البريد الإلكتروني للمؤسسة';

  @override
  String get emptyFavoriteText => 'قائمة المفضلة لديك فارغة حالياً';

  @override
  String get browseProductsBtn => 'تصفح المنتجات';

  @override
  String get addedToCartMsg => 'تمت الإضافة إلى السلة';

  @override
  String get organizations => 'المؤسسات';

  @override
  String get donationsTitle => 'التبرعات';

  @override
  String get searchReceiverHint => 'ابحث عن جهة تبرع محددة';

  @override
  String get paymentDetails => 'تفاصيل الدفع';

  @override
  String get selectAmount => 'اختر المبلغ';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get creditCard => 'بطاقة ائتمان/خصم';

  @override
  String get instapay => 'إنستاباي';

  @override
  String get mobileWallet => 'محفظة الهاتف (فودافون/اتصالات كاش)';

  @override
  String get confirmDonation => 'تأكيد التبرع';

  @override
  String get addCampaign => 'إضافة حملة';

  @override
  String get campaignTitle => 'عنوان الحملة';

  @override
  String get campaignDate => 'تاريخ الحملة';

  @override
  String get createCampaignBtn => 'إنشاء الحملة';

  @override
  String get enterCampaignTitle => 'أدخل عنوان الحملة';

  @override
  String get recommendedForYou => 'مقترح لك';

  @override
  String get basedOnInterests => 'بناءً على اهتماماتك';

  @override
  String get yourCampaigns => 'حملاتك';

  @override
  String get editCampaign => 'تعديل الحملة';

  @override
  String get deleteCampaign => 'حذف الحملة';

  @override
  String get updateCampaignBtn => 'تحديث الحملة';

  @override
  String get confirmDelete => 'هل أنت متأكد من حذف هذه الحملة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get markAllAsRead => 'تحديد الكل كمقروء';

  @override
  String get campaignDescription => 'الوصف';

  @override
  String get enterCampaignDescription => 'شرح مفصل للحملة';

  @override
  String get targetAmount => 'المبلغ المستهدف';

  @override
  String get enterTargetAmount => '0.00';

  @override
  String get coverImage => 'صورة الغلاف';

  @override
  String get selectCoverImage => 'اضغط لاختيار صورة الغلاف';

  @override
  String get galleryImages => 'صور إضافية';

  @override
  String get selectGalleryImages => 'إضافة صور';

  @override
  String get timeNotSet => 'لم يتم تحديد الوقت';
}
