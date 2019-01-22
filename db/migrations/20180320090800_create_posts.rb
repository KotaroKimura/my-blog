Hanami::Model.migration do
  change do
    create_table :posts do
      primary_key :id

      column :title,           String,   null: false
      column :body,            'text',   null: false
      column :published_state, Integer,  null: false, default: 0
      column :published_date,  DateTime, null: false
      column :created_at,      DateTime, null: false
      column :updated_at,      DateTime, null: false
    end
  end
end
