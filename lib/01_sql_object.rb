require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    # rest of cols is hash of column data
    cols.map!(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize #class name
  end
# ::all return an array of all records in DB
  def self.all
    records = DBConnection.execute2(<<-SQL)
      SELECT * FROM #{@table_name}
    SQL
    records.drop(1).map { |e| self.new(e)  }
  end

  def self.parse_all(results)
    results.map do |record|
      # {:name=>"cat1", :owner_id=>1}
      self.new(record)
    end
  end
#::find look up a record by primary key
  def self.find(id)

  end

  def initialize(params = {})
    attributes
    params.each do |k, v|
      unless self.class.columns.include? k.to_sym
        raise "unknown attribute '#{k}'"
      end
      @attributes[k.to_sym] = v
      self.class.send(:define_method, k) do
        instance_variable_get(:"@#{k}")
      end
      self.class.send(:define_method, "#{k}=") do |v|
        instance_variable_set(:"@#{k}", v)
      end
    end
    # attributes
    # attribute_values
    # params.each do |k,v|
    #   @attributes << k
    #   # define_method(k.to_s) do
    #     instance_variable_get("@#{k}")
    #   # end
    #   @attribute_values << v
    #   # define_method("#{k}=") do |v|
    #     instance_variable_set("@#{k}", v)
    #   # end
    # end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |e| send(e) }
  end
# #insert a new row into the table
  def insert
    # col_names = self.class.columns.first.join(",")
    # question_marks = (["?"] * col_names.length).join(",")
    # DBConnection.execute2(<<-SQL, col_names, *attribute_values)
    #   INSERT INTO
    #     #{@table_name} #{col_names}
    #   VALUES
    #     ?
    # SQL
  end
# #update the row with the id of this SQLObject
  def update
  end
# #save calls insert/update depending on whether SQLObject exists
# a convenience method
  def save
    # ...
  end
end
