class CreateCackleComments < ActiveRecord::Migration
  def change
    create_table :cackle_comments, id: false do |t|
      t.integer  :comment_id
      t.integer  :parent_id
      t.string   :post_id
      t.string   :url
      t.string   :title
      t.text     :message
      t.string   :status
      t.string   :ip
      t.string   :author_name
      t.string   :author_email
      t.string   :author_avatar 
      t.string   :author_www
      t.string   :author_provider
      t.string   :anonym_name
      t.string   :anonym_email
      t.timestamps
    end
  end
end
