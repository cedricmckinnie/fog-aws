require 'fog/core/model'

module Fog
  module Bluebox
    class DNS

      class Record < Fog::Model

        identity :id

        attribute :name
        attribute :domain_id,   :aliases => 'domain-id'
        attribute :domain
        attribute :type
        attribute :content

        def initialize(attributes={})
          super
        end

        def destroy
          requires :identity
          connection.delete_record(@zone.identity, identity)
          true
        end

        def zone
          @zone
        end

        def save
          requires :zone, :type, :name, :content
          data = unless identity
            connection.create_record(@zone.id, type, name, content)
          else
            connection.update_record(@zone.id, identity, {:type => type, :name => name, :content => content})
          end
          merge_attributes(data.body)
          true
        end

        private

        def zone=(new_zone)
          @zone = new_zone
        end

      end

    end
  end
end
