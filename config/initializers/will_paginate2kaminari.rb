module WillPaginate2Kaminari
  module ActiveRecord
    # @param Hash patinate_options
    #   page
    #   per_page
    def paginate(paginate_options)
      paginate_options = paginate_options.with_indifferent_access
      self.page(paginate_options[:page]).per(paginate_options[:per_page])
    end
  end

  module Array
    # @param Hash patinate_options
    #   page
    #   per_page
    def paginate(paginate_options)
      paginate_options = paginate_options.with_indifferent_access
      Kaminari.paginate_array(self).page(paginate_options[:page]).per(paginate_options[:per_page])
    end
  end
end

ActiveSupport.on_load(:active_record) do
  Kaminari::ActiveRecordModelExtension.include(WillPaginate2Kaminari::ActiveRecord)
end
Array.include(WillPaginate2Kaminari::Array)
