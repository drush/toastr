require 'generators/toastr/next_migration_version'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Toastr
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend NextMigrationVersion

    source_paths << File.join(File.dirname(__FILE__), 'templates')

    def create_migration_file
      migration_template 'toast_migration.rb', 'db/migrate/create_toasts.rb'
    end

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number dirname
    end
  end
end