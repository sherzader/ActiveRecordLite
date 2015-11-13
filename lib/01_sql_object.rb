require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns

  end

  def self.finalize!

  end

  def self.table_name=(table_name)
    table_name.tableize
  end

  def self.table_name
    table_name.tableize
  end
# ::all return an array of all records in DB
  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end
#::find look up a record by primary key
  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end
# #insert a new row into the table
  def insert
    # ...
  end
# #update the row with the id of this SQLObject
  def update
    # ...
  end
# #save calls insert/update depending on whether SQLObject exists
# a convenience method
  def save
    # ...
  end
end
