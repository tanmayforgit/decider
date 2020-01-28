class CreateOperation < ActiveRecord::Migration[5.0]
  def self.up
    create_table :decider_operations do |t|
      t.string  :name
      t.integer  :after_success_operation_id
      t.integer  :after_failure_operation_id
      t.integer  :workflow_id
      t.timestamps
    end

    add_index :decider_operations, :workflow_id
    add_index :decider_operations, :after_failure_operation_id
    add_index :decider_operations, :after_success_operation_id
  end

  def self.down
    drop_table :workflows
  end
end
