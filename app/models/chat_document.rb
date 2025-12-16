class ChatDocument < ApplicationRecord
  belongs_to :chat
  belongs_to :document

  validates :chat_id, uniqueness: { scope: :document_id }
end
