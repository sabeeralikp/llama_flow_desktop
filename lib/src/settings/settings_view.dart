import 'package:flutter/material.dart';
import 'package:llama_flow/api/basic_rag.dart';
import 'package:llama_flow/components/snackbar.dart';
import 'package:llama_flow/theme/decoration.dart';
import 'package:llama_flow/theme/measures.dart';
import 'package:llama_flow/theme/text_field.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String backendProvider = 'self-hosted-local';
  final List<DropdownMenuItem> _backendProviderItems = [
    const DropdownMenuItem(
        value: 'self-hosted-local', child: Text('Self Hosted (Local)')),
    const DropdownMenuItem(
        value: 'hosted-remote', child: Text('Hosted (Remote)')),
  ];
  final TextEditingController _backendbaseURLController =
      TextEditingController();
  onSaveChanges() {
    // Provider.of<BackendURLProvider>(context, listen: false).backendURL =
    //     _backendbaseURLController.text;
    setDioBaseURL(backendProvider == 'hosted-remote'
        ? '${_backendbaseURLController.text}/api/v1/'
        : 'http://127.0.0.1:8000/api/v1/');
    showSnackbar(context, 'Settings saved successfully');
  }

  getBaseURLAPI() {
    final dioBaseURL = getDioBaseURL();
    if (dioBaseURL == 'http://127.0.0.1:8000/api/v1/') {
      backendProvider = 'self-hosted-local';
    } else {
      backendProvider = 'hosted-remote';
      _backendbaseURLController.text = dioBaseURL.replaceAll('/api/v1/', '');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBaseURLAPI();
  }

  @override
  void dispose() {
    _backendbaseURLController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Container(
          padding: edgeAll32,
          decoration: boxDecorBorderRadiusCircular8ColorP,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DropdownButton<ThemeMode>(
              //   // Read the selected themeMode from the controller
              //   value: controller.themeMode,
              //   // Call the updateThemeMode method any time the user selects a theme.
              //   onChanged: controller.updateThemeMode,
              //   items: const [
              //     DropdownMenuItem(
              //       value: ThemeMode.system,
              //       child: Text('System Theme'),
              //     ),
              //     DropdownMenuItem(
              //       value: ThemeMode.light,
              //       child: Text('Light Theme'),
              //     ),
              //     DropdownMenuItem(
              //       value: ThemeMode.dark,
              //       child: Text('Dark Theme'),
              //     )
              //   ],
              // ),
              Text('Backend', style: theme.textTheme.bodyLarge),
              sizedBoxH16,
              OutlineDropDownFormField(
                  labelText: 'Provider',
                  value: backendProvider,
                  items: _backendProviderItems,
                  onChanged: (value) =>
                      setState(() => backendProvider = value.toString())),
              if (backendProvider == 'hosted-remote') ...[
                sizedBoxH16,
                OutlinedTextFormField(
                    labelText: 'Base URL',
                    controller: _backendbaseURLController)
              ],
              sizedBoxH32,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: onSaveChanges,
                      child: const Text('Save Changes')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
