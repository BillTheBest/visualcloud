class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :label
      t.integer :xpos
      t.integer :ypos
      t.integer :size
      t.integer :ami_id
      t.references :graph
      t.references :resource_type
      t.string :url
      t.string :aws_instance_id

      t.timestamps
    end
  end
end
