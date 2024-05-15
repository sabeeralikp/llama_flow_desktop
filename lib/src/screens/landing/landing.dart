import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:no_code_rag_frontend/src/screens/landing/screens.dart';
import 'package:no_code_rag_frontend/src/settings/settings_controller.dart';
import 'package:no_code_rag_frontend/theme/sidebarx.dart';
import 'package:sidebarx/sidebarx.dart';

class Landing extends StatefulWidget {
  const Landing({
    super.key,
    required this.settingsController,
  });

  static const routeName = '/';
  final SettingsController settingsController;

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final _sidebarcontroller = SidebarXController(selectedIndex: 0);

  @override
  void dispose() {
    _sidebarcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SidebarX(
          controller: _sidebarcontroller,
          theme: baseSideBarXTheme,
          extendedTheme: extendedSideBarXTheme,
          items: const [
            SidebarXItem(
                icon: TablerIcons.layout_dashboard_filled, label: 'Dashboard'),
            SidebarXItem(icon: Icons.account_tree_rounded, label: 'Basic'),
            SidebarXItem(
                icon: Icons.rebase_edit, label: 'Advanced', selectable: false),
            SidebarXItem(
                icon: Icons.tune_rounded, label: 'Custom', selectable: false),
            SidebarXItem(icon: Icons.settings_rounded, label: 'Settings')
          ]),
      Expanded(
          child: Screens(
              controller: _sidebarcontroller,
              settingsController: widget.settingsController))
    ]));
  }
}
