# frozen_string_literal: true

class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.string :start_address, array: true
      t.string :destination_address, array: true
      t.string :status

      t.timestamps
    end
  end
end
