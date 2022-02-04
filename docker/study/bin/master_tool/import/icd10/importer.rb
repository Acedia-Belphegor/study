module MasterTool
  module Import
    module Icd10
      class Importer
        attr_reader :master_version

        def initialize(option = {})
          @master_version = option[:master_version] || LATEST_MASTER_VERSION
        end

        def perform
          MasterTool::Import::Icd10::BasicClass.new(master_version).perform
        end
      end
    end
  end
end
