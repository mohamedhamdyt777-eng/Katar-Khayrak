import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Katar Khayrak'**
  String get appName;

  /// No description provided for @donateNow.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donateNow;

  /// No description provided for @browseCharities.
  ///
  /// In en, this message translates to:
  /// **'Browse Charities'**
  String get browseCharities;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a charity...'**
  String get searchHint;

  /// No description provided for @campaignGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal: EGP {amount}'**
  String campaignGoal(int amount);

  /// No description provided for @donationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Donation successful! May your giving be rewarded.'**
  String get donationSuccess;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginTitle;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to {phone}'**
  String otpSent(String phone);

  /// No description provided for @zakatCalculator.
  ///
  /// In en, this message translates to:
  /// **'Zakat Calculator'**
  String get zakatCalculator;

  /// No description provided for @categories_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categories_health;

  /// No description provided for @categories_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categories_education;

  /// No description provided for @categories_orphans.
  ///
  /// In en, this message translates to:
  /// **'Orphans'**
  String get categories_orphans;

  /// No description provided for @categories_disaster.
  ///
  /// In en, this message translates to:
  /// **'Disaster Relief'**
  String get categories_disaster;

  /// No description provided for @categories_most_needed.
  ///
  /// In en, this message translates to:
  /// **'Most Needed'**
  String get categories_most_needed;

  /// No description provided for @categories_most_donated.
  ///
  /// In en, this message translates to:
  /// **'Most Donated'**
  String get categories_most_donated;

  /// No description provided for @loginToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get loginToYourAccount;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ? '**
  String get dontHaveAccount;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @orText.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orText;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcomeBack;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest user'**
  String get guestUser;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabDonate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get tabDonate;

  /// No description provided for @tabCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get tabCart;

  /// No description provided for @tabFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get tabFavorite;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get onboardingSubtitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @letsStart.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start'**
  String get letsStart;

  /// No description provided for @supervisedBy.
  ///
  /// In en, this message translates to:
  /// **'Supervised by Mohamed Hamdy'**
  String get supervisedBy;

  /// No description provided for @introSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get introSkip;

  /// No description provided for @introNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get introNext;

  /// No description provided for @introGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get introGetStarted;

  /// No description provided for @introTitle1.
  ///
  /// In en, this message translates to:
  /// **'Find Causes That Inspire You'**
  String get introTitle1;

  /// No description provided for @introDesc1.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of charitable causes crafted to fit your passion. Discover opportunities to make a real difference around you.'**
  String get introDesc1;

  /// No description provided for @introTitle2.
  ///
  /// In en, this message translates to:
  /// **'Effortless Donations'**
  String get introTitle2;

  /// No description provided for @introDesc2.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of giving with our secure platform. Donate seamlessly, track your Zakat, and focus on what matters—helping others.'**
  String get introDesc2;

  /// No description provided for @introTitle3.
  ///
  /// In en, this message translates to:
  /// **'Track Your Impact'**
  String get introTitle3;

  /// No description provided for @introDesc3.
  ///
  /// In en, this message translates to:
  /// **'Make every contribution count by tracking your impact. Celebrate positive changes in your community and share moments of giving.'**
  String get introDesc3;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createYourAccount;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @signUpWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpWithGoogle;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordBtn.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordBtn;

  /// No description provided for @generalDonation.
  ///
  /// In en, this message translates to:
  /// **'General Donation'**
  String get generalDonation;

  /// No description provided for @tellUsDonationAmount.
  ///
  /// In en, this message translates to:
  /// **'Tell us about the donation amount'**
  String get tellUsDonationAmount;

  /// No description provided for @enterDonationAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter donation amount'**
  String get enterDonationAmount;

  /// No description provided for @currencyEGP.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currencyEGP;

  /// No description provided for @emptyCartText.
  ///
  /// In en, this message translates to:
  /// **'Your donation cart is currently empty'**
  String get emptyCartText;

  /// No description provided for @emptyFavoritesText.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t favorited any campaigns yet.'**
  String get emptyFavoritesText;

  /// No description provided for @chooseAccountType.
  ///
  /// In en, this message translates to:
  /// **'Choose Account Type'**
  String get chooseAccountType;

  /// No description provided for @accountTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select how you would like to use Katar Khayrak'**
  String get accountTypeSubtitle;

  /// No description provided for @donor.
  ///
  /// In en, this message translates to:
  /// **'Donor'**
  String get donor;

  /// No description provided for @donorDesc.
  ///
  /// In en, this message translates to:
  /// **'I want to donate and help others'**
  String get donorDesc;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @orgDesc.
  ///
  /// In en, this message translates to:
  /// **'We are an organization seeking support'**
  String get orgDesc;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @orgLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Organization Login'**
  String get orgLoginTitle;

  /// No description provided for @orgEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Organization Email'**
  String get orgEmailHint;

  /// No description provided for @emptyFavoriteText.
  ///
  /// In en, this message translates to:
  /// **'Your favorite list is currently empty'**
  String get emptyFavoriteText;

  /// No description provided for @browseProductsBtn.
  ///
  /// In en, this message translates to:
  /// **'Browse Products'**
  String get browseProductsBtn;

  /// No description provided for @addedToCartMsg.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCartMsg;

  /// No description provided for @organizations.
  ///
  /// In en, this message translates to:
  /// **'Organizations'**
  String get organizations;

  /// No description provided for @donationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Donations'**
  String get donationsTitle;

  /// No description provided for @searchReceiverHint.
  ///
  /// In en, this message translates to:
  /// **'Search for specific Donation Receiver'**
  String get searchReceiverHint;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @selectAmount.
  ///
  /// In en, this message translates to:
  /// **'Select Amount'**
  String get selectAmount;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit/Debit Card'**
  String get creditCard;

  /// No description provided for @instapay.
  ///
  /// In en, this message translates to:
  /// **'Instapay'**
  String get instapay;

  /// No description provided for @mobileWallet.
  ///
  /// In en, this message translates to:
  /// **'Mobile Wallet (Vodafone/Etisalat Cash)'**
  String get mobileWallet;

  /// No description provided for @confirmDonation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Donation'**
  String get confirmDonation;

  /// No description provided for @addCampaign.
  ///
  /// In en, this message translates to:
  /// **'Add Campaign'**
  String get addCampaign;

  /// No description provided for @campaignTitle.
  ///
  /// In en, this message translates to:
  /// **'Campaign Title'**
  String get campaignTitle;

  /// No description provided for @campaignDate.
  ///
  /// In en, this message translates to:
  /// **'Campaign Date'**
  String get campaignDate;

  /// No description provided for @createCampaignBtn.
  ///
  /// In en, this message translates to:
  /// **'Create Campaign'**
  String get createCampaignBtn;

  /// No description provided for @enterCampaignTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter campaign title'**
  String get enterCampaignTitle;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for You'**
  String get recommendedForYou;

  /// No description provided for @basedOnInterests.
  ///
  /// In en, this message translates to:
  /// **'Based on your interests'**
  String get basedOnInterests;

  /// No description provided for @yourCampaigns.
  ///
  /// In en, this message translates to:
  /// **'Your Campaigns'**
  String get yourCampaigns;

  /// No description provided for @editCampaign.
  ///
  /// In en, this message translates to:
  /// **'Edit Campaign'**
  String get editCampaign;

  /// No description provided for @deleteCampaign.
  ///
  /// In en, this message translates to:
  /// **'Delete Campaign'**
  String get deleteCampaign;

  /// No description provided for @updateCampaignBtn.
  ///
  /// In en, this message translates to:
  /// **'Update Campaign'**
  String get updateCampaignBtn;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this campaign?'**
  String get confirmDelete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get markAllAsRead;

  /// No description provided for @campaignDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get campaignDescription;

  /// No description provided for @enterCampaignDescription.
  ///
  /// In en, this message translates to:
  /// **'Detailed explanation of the campaign'**
  String get enterCampaignDescription;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmount;

  /// No description provided for @enterTargetAmount.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get enterTargetAmount;

  /// No description provided for @coverImage.
  ///
  /// In en, this message translates to:
  /// **'Cover Image'**
  String get coverImage;

  /// No description provided for @selectCoverImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to select cover image'**
  String get selectCoverImage;

  /// No description provided for @galleryImages.
  ///
  /// In en, this message translates to:
  /// **'Gallery Images'**
  String get galleryImages;

  /// No description provided for @selectGalleryImages.
  ///
  /// In en, this message translates to:
  /// **'Add photos'**
  String get selectGalleryImages;

  /// No description provided for @timeNotSet.
  ///
  /// In en, this message translates to:
  /// **'Time not set'**
  String get timeNotSet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
