class ChangeLikesTableToPolymorphic < ActiveRecord::Migration[6.1]
  def up
    change_table :likes do |t|
      t.remove_references :post, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, index: true
    end
  end

  def down
    change_table :likes do |t|
      t.remove_references :likeable, polymorphic: true, index: true
      t.references :post, null: false, foreign_key: true
    end
  end
end
