class AddReferenceToGroupCreatorId < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :creator, references: :users
  end
end
