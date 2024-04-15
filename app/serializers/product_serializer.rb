class ProductSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers
    attributes :id, :name, :price, :category_id, :image_url
    def image_url
      if object.image.attached?
        {
          id: object.image.id,
          url: Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: false)
        }
      else
        nil
      end
    end
  end