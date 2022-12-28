class AddColumnToBlog < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :image, :text
  end
end
