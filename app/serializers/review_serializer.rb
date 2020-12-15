class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :website_id
end
