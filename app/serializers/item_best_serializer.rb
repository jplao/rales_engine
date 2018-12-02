class ItemBestSerializer
  include FastJsonapi::ObjectSerializer

  attribute :best_day do |object|
    object.created_at
  end
end
