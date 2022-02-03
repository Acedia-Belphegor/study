module MasterTool
  module Import
    module MedisStandardDisease
      class Importer
        attr_reader :master_version

        def initialize(option = {})
          @master_version = option[:master_version] || LATEST_MASTER_VERSION
        end

        def perform
          MasterTool::Import::MedisStandardDisease::Disease.new(master_version).perform
          MasterTool::Import::MedisStandardDisease::Modifier.new(master_version).perform
          MasterTool::Import::MedisStandardDisease::Index.new(master_version).perform
        end
      end
    end
  end
end
