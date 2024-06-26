///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class BaseRAGSettingsRetriver {
/*
{
  "top-k": 5
} 
*/

  int? topK;

  BaseRAGSettingsRetriver({
    this.topK,
  });
  BaseRAGSettingsRetriver.fromJson(Map<String, dynamic> json) {
    topK = json['top-k']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['top-k'] = topK;
    return data;
  }
}

class BaseRAGSettingsSemanticSplitting {
/*
{
  "buffer_size": 4,
  "breakpoint_percentile_threshold": 98
} 
*/

  int? bufferSize;
  int? breakpointPercentileThreshold;

  BaseRAGSettingsSemanticSplitting({
    this.bufferSize,
    this.breakpointPercentileThreshold,
  });
  BaseRAGSettingsSemanticSplitting.fromJson(Map<String, dynamic> json) {
    bufferSize = json['buffer_size']?.toInt();
    breakpointPercentileThreshold =
        json['breakpoint_percentile_threshold']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['buffer_size'] = bufferSize;
    data['breakpoint_percentile_threshold'] = breakpointPercentileThreshold;
    return data;
  }
}

class BaseRAGSettings {
/*
{
  "vector_db": [
    "chromadb"
  ],
  "vector_db_collection": "default",
  "embed_model_provider": [
    "huggingface"
  ],
  "embed_model": [
    "Snowflake/snowflake-arctic-embed-l"
  ],
  "llm_provider": [
    "huggingface"
  ],
  "llm": [
    "microsoft/Phi-3-mini-128k-instruct"
  ],
  "load_in_4bit": true,
  "chunking_strategy": [
    "semantic-splitting"
  ],
  "semantic-splitting": {
    "buffer_size": 4,
    "breakpoint_percentile_threshold": 98
  },
  "retriver": {
    "top-k": 5
  }
} 
*/

  List<String?>? vectorDb;
  String? vectorDbCollection;
  List<String?>? embedModelProvider;
  List<String?>? embedModel;
  List<String?>? llmProvider;
  List<String?>? llm;
  List<String?>? llamaCppLlm;
  List<String?>? ollamaLlm;
  bool? loadIn_4bit;
  List<String?>? chunkingStrategy;
  BaseRAGSettingsSemanticSplitting? semanticSplitting;
  BaseRAGSettingsRetriver? retriver;

  BaseRAGSettings({
    this.vectorDb,
    this.vectorDbCollection,
    this.embedModelProvider,
    this.embedModel,
    this.llmProvider,
    this.llm,
    this.llamaCppLlm,
    this.ollamaLlm,
    this.loadIn_4bit,
    this.chunkingStrategy,
    this.semanticSplitting,
    this.retriver,
  });
  BaseRAGSettings.fromJson(Map<String, dynamic> json) {
    if (json['vector_db'] != null) {
      final v = json['vector_db'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      vectorDb = arr0;
    }
    vectorDbCollection = json['vector_db_collection']?.toString();
    if (json['embed_model_provider'] != null) {
      final v = json['embed_model_provider'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      embedModelProvider = arr0;
    }
    if (json['embed_model'] != null) {
      final v = json['embed_model'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      embedModel = arr0;
    }
    if (json['llm_provider'] != null) {
      final v = json['llm_provider'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      llmProvider = arr0;
    }
    if (json['huggingface_llm'] != null) {
      final v = json['huggingface_llm'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      llm = arr0;
    }
    if (json['llama_cpp'] != null) {
      final v = json['llama_cpp'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      llamaCppLlm = arr0;
    }
    if (json['ollama'] != null) {
      final v = json['ollama'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      ollamaLlm = arr0;
    }
    loadIn_4bit = json['load_in_4bit'];
    if (json['chunking_strategy'] != null) {
      final v = json['chunking_strategy'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      chunkingStrategy = arr0;
    }
    semanticSplitting = (json['semantic-splitting'] != null)
        ? BaseRAGSettingsSemanticSplitting.fromJson(json['semantic-splitting'])
        : null;
    retriver = (json['retriver'] != null)
        ? BaseRAGSettingsRetriver.fromJson(json['retriver'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (vectorDb != null) {
      final v = vectorDb;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['vector_db'] = arr0;
    }
    data['vector_db_collection'] = vectorDbCollection;
    if (embedModelProvider != null) {
      final v = embedModelProvider;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['embed_model_provider'] = arr0;
    }
    if (embedModel != null) {
      final v = embedModel;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['embed_model'] = arr0;
    }
    if (llmProvider != null) {
      final v = llmProvider;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['llm_provider'] = arr0;
    }
    if (llm != null) {
      final v = llm;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['llm'] = arr0;
    }
    if (llamaCppLlm != null) {
      final v = llamaCppLlm;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['llama_cpp'] = arr0;
    }
    data['load_in_4bit'] = loadIn_4bit;
    if (chunkingStrategy != null) {
      final v = chunkingStrategy;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['chunking_strategy'] = arr0;
    }
    if (semanticSplitting != null) {
      data['semantic-splitting'] = semanticSplitting!.toJson();
    }
    if (retriver != null) {
      data['retriver'] = retriver!.toJson();
    }
    return data;
  }
}
