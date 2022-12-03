class AddInstructorsAttributes < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :name, :string
  end
end
