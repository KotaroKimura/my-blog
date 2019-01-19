Hanami::Model.migration do
  change do
    create_table :images do
      primary_key :id

      foreign_key :post_id, :posts, on_delete: :cascade, null: false

      column :name, String, null: false
      column :image_data, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
