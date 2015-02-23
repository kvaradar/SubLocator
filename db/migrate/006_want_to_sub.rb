class WantToSub < ActiveRecord::Migration
  def self.up
    create_table :want_to_sub do |t|
      t.string :email_id
      t.timestamps
    end
  end

  def self.down
    drop_table :want_to_sub
  end
end
