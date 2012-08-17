class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :name, :string
      t.column :url, :string
      t.column :new_window, :boolean
    end
  end

  def self.down
    drop_table :links
  end
end
