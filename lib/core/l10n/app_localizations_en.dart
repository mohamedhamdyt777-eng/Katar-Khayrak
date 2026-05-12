// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Katar Khayrak';

  @override
  String get donateNow => 'Donate';

  @override
  String get browseCharities => 'Browse Charities';

  @override
  String get searchHint => 'Search for a charity...';

  @override
  String campaignGoal(int amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return 'Goal: EGP $amountString';
  }

  @override
  String get donationSuccess =>
      'Donation successful! May your giving be rewarded.';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get registerTitle => 'Create Account';

  @override
  String otpSent(String phone) {
    return 'Verification code sent to $phone';
  }

  @override
  String get zakatCalculator => 'Zakat Calculator';

  @override
  String get categories_health => 'Health';

  @override
  String get categories_education => 'Education';

  @override
  String get categories_orphans => 'Orphans';

  @override
  String get categories_disaster => 'Disaster Relief';

  @override
  String get categories_most_needed => 'Most Needed';

  @override
  String get categories_most_donated => 'Most Donated';

  @override
  String get loginToYourAccount => 'Login to your account';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get forgetPassword => 'Forget Password?';

  @override
  String get dontHaveAccount => 'Don\'t have an account ? ';

  @override
  String get signup => 'Signup';

  @override
  String get orText => 'Or';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get welcomeBack => 'Welcome Back ✨';

  @override
  String get guestUser => 'Guest user';

  @override
  String get tabHome => 'Home';

  @override
  String get tabDonate => 'Donate';

  @override
  String get tabCart => 'Cart';

  @override
  String get tabFavorite => 'Favorite';

  @override
  String get tabProfile => 'Profile';

  @override
  String get categoryAll => 'All';

  @override
  String get onboardingTitle => 'Personalize Your Experience';

  @override
  String get onboardingSubtitle =>
      'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get logout => 'Logout';

  @override
  String get letsStart => 'Let\'s start';

  @override
  String get supervisedBy => 'Supervised by Mohamed Hamdy';

  @override
  String get introSkip => 'Skip';

  @override
  String get introNext => 'Next';

  @override
  String get introGetStarted => 'Get Started';

  @override
  String get introTitle1 => 'Find Causes That Inspire You';

  @override
  String get introDesc1 =>
      'Dive into a world of charitable causes crafted to fit your passion. Discover opportunities to make a real difference around you.';

  @override
  String get introTitle2 => 'Effortless Donations';

  @override
  String get introDesc2 =>
      'Take the hassle out of giving with our secure platform. Donate seamlessly, track your Zakat, and focus on what matters—helping others.';

  @override
  String get introTitle3 => 'Track Your Impact';

  @override
  String get introDesc3 =>
      'Make every contribution count by tracking your impact. Celebrate positive changes in your community and share moments of giving.';

  @override
  String get createYourAccount => 'Create your account';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signUpWithGoogle => 'Sign up with Google';

  @override
  String get resetPasswordTitle => 'Forget Password';

  @override
  String get resetPasswordBtn => 'Reset password';

  @override
  String get generalDonation => 'General Donation';

  @override
  String get tellUsDonationAmount => 'Tell us about the donation amount';

  @override
  String get enterDonationAmount => 'Enter donation amount';

  @override
  String get currencyEGP => 'EGP';

  @override
  String get emptyCartText => 'Your donation cart is currently empty';

  @override
  String get emptyFavoritesText => 'You haven\'t favorited any campaigns yet.';

  @override
  String get chooseAccountType => 'Choose Account Type';

  @override
  String get accountTypeSubtitle =>
      'Select how you would like to use Katar Khayrak';

  @override
  String get donor => 'Donor';

  @override
  String get donorDesc => 'I want to donate and help others';

  @override
  String get organization => 'Organization';

  @override
  String get orgDesc => 'We are an organization seeking support';

  @override
  String get continueBtn => 'Continue';

  @override
  String get orgLoginTitle => 'Organization Login';

  @override
  String get orgEmailHint => 'Organization Email';

  @override
  String get emptyFavoriteText => 'Your favorite list is currently empty';

  @override
  String get browseProductsBtn => 'Browse Products';

  @override
  String get addedToCartMsg => 'Added to cart';

  @override
  String get organizations => 'Organizations';

  @override
  String get donationsTitle => 'Donations';

  @override
  String get searchReceiverHint => 'Search for specific Donation Receiver';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get selectAmount => 'Select Amount';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get creditCard => 'Credit/Debit Card';

  @override
  String get instapay => 'Instapay';

  @override
  String get mobileWallet => 'Mobile Wallet (Vodafone/Etisalat Cash)';

  @override
  String get confirmDonation => 'Confirm Donation';

  @override
  String get addCampaign => 'Add Campaign';

  @override
  String get campaignTitle => 'Campaign Title';

  @override
  String get campaignDate => 'Campaign Date';

  @override
  String get createCampaignBtn => 'Create Campaign';

  @override
  String get enterCampaignTitle => 'Enter campaign title';

  @override
  String get recommendedForYou => 'Recommended for You';

  @override
  String get basedOnInterests => 'Based on your interests';

  @override
  String get yourCampaigns => 'Your Campaigns';

  @override
  String get editCampaign => 'Edit Campaign';

  @override
  String get deleteCampaign => 'Delete Campaign';

  @override
  String get updateCampaignBtn => 'Update Campaign';

  @override
  String get confirmDelete => 'Are you sure you want to delete this campaign?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get notifications => 'Notifications';

  @override
  String get markAllAsRead => 'Mark All as Read';

  @override
  String get campaignDescription => 'Description';

  @override
  String get enterCampaignDescription => 'Detailed explanation of the campaign';

  @override
  String get targetAmount => 'Target Amount';

  @override
  String get enterTargetAmount => '0.00';

  @override
  String get coverImage => 'Cover Image';

  @override
  String get selectCoverImage => 'Tap to select cover image';

  @override
  String get galleryImages => 'Gallery Images';

  @override
  String get selectGalleryImages => 'Add photos';

  @override
  String get timeNotSet => 'Time not set';
}
