import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../profile/screens/profile_screen.dart';
import 'org_home_tab.dart';

class OrgMainScaffold extends StatefulWidget {
  const OrgMainScaffold({super.key});

  @override
  State<OrgMainScaffold> createState() => _OrgMainScaffoldState();
}

class _OrgMainScaffoldState extends State<OrgMainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const OrgHomeTab(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _tabs[_currentIndex],
      floatingActionButton: AnimatedScale(
        scale: _currentIndex == 0 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: FloatingActionButton(
          onPressed: () {
            context.push('/add-campaign');
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
            icon: SvgPicture.asset('assets/icons/profile.svg', height: 24, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            activeIcon: SvgPicture.asset('assets/icons/profile.svg', height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: l10n.tabProfile,
          ),
        ],
      ),
    );
  }
}
