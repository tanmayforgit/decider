# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_08_033356) do

  create_table "decider_operations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "after_success_operation_id"
    t.integer "after_failure_operation_id"
    t.integer "workflow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["after_failure_operation_id"], name: "index_decider_operations_on_after_failure_operation_id"
    t.index ["after_success_operation_id"], name: "index_decider_operations_on_after_success_operation_id"
    t.index ["workflow_id"], name: "index_decider_operations_on_workflow_id"
  end

  create_table "decider_workflows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "initial_operation_id"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_decider_workflows_on_identifier"
  end

end
