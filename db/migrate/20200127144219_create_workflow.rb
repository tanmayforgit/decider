class CreateWorkflow < ActiveRecord::Migration[5.0]
  def self.up
    create_table :nayati_workflows do |t|
      t.string  :name
      t.integer  :initial_operation_id
      t.string :identifier
      t.timestamps
    end

    add_index :nayati_workflows, :identifier
  end

  def self.down
    drop_table :nayati_workflows
  end
end
