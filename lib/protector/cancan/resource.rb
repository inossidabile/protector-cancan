module Protector
  module CanCan
    module Resource extend ActiveSupport::Concern
      included do
        alias_method_chain :load_resource, :protector
        alias_method_chain :load_collection, :protector
      end

      def load_resource_with_protector(*args)
        resource = load_resource_without_protector(*args)

        if resource.respond_to?(:restrict!) \
            && !resource.protector_subject? \
            && current_ability.protector_subject?

          resource = resource.restrict!(current_ability.protector_subject)
        end
        
        resource
      end

      def load_collection_with_protector(*args)
        collection = load_collection_without_protector(*args)

        if collection.respond_to?(:restrict!) \
            && !collection.protector_subject? \
            && current_ability.protector_subject?

          collection = collection.restrict!(current_ability.protector_subject)
        end
        
        collection
      end
    end
  end
end