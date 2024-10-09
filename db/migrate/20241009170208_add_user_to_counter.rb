class AddUserToCounter < ActiveRecord::Migration[8.0]
  def change
    add_reference :counters, :user, null: false, foreign_key: true
  end
end
