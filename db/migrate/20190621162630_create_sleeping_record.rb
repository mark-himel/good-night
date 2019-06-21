class CreateSleepingRecord < ActiveRecord::Migration[5.2]
  def change
    create_table :sleeping_records do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.datetime :check_in_time, null: false
      t.datetime :check_out_time
      t.date :date, null: false
      t.timestamps
    end
    add_index :sleeping_records, %i(user_id date check_in_time), unique: true
  end
end
