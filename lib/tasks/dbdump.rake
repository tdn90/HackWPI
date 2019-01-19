namespace :db do
    desc "TODO"
  
    task empty: :environment do
      #Freshen up that database
      ["groups_users", "assigntables", "line_items", "receipts", "payperiods", "groups"].each {|table_name|
        db = Rails.configuration.database_configuration[Rails.env]["database"]  
        ActiveRecord::Base.connection.execute("DELETE FROM `#{db}`.`#{table_name}`;")
        ActiveRecord::Base.connection.execute("ALTER TABLE `#{db}`.`#{table_name}` AUTO_INCREMENT = 1;")
      }
      puts "[success] Database is empty except for users"
    end
  
  end
  