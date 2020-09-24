class AddUuidToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :uuid, :string
  end
end
