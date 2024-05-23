import 'package:flutter/material.dart';
import 'package:llama_flow/src/screens/basic_rag/basic_rag.dart';
import 'package:llama_flow/src/screens/dashboard/dashboard.dart';
import 'package:llama_flow/src/settings/settings_controller.dart';
import 'package:llama_flow/src/settings/settings_view.dart';
import 'package:llama_flow/theme/measures.dart';
import 'package:sidebarx/sidebarx.dart';

class Screens extends StatelessWidget {
  const Screens({
    super.key,
    required this.controller,
    required this.settingsController,
  });

  final SidebarXController controller;
  final SettingsController settingsController;

  void changepage(int pageIndex) {
    controller.selectIndex(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          switch (controller.selectedIndex) {
            // Home
            case 0:
              return Padding(
                  padding: edgeSymmetricH64,
                  child: Dashboard(changePage: changepage));
            case 1:
              return Padding(
                  padding: edgeSymmetricH64, child: const BasicRAG());
            case 2:
              return Padding(
                padding: edgeSymmetricH64,
              );
            case 3:
              return Padding(
                padding: edgeSymmetricH64,
              );
            // Settings
            case 4:
              return Padding(
                padding: edgeSymmetricH64,
                child: SettingsView(controller: settingsController),
              );
            case 5:
              return Padding(
                padding: edgeSymmetricH64,
              );
            default:
              return Padding(
                padding: edgeSymmetricH64,
              );
          }
        });
  }
}
