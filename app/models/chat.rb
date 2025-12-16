class Chat < ApplicationRecord
  include AnswerRelevance
  include AugmentedPrompt
  include Completionable
  include ContextRelevance
  include ModelContextProtocol
  include SimilaritySearch

  acts_as_chat
  broadcasts_to ->(chat) { [ chat, "messages" ] }

  belongs_to :account
  belongs_to :chat, optional: true
  belongs_to :user
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chat_documents, dependent: :destroy
  has_many :documents, through: :chat_documents

  scope :root, -> { where(chat_id: nil) }

  def first_question
    messages.where(role: "user").order(:created_at).first&.question
  end

  def response_number
    messages.count
  end

  def title
    first_question
  end
end
