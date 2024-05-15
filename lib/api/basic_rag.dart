import 'dart:developer';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:no_code_rag_frontend/api/api.dart';
import 'package:no_code_rag_frontend/models/base_rag_model.dart';
import 'package:no_code_rag_frontend/models/chatbot.dart';
import 'package:no_code_rag_frontend/models/currrent_rage_setting.dart';
import 'package:no_code_rag_frontend/models/vectordb_collection.dart';

final dio = Dio(baseOptions);

setDioBaseURL(String url) {
  dio.options.baseUrl = url;
}

getDioBaseURL() {
  return dio.options.baseUrl;
}

Future<BaseRAGSettings?> getBasicRAGSettings() async {
  try {
    final response = await dio.get(
      'get-basic-settings/',
    );
    return BaseRAGSettings.fromJson(response.data);
  } on DioException catch (error) {
    // Handle DioError
    log(error.toString());
    return null;
  }
}

Future<bool> updateBasicRAGSettings({
  vectorDB,
  vectorDBCollection,
  embedModelProvider,
  embedModel,
  llmProvider,
  llm,
  loadIn4bit,
  chunkingStrategy,
  semanticSplittingBufferSize,
  semanticSplittingBreakpointPercentileThreshold,
  retriverTopK,
}) async {
  try {
    final response = await dio.post(
      'update-basic-settings/',
      data: {
        "vector_db": vectorDB ?? "chromadb",
        "vector_db_collection": vectorDBCollection ?? "default",
        "embed_model_provider": embedModelProvider ?? "huggingface",
        "embed_model": embedModel ?? "Snowflake/snowflake-arctic-embed-l",
        "llm_provider": llmProvider ?? "huggingface",
        "llm": llm ?? "microsoft/Phi-3-mini-128k-instruct",
        "load_in_4bit": loadIn4bit ?? true,
        "chunking_strategy": chunkingStrategy ?? "semantic-splitting",
        "semantic_splitting_buffer_size": semanticSplittingBufferSize ?? 4,
        "semantic_splitting_breakpoint_percentile_threshold":
            semanticSplittingBreakpointPercentileThreshold ?? 98,
        "retriver_top_k": retriverTopK ?? 5,
      },
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<bool> documentIndexing(List<XFile> files) async {
  try {
    final FormData formData = FormData.fromMap({
      'files':
          files.map((file) => MultipartFile.fromFileSync(file.path)).toList(),
    });
    final response = await dio.post(
      'document-index/',
      data: formData,
    );
    return response.statusCode == 201;
  } on DioException catch (error) {
    // Handle DioError
    log('DioError: ${error.message}');
    return false;
  }
}

Future<String> documentQuerying(String query) async {
  try {
    final Response response = await dio.get(
      'document-query?query=${query.replaceAll(' ', '+')}',
      data: {'query': query},
    );

    if (response.statusCode == 200) {
      // Handle successful response
      return response.data['response'];
    } else {
      // Handle error response
      return 'Error: ${response.statusCode} ${response.statusMessage}';
    }
  } on DioException catch (error) {
    // Handle DioError
    log(error.toString());
    return 'DioError: ${error.message}';
  }
}

Future<bool> createChatbot(ChatBotModel chatBotModel) async {
  try {
    final response = await dio.post(
      '/create-chatbots/',
      data: chatBotModel.toJson(),
    );
    return response.statusCode == 200;
  } on DioException catch (error) {
    // Handle DioError
    log(error.toString());
    return false;
  }
}

Future<List<ChatBotModel>> getChatbots() async {
  try {
    final response = await dio.get('/get-chatbots/');
    return (response.data as List)
        .map((json) => ChatBotModel.fromJson(json))
        .toList();
  } on DioException catch (error) {
    // Handle DioError
    log(error.toString());
    return [];
  }
}

Future<List<VectorDBCollectionModel>> getCollections() async {
  try {
    final response = await dio.get('/get-collections/');
    log(response.data.toString());
    return (response.data as List)
        .map((json) => VectorDBCollectionModel.fromJson(json))
        .toList();
  } on DioException catch (error) {
    // Handle DioError
    log(error.toString());
    return [];
  }
}

Future<CurrentRAGSettings?> getCurrentRAGSettings() async {
  try {
    final response = await dio.get('/get-current-basic-settings/');
    log(response.data.toString());
    return CurrentRAGSettings.fromJson(response.data);
  } on DioException catch (error) {
    // Handle DioError
    log(error.toString());
    return null;
  }
}
