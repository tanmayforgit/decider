class CreateWorkflow < ActiveRecord::Migration
  def self.up
    create_table :workflows do |t|
      t.string  :name
      t.integer  :initial_operation_id
      t.timestamps
    end
  end

  def self.down
    drop_table :workflows
  end
end
