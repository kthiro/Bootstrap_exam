class DropFeeds2 < ActiveRecord::Migration[5.1]
  def change
    drop_table :feeds
  end
end
