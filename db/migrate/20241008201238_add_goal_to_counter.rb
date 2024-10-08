class AddGoalToCounter < ActiveRecord::Migration[8.0]
  def change
    add_column :counters, :goal, :integer, default: 0
  end
end
