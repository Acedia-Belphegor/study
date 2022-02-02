# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  def to_json(*)
    ActiveSupport::JSON.encode as_json
  end
end
