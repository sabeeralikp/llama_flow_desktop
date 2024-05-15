///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ChatBotModel {
/*
{
  "name": "chatbot1",
  "description": "test",
  "vector_db": "",
  "vector_db_collection": "",
  "collection": "",
  "embed_model_provider": "",
  "embed_model": "",
  "llm_provider": "",
  "llm": "",
  "load_in_4bit": true,
  "chunking_strategy": "",
  "semantic_splitting_buffer_size": 1,
  "semantic_splitting_breakpoint_percentile_threshold": 95,
  "retriver_top_k": 5
} 
*/

  String? name;
  String? description;
  String? vectorDb;
  String? vectorDbCollection;
  String? embedModelProvider;
  String? embedModel;
  String? llmProvider;
  String? llm;
  bool? loadIn_4bit;
  String? chunkingStrategy;
  int? semanticSplittingBufferSize;
  int? semanticSplittingBreakpointPercentileThreshold;
  int? retriverTopK;

  ChatBotModel({
    this.name,
    this.description,
    this.vectorDb,
    this.vectorDbCollection,
    this.embedModelProvider,
    this.embedModel,
    this.llmProvider,
    this.llm,
    this.loadIn_4bit,
    this.chunkingStrategy,
    this.semanticSplittingBufferSize,
    this.semanticSplittingBreakpointPercentileThreshold,
    this.retriverTopK,
  });
  ChatBotModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    description = json['description']?.toString();
    vectorDb = json['vector_db']?.toString();
    vectorDbCollection = json['vector_db_collection']?.toString();
    embedModelProvider = json['embed_model_provider']?.toString();
    embedModel = json['embed_model']?.toString();
    llmProvider = json['llm_provider']?.toString();
    llm = json['llm']?.toString();
    loadIn_4bit = json['load_in_4bit'];
    chunkingStrategy = json['chunking_strategy']?.toString();
    semanticSplittingBufferSize =
        json['semantic_splitting_buffer_size']?.toInt();
    semanticSplittingBreakpointPercentileThreshold =
        json['semantic_splitting_breakpoint_percentile_threshold']?.toInt();
    retriverTopK = json['retriver_top_k']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['vector_db'] = vectorDb;
    data['vector_db_collection'] = vectorDbCollection;
    data['embed_model_provider'] = embedModelProvider;
    data['embed_model'] = embedModel;
    data['llm_provider'] = llmProvider;
    data['llm'] = llm;
    data['load_in_4bit'] = loadIn_4bit;
    data['chunking_strategy'] = chunkingStrategy;
    data['semantic_splitting_buffer_size'] = semanticSplittingBufferSize;
    data['semantic_splitting_breakpoint_percentile_threshold'] =
        semanticSplittingBreakpointPercentileThreshold;
    data['retriver_top_k'] = retriverTopK;
    return data;
  }
}