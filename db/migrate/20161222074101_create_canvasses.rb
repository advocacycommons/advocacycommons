class CreateCanvasses < ActiveRecord::Migration[5.0]
  def change
    create_table :canvasses do |t|
      t.string :origin_system
      t.datetime :action_date
      t.string :contact_type
      t.string :imput_type
      t.boolean :sucess
      t.string :status_code
      t.references :canvassing_effort
      t.belongs_to :canvasser, index: true, :class_name => 'Person'
      t.belongs_to :target, index: true, :class_name => 'Person'
      t.timestamps
    end
  end
end
