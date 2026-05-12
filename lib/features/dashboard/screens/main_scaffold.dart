import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../cart/screens/cart_tab.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../donation/widgets/donate_bottom_sheet.dart';
import 'home_tab.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  void switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _tabs = [
    const HomeTab(),
    const Center(child: Text('Donate')), // Handled by onTap logic
    const CartTab(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor,
        onTap: (index) {
          if (index == 1) {
            // Index 1 is the Donate Tab
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const DonateBottomSheet(),
              ),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg', height: 24, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            activeIcon: SvgPicture.asset('assets/icons/home.svg', height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: l10n.tabHome,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/donate.svg', height: 24, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            activeIcon: SvgPicture.asset('assets/icons/donate.svg', height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: l10n.tabDonate,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cart.svg', height: 24, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            activeIcon: SvgPicture.asset('assets/icons/cart.svg', height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: l10n.tabCart,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/heart.svg', height: 24, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            activeIcon: SvgPicture.asset('assets/icons/heart.svg', height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: l10n.tabFavorite,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/profile.svg', height: 24, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            activeIcon: SvgPicture.asset('assets/icons/profile.svg', height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: l10n.tabProfile,
          ),
        ],
      ),
    );
  }
}
