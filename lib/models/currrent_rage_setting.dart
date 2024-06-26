
///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class CurrentRAGSettings {
/*
{
  "embed_model_provider": "huggingface",
  "id": 2,
  "llm_provider": "huggingface",
  "load_in_4bit": true,
  "semantic_splitting_buffer_size": 1,
  "retriver_top_k": 5,
  "embed_model": "Snowflake/snowflake-arctic-embed-l",
  "vector_db": "chromadb",
  "vector_db_collection": "default",
  "llm": "microsoft/Phi-3-mini-128k-instruct",
  "chunking_strategy": "semantic-splitting",
  "semantic_splitting_breakpoint_percentile_threshold": 95
} 
*/

  String? embedModelProvider;
  int? id;
  String? llmProvider;
  bool? loadIn_4bit;
  int? semanticSplittingBufferSize;
  int? retriverTopK;
  String? embedModel;
  String? vectorDb;
  String? vectorDbCollection;
  String? llm;
  String? chunkingStrategy;
  int? semanticSplittingBreakpointPercentileThreshold;

  CurrentRAGSettings({
    this.embedModelProvider,
    this.id,
    this.llmProvider,
    this.loadIn_4bit,
    this.semanticSplittingBufferSize,
    this.retriverTopK,
    this.embedModel,
    this.vectorDb,
    this.vectorDbCollection,
    this.llm,
    this.chunkingStrategy,
    this.semanticSplittingBreakpointPercentileThreshold,
  });
  CurrentRAGSettings.fromJson(Map<String, dynamic> json) {
    embedModelProvider = json['embed_model_provider']?.toString();
    id = json['id']?.toInt();
    llmProvider = json['llm_provider']?.toString();
    loadIn_4bit = json['load_in_4bit'];
    semanticSplittingBufferSize = json['semantic_splitting_buffer_size']?.toInt();
    retriverTopK = json['retriver_top_k']?.toInt();
    embedModel = json['embed_model']?.toString();
    vectorDb = json['vector_db']?.toString();
    vectorDbCollection = json['vector_db_collection']?.toString();
    llm = json['llm']?.toString();
    chunkingStrategy = json['chunking_strategy']?.toString();
    semanticSplittingBreakpointPercentileThreshold = json['semantic_splitting_breakpoint_percentile_threshold']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['embed_model_provider'] = embedModelProvider;
    data['id'] = id;
    data['llm_provider'] = llmProvider;
    data['load_in_4bit'] = loadIn_4bit;
    data['semantic_splitting_buffer_size'] = semanticSplittingBufferSize;
    data['retriver_top_k'] = retriverTopK;
    data['embed_model'] = embedModel;
    data['vector_db'] = vectorDb;
    data['vector_db_collection'] = vectorDbCollection;
    data['llm'] = llm;
    data['chunking_strategy'] = chunkingStrategy;
    data['semantic_splitting_breakpoint_percentile_threshold'] = semanticSplittingBreakpointPercentileThreshold;
    return data;
  }
}
