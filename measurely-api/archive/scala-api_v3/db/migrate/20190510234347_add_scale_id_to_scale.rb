class AddScaleIdToScale < ActiveRecord::Migration[5.2]
  def change
    add_column :scale, :scale_id, :string
  end
end
