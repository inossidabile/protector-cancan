module Protector
  module CanCan
    module Resource extend ActiveSupport::Concern
      included do
        alias_method_chain :load_resource, :protector
        alias_method_chain :load_collection, :protector
        alias_method_chain :load_collection?, :protector
      end

      def load_resource_with_protector
        resource = load_resource_without_protector

        if is_protected_resource?(resource) && !resource.protector_subject?
          resource.restrict!(current_ability.protector_subject)
        else
          resource
        end
      end

      def load_collection_with_protector
        resource = resource_base

        if is_protected_resource? resource
          # resource will be restricted by load_resource later.
          resource
        else
          load_collection_without_protector
        end
      end

      def load_collection_with_protector?
        if is_protected_resource? resource_base
          true
        else
          load_collection_without_protector?
        end
      end

      private

      def is_protected_resource?(resource)
        resource.respond_to?(:restrict!) &&
        current_ability.protector_subject?
      end
    end
  end
end