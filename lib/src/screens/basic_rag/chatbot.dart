import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:llama_flow/api/basic_rag.dart';
import 'package:llama_flow/models/currrent_rage_setting.dart';
import 'package:llama_flow/src/screens/basic_rag/save_chatbot_dialog.dart';
import 'package:llama_flow/theme/colors.dart';
import 'package:llama_flow/theme/measures.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  static const routeName = '/basic-chatbot';

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final user = const types.User(id: '0');
  final bot = const types.User(id: '1');
  final List<types.Message> _messages = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _chatFormKey = GlobalKey<FormState>();
  CurrentRAGSettings? currentRAGSettings;

  documentQueryingAPI(query) async {
    String botResponse = await documentQuerying(query);
    setState(() {
      _messages.removeAt(0);
      _messages.insert(
          0,
          types.TextMessage(
              author: bot,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              text: botResponse
                  .replaceFirst(RegExp(r'\n+'), '')
                  .replaceAll('- response: ', '')
                  .replaceAll('- Response: ', '')
                  .replaceAll('- answer:', ''),
              id: '${_messages.length + 1}'));
    });
  }

  handleSend(types.PartialText value) {
    setState(() {
      _messages.insert(
          0,
          types.TextMessage(
              author: user,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              text: value.text,
              id: '${_messages.length + 1}'));
      _messages.insert(
          0,
          types.TextMessage(
              author: bot, text: '...', id: '${_messages.length + 1}'));
      documentQueryingAPI(value.text);
    });
  }

  getCurrentSettingsAPI() async {
    currentRAGSettings = await getCurrentRAGSettings();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentSettingsAPI();
    _messages.insert(
        0,
        types.TextMessage(
            author: bot,
            text: 'Hello! How can I help you?',
            id: '${_messages.length + 1}'));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _messages.clear();
    currentRAGSettings = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          ElevatedButton(
              onPressed: () => showSaveChatbotDialog(
                  context: context,
                  nameController: _nameController,
                  descriptionController: _descriptionController,
                  chatBotFormKey: _chatFormKey,
                  currentRAGSettings: currentRAGSettings),
              child: const Text('Save ChatBot')),
          const SizedBox(width: 16)
        ]),
        body: Chat(
            messages: _messages,
            onSendPressed: handleSend,
            user: user,
            theme: DarkChatTheme(
                backgroundColor: scaffoldBackgroundColor,
                inputBackgroundColor: colorPrimarySideBarBackground,
                primaryColor: colorPrimarySideBarBackground,
                inputBorderRadius: borderRadiusCircular8,
                messageBorderRadius: 8,
                messageMaxWidth: MediaQuery.of(context).size.width * 0.5)));
  }
}
