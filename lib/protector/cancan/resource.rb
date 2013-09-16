module Protector
  module CanCan
    module Resource extend ActiveSupport::Concern
      included do
        alias_method_chain :resource_base, :protector
        alias_method_chain :load_collection, :protector
        alias_method_chain :load_collection?, :protector
      end

      def resource_base_with_protector
        resource = resource_base_without_protector

        if resource_protectable? resource
          resource.restrict!(current_ability.protector_subject)
        else
          resource
        end
      end

      def load_collection_with_protector
        resource = resource_base

        if resource_protectable? resource
          resource
        else
          load_collection_without_protector
        end
      end

      def load_collection_with_protector?
        if resource_protectable? resource_base
          true
        else
          load_collection_without_protector?
        end
      end

      private

      def resource_protectable?(resource)
        resource.respond_to?(:restrict!) &&
        current_ability.protector_subject?
      end
    end
  end
end