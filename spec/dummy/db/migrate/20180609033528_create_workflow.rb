class CreateWorkflow < ActiveRecord::Migration[5.0]
  def self.up
    create_table :decider_workflows do |t|
      t.string  :name
      t.integer  :initial_operation_id
      t.timestamps
    end
  end

  def self.down
    drop_table :workflows
  end
end
