class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer    :reference_id
      t.string     :reference_class
      t.string     :message
      t.integer    :owner_id
      t.integer    :recipient_id
      t.boolean    :read, default: false

      t.timestamps
    end
  end
end
