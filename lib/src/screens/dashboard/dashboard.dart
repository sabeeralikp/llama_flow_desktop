import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:loading_indicator_view_plus/loading_indicator_view_plus.dart';
import 'package:llama_flow/api/basic_rag.dart';
import 'package:llama_flow/models/chatbot.dart';
import 'package:llama_flow/models/vectordb_collection.dart';
import 'package:llama_flow/src/screens/basic_rag/chatbot.dart';
import 'package:llama_flow/theme/colors.dart';
import 'package:llama_flow/theme/decoration.dart';
import 'package:llama_flow/theme/measures.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({this.changePage, super.key});
  final Function(int)? changePage;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ChatBotModel> chatbots = [];
  List<VectorDBCollectionModel> collections = [];
  bool onHover = false;
  bool isLoading = false;

  getChatbotsAPI() async {
    chatbots = await getChatbots();
    if (mounted) {
      setState(() {});
    }
  }

  getCollectionsAPI() async {
    collections = await getCollections();
    if (mounted) {
      setState(() {});
    }
  }

  onChatbotTap(ChatBotModel chatBot) async {
    setState(() {
      isLoading = true;
    });
    await updateBasicRAGSettings(
            vectorDB: chatBot.vectorDb,
            vectorDBCollection: chatBot.vectorDbCollection,
            embedModelProvider: chatBot.embedModelProvider,
            embedModel: chatBot.embedModel,
            llmProvider: chatBot.llmProvider,
            llm: chatBot.llm,
            loadIn4bit: chatBot.loadIn_4bit,
            chunkingStrategy: chatBot.chunkingStrategy,
            semanticSplittingBufferSize: chatBot.semanticSplittingBufferSize,
            semanticSplittingBreakpointPercentileThreshold:
                chatBot.semanticSplittingBreakpointPercentileThreshold,
            retriverTopK: chatBot.retriverTopK)
        .then((value) => value
            ? Navigator.pushNamed(context, ChatBot.routeName)
                .then((value) => setState(() {
                      isLoading = false;
                    }))
            : null);
  }

  @override
  void initState() {
    super.initState();
    getChatbotsAPI();
    getCollectionsAPI();
  }

  @override
  void dispose() {
    chatbots.clear();
    collections.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return isLoading
        ? Center(
            child: PacmanIndicator(
                radius: 32,
                beanRadius: 8,
                color: colorSecondarySideBarBackground))
        : Scaffold(
            appBar: AppBar(title: const Text('Dashboard')),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxH32,
                Text('Chatbots', style: theme.textTheme.bodyLarge),
                sizedBoxH16,
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      ChatBotContainer(
                        onTap: () => widget.changePage!(1),
                        theme: theme,
                        icon: Icons.add_rounded,
                      ),
                      ...[
                        ...chatbots.map((e) => ChatBotContainer(
                            theme: theme,
                            title: e.name!,
                            onTap: () => onChatbotTap(e),
                            icon: TablerIcons.message_chatbot)),
                        const SizedBox(width: 16)
                      ]
                    ])),
                sizedBoxH32,
                Text('DB Collections', style: theme.textTheme.bodyLarge),
                sizedBoxH16,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...[
                        ...collections.reversed.map((e) => ChatBotContainer(
                            theme: theme,
                            title: e.name,
                            icon: TablerIcons.database)),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class ChatBotContainer extends StatefulWidget {
  const ChatBotContainer({
    super.key,
    required this.theme,
    required this.icon,
    this.onTap,
    this.title,
  });

  final ThemeData theme;
  final String? title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  State<ChatBotContainer> createState() => _ChatBotContainerState();
}

class _ChatBotContainerState extends State<ChatBotContainer> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hover) {
          setState(() {
            onHover = hover;
          });
        },
        borderRadius: borderRadiusCircular8,
        child: Container(
            decoration: onHover
                ? boxDecorBorderRadiusCircular14BorderAllColorW12.copyWith(
                    border: Border.all(color: primaryColor))
                : boxDecorBorderRadiusCircular14BorderAllColorW12,
            width: 300,
            height: 160,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(widget.icon, color: onHover ? primaryColor : null, size: 48),
              if (widget.title != null) ...[
                sizedBoxH16,
                Text(widget.title!,
                    style: widget.theme.textTheme.bodyMedium!
                        .copyWith(color: onHover ? primaryColor : null))
              ]
            ])),
      ),
    );
  }
}
