class AddModelAndManufacturerToBikes < ActiveRecord::Migration[7.0]
  def change
    add_column :bikes, :Manufacturer, :string
  end
end
