# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_06_055623) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "project_id", null: false
    t.datetime "application_date", default: -> { "CURRENT_TIMESTAMP" }
    t.string "status", limit: 50, default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_applications_on_project_id"
    t.index ["student_id"], name: "index_applications_on_student_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", null: false
    t.string "department"
    t.string "email", null: false
    t.integer "created_by_admin", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_faculties_on_email", unique: true
  end

  create_table "project_faculties", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "faculty_id", null: false
    t.index ["faculty_id"], name: "index_project_faculties_on_faculty_id"
    t.index ["project_id", "faculty_id"], name: "index_project_faculties_on_project_id_and_faculty_id", unique: true
    t.index ["project_id"], name: "index_project_faculties_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "num_positions", null: false
    t.text "areas_of_research", null: false
    t.string "start_semester", limit: 50, null: false
    t.string "prefered_class", limit: 50
    t.text "other_comments"
    t.boolean "is_active", default: true
    t.datetime "filled_at"
    t.datetime "expires_at"
    t.integer "created_by_admin", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_projects", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_saved_projects_on_project_id"
    t.index ["student_id"], name: "index_saved_projects_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.string "major"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
  end

  add_foreign_key "applications", "projects"
  add_foreign_key "applications", "students"
  add_foreign_key "faculties", "admins", column: "created_by_admin"
  add_foreign_key "project_faculties", "faculties"
  add_foreign_key "project_faculties", "projects"
  add_foreign_key "projects", "admins", column: "created_by_admin"
  add_foreign_key "saved_projects", "projects"
  add_foreign_key "saved_projects", "students"
end
