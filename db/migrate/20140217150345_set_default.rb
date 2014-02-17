class SetDefault < ActiveRecord::Migration
  def self.up
    #change_coloumn(:users) do |t|
      ## Database authenticatable
     # t.integer :max_easy, :default => 0
      #t.integer :max_medium, :default => 0
      #t.integer :max_hard, :default => 0
      #def self.up
      #add_column :accounts, :max_users, :integer, :default => 10
          change_column :users, :max_easy, :integer, :default => 0
          change_column :users, :max_medium, :integer, :default => 0
          change_column :users, :max_hard, :integer, :default => 0
        end
  
  
  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end