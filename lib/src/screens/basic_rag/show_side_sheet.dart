import 'package:flutter/material.dart';
import 'package:no_code_rag_frontend/components/snackbar.dart';
import 'package:no_code_rag_frontend/theme/checkbox.dart';
import 'package:no_code_rag_frontend/theme/measures.dart';
import 'package:no_code_rag_frontend/theme/side_sheet.dart';
import 'package:no_code_rag_frontend/theme/text_field.dart';
import 'package:no_code_rag_frontend/api/basic_rag.dart';

showSideSheet({
  context,
  setState,
  required List<DropdownMenuItem> vectorDBTypeItems,
  required TextEditingController vectorDBCollectionController,
  required List<DropdownMenuItem> embedModelProviderItems,
  required List<DropdownMenuItem> embedModelItems,
  required List<DropdownMenuItem> llmProviderItems,
  required List<DropdownMenuItem> llmItems,
  required List<DropdownMenuItem> chunkingStrategyItems,
  required TextEditingController semanticSplittingBufferSizeController,
  required TextEditingController
      semanticSplittingBreakpointPercentileThresholdController,
  required TextEditingController retriverTopKController,
}) {
  String vectorDBType = vectorDBTypeItems[0].value.toString();
  String embedModelProvider = embedModelProviderItems[0].value.toString();
  String embedModel = embedModelItems[0].value.toString();
  String llmProvider = llmProviderItems[0].value.toString();
  String llm = llmItems[0].value.toString();
  bool loadIn4Bit = true;
  String chunkingStrategy = chunkingStrategyItems[0].value.toString();

  return showModalSideSheet(
    context,
    body: StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
            padding: edgeSymmetricH32,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('VectorDB'),
                  sizedBoxH12,
                  OutlineDropDownFormField(
                      labelText: 'Type',
                      value: vectorDBType,
                      items: vectorDBTypeItems,
                      onChanged: (value) =>
                          setState(() => vectorDBType = value.toString())),
                  if (vectorDBType == 'chromadb') ...[
                    sizedBoxH12,
                    OutlinedTextFormField(
                        labelText: 'Collection Name',
                        controller: vectorDBCollectionController)
                  ],
                  sizedBoxH24,
                  const Text('Embed Model'),
                  sizedBoxH12,
                  OutlineDropDownFormField(
                      labelText: 'Provider',
                      value: embedModelProvider,
                      items: embedModelProviderItems,
                      onChanged: (value) => setState(
                          () => embedModelProvider = value.toString())),
                  if (embedModelProvider == 'huggingface') ...[
                    sizedBoxH12,
                    OutlineDropDownFormField(
                        labelText: 'Model Name',
                        value: embedModel,
                        items: embedModelItems,
                        onChanged: (value) =>
                            setState(() => embedModel = value.toString()))
                  ],
                  sizedBoxH24,
                  const Text('LLM'),
                  sizedBoxH12,
                  OutlineDropDownFormField(
                      labelText: 'Provider',
                      value: llmProvider,
                      items: llmProviderItems,
                      onChanged: (value) =>
                          setState(() => llmProvider = value.toString())),
                  sizedBoxH12,
                  if (llmProvider == 'huggingface') ...[
                    OutlineDropDownFormField(
                        labelText: 'Model Name',
                        value: llm,
                        items: llmItems,
                        onChanged: (value) =>
                            setState(() => llm = value.toString())),
                    sizedBoxH12,
                    CheckBoxWithTitle(
                        title: 'load in 4 bit',
                        value: loadIn4Bit,
                        onChanged: (value) =>
                            setState(() => loadIn4Bit = value ?? true))
                  ],
                  sizedBoxH24,
                  const Text('Chunking Strategy'),
                  sizedBoxH12,
                  OutlineDropDownFormField(
                      labelText: 'Split Type',
                      value: chunkingStrategy,
                      items: chunkingStrategyItems,
                      onChanged: (value) =>
                          setState(() => chunkingStrategy = value.toString())),
                  sizedBoxH12,
                  if (chunkingStrategy == 'semantic-splitting')
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        child: OutlinedTextFormField(
                            labelText: 'Buffer Size',
                            keyboardType: TextInputType.number,
                            controller: semanticSplittingBufferSizeController),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                          child: OutlinedTextFormField(
                              labelText: 'Breakpoint Percentile',
                              keyboardType: TextInputType.number,
                              controller:
                                  semanticSplittingBreakpointPercentileThresholdController))
                    ]),
                  sizedBoxH24,
                  const Text('Retriver'),
                  sizedBoxH12,
                  OutlinedTextFormField(
                      labelText: 'Top K',
                      keyboardType: TextInputType.number,
                      controller: retriverTopKController)
                ]))),
    header: 'Basic Workflow Options',
    barrierDismissible: true,
    addBackIconButton: false,
    addCloseIconButton: true,
    addActions: true,
    addDivider: false,
    confirmActionTitle: 'Update',
    cancelActionTitle: 'Cancel',
    confirmActionOnPressed: () {
      updateBasicRAGSettings(
              vectorDB: vectorDBType,
              vectorDBCollection: vectorDBCollectionController.text,
              embedModelProvider: embedModelProvider,
              embedModel: embedModel,
              llmProvider: llmProvider,
              llm: llm,
              loadIn4bit: loadIn4Bit,
              chunkingStrategy: chunkingStrategy,
              semanticSplittingBufferSize:
                  int.tryParse(semanticSplittingBufferSizeController.text),
              semanticSplittingBreakpointPercentileThreshold: int.tryParse(
                  semanticSplittingBreakpointPercentileThresholdController
                      .text),
              retriverTopK: int.tryParse(retriverTopKController.text))
          .then((value) => showSnackbar(
              context, value ? 'Update Successfully' : 'Update Failed'));
      Navigator.pop(context);
    },
    cancelActionOnPressed: () {
      Navigator.pop(context);
    },
    transitionDuration: const Duration(milliseconds: 200),
    closeButtonTooltip: 'Close',
    onDismiss: () {},
    onClose: () {
      Navigator.pop(context);
    },
  );
}
