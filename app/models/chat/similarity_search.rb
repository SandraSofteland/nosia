module Chat::SimilaritySearch
  extend ActiveSupport::Concern

  def similarity_search(question)
    # If chat has specific documents, search only within those documents
    # Otherwise, search all account chunks
    chunks = if documents.any?
      Chunk.where(chunkable: documents).search_by_similarity(question, limit: retrieval_fetch_k)
    else
      account.chunks.search_by_similarity(question, limit: retrieval_fetch_k)
    end
    
    augmented_context = ActiveModel::Type::Boolean.new.cast(ENV["AUGMENTED_CONTEXT"])
    chunks.select { |chunk| context_relevance(augmented_context ? chunk.augmented_context : chunk.context, question:) }
  end
end
