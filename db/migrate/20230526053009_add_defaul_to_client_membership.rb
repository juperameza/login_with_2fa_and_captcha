class AddDefaulToClientMembership < ActiveRecord::Migration[7.0]
  def change
    change_column_default :clients, :membership, true
  end
end
