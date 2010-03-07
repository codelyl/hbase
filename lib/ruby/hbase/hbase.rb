require 'hbase/admin'
require 'hbase/table'

module Hbase
  class Hbase
    attr_accessor :configuration

    def initialize
      # Create configuration
      self.configuration = HBaseConfiguration.create

      # Turn off retries in hbase and ipc.  Human doesn't want to wait on N retries.
      configuration.setInt("hbase.client.retries.number", 7)
      configuration.setInt("ipc.client.connect.max.retries", 3)
    end

    def admin(formatter)
      ::Hbase::Admin.new(configuration, formatter)
    end

    # Create new one each time
    def table(table, formatter)
      ::Hbase::Table.new(configuration, table, formatter)
    end
  end
end