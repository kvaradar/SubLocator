class NeedASub < ActiveRecord::Migration
  def self.up
    create_table :need_a_sub do |t|
      t.string :email_id
      t.timestamps
    end
  end

  def self.down
    drop_table :need_a_sub
  end
end
