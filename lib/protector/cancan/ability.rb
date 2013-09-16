require 'set'

module Protector
  module CanCan
    module Ability

      def import_protector(subject)
        @protector_subject = subject
        @protector_subject_defined = true
      end

      def protector_subject
        @protector_subject
      end

      def protector_subject?
        !!@protector_subject_defined
      end

      def self.included(mod)
        mod.class_eval do

          def can_with_protector?(action, entity_set, *extra_args)
            if entity_set.is_a? Hash
              entity = entity_set.values.first
            else
              entity = entity_set
            end

            if entity.respond_to?(:restrict!) && @protector_subject_defined
              @protector_models ||= Set.new

              model = entity
              model = model.class unless model.is_a?(Class)

              unless @protector_models.include?(model)
                meta = entity.is_a?(Class) ? entity.protector_meta.evaluate(@protector_subject)
                                           : entity.protector_meta(@protector_subject)

                meta.access.each do |action, fields|
                  action = :read if action == :view # *doh*
                  can action, model unless fields.empty?
                end

                can :destroy, model if meta.destroyable?

                @protector_models << model
              end
            end

            can_without_protector? action, entity_set, *extra_args
          end

          alias_method_chain :can?, :protector
        end
      end
    end
  end
end