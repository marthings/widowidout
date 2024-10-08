class AddColorToCounter < ActiveRecord::Migration[8.0]
  def change
    add_column :counters, :color, :string, default: "#ffffff"
  end
end
