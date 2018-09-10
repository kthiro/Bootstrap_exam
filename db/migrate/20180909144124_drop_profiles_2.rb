class DropProfiles2 < ActiveRecord::Migration[5.1]
  def change
    drop_table :profiles
  end
end
