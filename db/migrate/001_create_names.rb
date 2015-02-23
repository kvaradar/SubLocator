class CreateNames < ActiveRecord::Migration
  def self.up
    create_table :profile do |t|
      t.string :name
      t.string :email_id
      t.string :city
      t.string :centre
      t.string :shelter_home
      t.string :project
      t.timestamps
    end
  end

  def self.down
    drop_table :names
  end
end
