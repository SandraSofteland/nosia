class CreateChatDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_documents do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :document, null: false, foreign_key: true

      t.timestamps
    end

    add_index :chat_documents, [:chat_id, :document_id], unique: true
  end
end
