class Document < ApplicationRecord
  include Chunkable
  include Parsable

  belongs_to :account, optional: true
  belongs_to :author, optional: true
  has_one_attached :file
  has_many :chat_documents, dependent: :destroy
  has_many :chats, through: :chat_documents

  validates :file, presence: true

  def context
    content
  end

  def titlize!
    update(title: file.filename.to_s)
  end
end
