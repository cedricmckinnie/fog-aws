module Fog
  module Parsers
    module AWS
      module ELBV2
        class Empty < Fog::Parsers::Base
          def reset
            @response = { 'ResponseMetadata' => {} }
          end

          def start_element(name, attrs = [])
            super
          end

          def end_element(name)
            case name
            when 'RequestId'
              @response['ResponseMetadata'][name] = value
            end
          end
        end
      end
    end
  end
end
