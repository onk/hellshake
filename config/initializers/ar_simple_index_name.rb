# http://qiita.com/kamipo/items/6e5a1e238d7cc0611ade
ActiveSupport.on_load :active_record do
  module ActiveRecord::ConnectionAdapters
    # simple index name
    module SchemaStatements
      def index_name_with_simple(table_name, options)
        if Hash === options && options[:column] # rubocop:disable Style/CaseEquality
          Array.wrap(options[:column]) * "_and_"
        else
          index_name_without_simple(table_name, options)
        end
      end
      alias_method_chain :index_name, :simple
    end
  end
end
