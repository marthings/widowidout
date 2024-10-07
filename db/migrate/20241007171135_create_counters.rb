class CreateCounters < ActiveRecord::Migration[8.0]
  def change
    create_table :counters do |t|
      t.string :title
      t.string :emoji
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
