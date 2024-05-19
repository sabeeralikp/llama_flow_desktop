import 'dart:developer';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_indicator_view_plus/loading_indicator_view_plus.dart';
import 'package:no_code_rag_frontend/api/basic_rag.dart';
import 'package:no_code_rag_frontend/models/base_rag_model.dart';
import 'package:no_code_rag_frontend/src/screens/basic_rag/chatbot.dart';
import 'package:no_code_rag_frontend/src/screens/basic_rag/show_side_sheet.dart';
import 'package:no_code_rag_frontend/theme/colors.dart';
import 'package:no_code_rag_frontend/theme/decoration.dart';
import 'package:no_code_rag_frontend/theme/measures.dart';
import 'package:no_code_rag_frontend/components/snackbar.dart';

class BasicRAG extends StatefulWidget {
  const BasicRAG({
    super.key,
  });
  static const routeName = '/basic-rag';

  @override
  State<BasicRAG> createState() => _BasicRAGState();
}

class _BasicRAGState extends State<BasicRAG> {
  final List<XFile> _list = [];
  bool isLoading = false;
  Future<void> _pickfiles() async {
    final result = await FilePicker.platform.pickFiles(
        allowCompression: false,
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        for (var element in result.xFiles) {
          if (!_list.any((xFile) => xFile.path == element.path)) {
            _list.add(element);
          }
        }
      });
    }
  }

  List<DropdownMenuItem> _vectorDBTypeItems = [];
  final TextEditingController _vectorDBCollectionController =
      TextEditingController();

  List<DropdownMenuItem> _embedModelProviderItems = [];
  List<DropdownMenuItem> _embedModelItems = [];

  List<DropdownMenuItem> _llmProviderItems = [];
  List<DropdownMenuItem> _llmItems = [];
  List<DropdownMenuItem> _llamaCPPllmItems = [];
  List<DropdownMenuItem> _ollamallmItems = [];

  List<DropdownMenuItem> _chunkingStrategyItems = [];
  final TextEditingController _semanticSplittingBufferSizeController =
      TextEditingController();
  final TextEditingController
      _semanticSplittingBreakpointPercentileThresholdController =
      TextEditingController();
  final TextEditingController _retriverTopKController = TextEditingController();

  bool noBackend = false;
  showNoBackendSnackBar() {
    showSnackbar(context,
        'There is no backend available. Please update on settings tab.');
  }

  getBasicSettingsAPI() async {
    BaseRAGSettings? baseRAGSettings = await getBasicRAGSettings();
    if (baseRAGSettings != null) {
      log(baseRAGSettings.toJson().toString());
      if (baseRAGSettings.vectorDb != null) {
        _vectorDBTypeItems = [
          ...baseRAGSettings.vectorDb!.map((e) => DropdownMenuItem(
              value: e, enabled: e == "chromadb", child: Text(e ?? "")))
        ];
      }
      if (baseRAGSettings.vectorDbCollection != null) {
        _vectorDBCollectionController.text =
            baseRAGSettings.vectorDbCollection ?? "";
      }
      if (baseRAGSettings.embedModelProvider != null) {
        _embedModelProviderItems = [
          ...baseRAGSettings.embedModelProvider!.map((e) => DropdownMenuItem(
              value: e, enabled: e == "huggingface", child: Text(e ?? "")))
        ];
      }
      if (baseRAGSettings.embedModel != null) {
        _embedModelItems = [
          ...baseRAGSettings.embedModel!.map((e) => DropdownMenuItem(
              value: e,
              child: SizedBox(
                  width: 300,
                  child: Text(e ?? "", overflow: TextOverflow.ellipsis))))
        ];
      }
      if (baseRAGSettings.llmProvider != null) {
        _llmProviderItems = [
          ...baseRAGSettings.llmProvider!.map((e) => DropdownMenuItem(
                value: e,
                // enabled: e == "huggingface",
                child: Text(e ?? ""),
              ))
        ];
      }
      if (baseRAGSettings.llm != null) {
        _llmItems = [
          ...baseRAGSettings.llm!
              .map((e) => DropdownMenuItem(value: e, child: Text(e ?? "")))
        ];
      }
      if (baseRAGSettings.llamaCppLlm != null) {
        _llamaCPPllmItems = [
          ...baseRAGSettings.llamaCppLlm!
              .map((e) => DropdownMenuItem(value: e, child: Text(e ?? "")))
        ];
      }
      if (baseRAGSettings.ollamaLlm != null) {
        _ollamallmItems = [
          ...baseRAGSettings.ollamaLlm!
              .map((e) => DropdownMenuItem(value: e, child: Text(e ?? "")))
        ];
      }
      if (baseRAGSettings.chunkingStrategy != null) {
        _chunkingStrategyItems = [
          ...baseRAGSettings.chunkingStrategy!.map((e) => DropdownMenuItem(
              value: e,
              enabled: e == "semantic-splitting",
              child: Text(e ?? "")))
        ];
      }
      if (baseRAGSettings.semanticSplitting != null) {
        if (baseRAGSettings.semanticSplitting!.bufferSize != null) {
          _semanticSplittingBufferSizeController.text =
              baseRAGSettings.semanticSplitting!.bufferSize.toString();
        }
      }
      if (baseRAGSettings.semanticSplitting != null) {
        if (baseRAGSettings.semanticSplitting!.breakpointPercentileThreshold !=
            null) {
          _semanticSplittingBreakpointPercentileThresholdController.text =
              baseRAGSettings.semanticSplitting!.breakpointPercentileThreshold
                  .toString();
        }
      }
      if (baseRAGSettings.retriver != null) {
        if (baseRAGSettings.retriver!.topK != null) {
          _retriverTopKController.text =
              baseRAGSettings.retriver!.topK!.toString();
        }
      }
    } else {
      noBackend = true;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getBasicSettingsAPI();
  }

  void _onDragDone(detail) {
    setState(() {
      for (var element in detail.files) {
        if (!_list.any((xFile) => xFile.path == element.path)) {
          _list.add(element);
        }
      }
    });
  }

  void _removeFile(e) {
    setState(() {
      _list.remove(e);
    });
  }

  void _sideSheetOpener() {
    if (!noBackend) {
      showSideSheet(
        context: context,
        setState: setState,
        vectorDBTypeItems: _vectorDBTypeItems,
        vectorDBCollectionController: _vectorDBCollectionController,
        embedModelProviderItems: _embedModelProviderItems,
        embedModelItems: _embedModelItems,
        llmProviderItems: _llmProviderItems,
        llmItems: _llmItems,
        llamaCPPllmItems: _llamaCPPllmItems,
        ollamallmItems: _ollamallmItems,
        chunkingStrategyItems: _chunkingStrategyItems,
        semanticSplittingBufferSizeController:
            _semanticSplittingBufferSizeController,
        semanticSplittingBreakpointPercentileThresholdController:
            _semanticSplittingBreakpointPercentileThresholdController,
        retriverTopKController: _retriverTopKController,
      );
    }
  }

  void onContinue() {
    if (_list.isEmpty) {
      showSnackbar(context, 'Please add at least one file');
      return;
    } else if (noBackend) {
      showNoBackendSnackBar();
    } else {
      setState(() {
        isLoading = true;
      });
      documentIndexing(_list).then((value) {
        setState(() {
          isLoading = false;
        });
        return value
            ? Navigator.pushNamed(context, ChatBot.routeName)
            : showSnackbar(context, "Something went wrong");
      });
    }
  }

  @override
  void dispose() {
    _vectorDBTypeItems.clear();
    _vectorDBCollectionController.dispose();
    _embedModelProviderItems.clear();
    _embedModelItems.clear();
    _llmProviderItems.clear();
    _llmItems.clear();
    _chunkingStrategyItems.clear();
    _semanticSplittingBufferSizeController.dispose();
    _semanticSplittingBreakpointPercentileThresholdController.dispose();
    _retriverTopKController.dispose();
    _list.clear();
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
            appBar: AppBar(
                // leading: const Icon(Icons.account_tree_outlined, size: 32),
                title: const Text('Basic Workflow'),
                actions: [
                  IconButton(
                      iconSize: 28,
                      onPressed: _sideSheetOpener,
                      icon: const Icon(Icons.more_vert_rounded)),
                  const SizedBox(width: 8)
                ]),
            body: SingleChildScrollView(
                padding: edgeOnlyT16,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.baseline,
                      //   textBaseline: TextBaseline.ideographic,
                      //   children: [
                      //     const Icon(Icons.upload_file),
                      //     Text("Upload Files", style: theme.textTheme.titleMedium),
                      //   ],
                      // ),
                      // sizedBoxH4,
                      // Text('Upload your Documents here',
                      //     style: theme.textTheme.bodyMedium),
                      DropTarget(
                          onDragDone: _onDragDone,
                          onDragEntered: (details) {},
                          child: Container(
                              margin: edgeSymmetricV8,
                              padding: edgeSymmetricV64,
                              decoration:
                                  boxDecorBorderRadiusCircular14BorderAllColorW12,
                              child: Center(
                                  child: Column(children: [
                                const Icon(Ionicons.cloud_upload_outline,
                                    size: 80),
                                sizedBoxH8,
                                Text('Drag and drop your file here',
                                    style: theme.textTheme.bodyLarge),
                                sizedBoxH8,
                                Text('or', style: theme.textTheme.bodyLarge),
                                sizedBoxH8,
                                ElevatedButton(
                                    onPressed: _pickfiles,
                                    child: const Text('Browse'))
                              ])))),
                      if (_list.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Uploaded Files',
                            style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 8),
                        ..._list.map((e) => Padding(
                            padding: edgeOnlyT16,
                            child: ListTile(
                                contentPadding: edgeSymmetricV4H16,
                                leading: const Icon(Icons.edit_document),
                                title: Text(e.name),
                                tileColor: colorWhite12,
                                shape: RoundedRectangleBorder(
                                    borderRadius: borderRadiusCircular8),
                                trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _removeFile(e))))),
                        sizedBoxH48,
                      ]
                    ])),
            floatingActionButton: _list.isEmpty
                ? null
                : FloatingActionButton.extended(
                    label: const Text('Continue'),
                    onPressed: onContinue,
                    icon: const Icon(Icons.arrow_forward)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked);
  }
}
