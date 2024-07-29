class RenameManufacturerToBikes < ActiveRecord::Migration[7.0]
  def change
    rename_column :bikes, :Manufacturer, :manufacturer
  end
end
