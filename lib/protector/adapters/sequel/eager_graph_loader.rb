module Protector
  module Adapters
    module Sequel
      # Patches `Sequel::Model::Associations::EagerGraphLoader`
      module EagerGraphLoader extend ActiveSupport::Concern
        def initialize(dataset)
          super(dataset)

          if dataset.protector_subject?
            @row_procs.each do |k, v|
              @row_procs[k] = Dataset::Restrictor.new(dataset.protector_subject, v)
              @ta_map[k][1] = @row_procs[k] if @ta_map.key?(k)
            end
          end
        end
      end
    end
  end
end
