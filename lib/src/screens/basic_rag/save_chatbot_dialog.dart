import 'package:flutter/material.dart';
import 'package:no_code_rag_frontend/api/basic_rag.dart';
import 'package:no_code_rag_frontend/models/chatbot.dart';
import 'package:no_code_rag_frontend/models/currrent_rage_setting.dart';

import 'package:no_code_rag_frontend/theme/colors.dart';
import 'package:no_code_rag_frontend/theme/measures.dart';
import 'package:no_code_rag_frontend/theme/text_field.dart';

String? nullChecker(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}

showSaveChatbotDialog(
    {required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required chatBotFormKey,
    required CurrentRAGSettings? currentRAGSettings}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          backgroundColor: colorPrimarySideBarBackground,
          title: const Text("Save Chatbot"),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Form(
              key: chatBotFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedTextFormField(
                      labelText: 'Name',
                      validator: nullChecker,
                      controller: nameController),
                  sizedBoxH16,
                  OutlinedTextFormField(
                      minLines: 2,
                      maxLines: 3,
                      validator: nullChecker,
                      labelText: 'Description',
                      controller: descriptionController)
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  if (chatBotFormKey.currentState!.validate() &&
                      currentRAGSettings != null) {
                    ChatBotModel chatBotModel = ChatBotModel(
                        name: nameController.text,
                        description: descriptionController.text,
                        vectorDb: currentRAGSettings.vectorDb,
                        vectorDbCollection:
                            currentRAGSettings.vectorDbCollection,
                        embedModelProvider:
                            currentRAGSettings.embedModelProvider,
                        embedModel: currentRAGSettings.embedModel,
                        llmProvider: currentRAGSettings.llmProvider,
                        llm: currentRAGSettings.llm,
                        loadIn_4bit: currentRAGSettings.loadIn_4bit,
                        chunkingStrategy: currentRAGSettings.chunkingStrategy,
                        semanticSplittingBufferSize:
                            currentRAGSettings.semanticSplittingBufferSize,
                        semanticSplittingBreakpointPercentileThreshold:
                            currentRAGSettings
                                .semanticSplittingBreakpointPercentileThreshold,
                        retriverTopK: currentRAGSettings.retriverTopK);
                    createChatbot(chatBotModel)
                        .then((value) => Navigator.of(context).pop());
                  }
                },
                child: const Text('Save')),
          ],
        );
      });
}
