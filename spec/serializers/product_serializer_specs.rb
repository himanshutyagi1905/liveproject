require 'rails_helper'

RSpec.describe ProductSerializer, type: :serializer do
  let(:product) { create(:product) }

  describe '#image_url' do
    context 'when image is attached' do
      it 'returns the correct image URL' do
        product.image.attach(io: File.open('path/to/your/image.jpg'), filename: 'image.jpg', content_type: 'image/jpeg')

        serializer = ProductSerializer.new(product)
        expect(serializer.image_url).to be_present
        expect(serializer.image_url).to include('your_domain.com') # Replace with your domain
        # Add more expectations as needed
      end
    end

    context 'when image is not attached' do
      it 'returns nil' do
        serializer = ProductSerializer.new(product)
        expect(serializer.image_url).to be_nil
      end
    end
  end
end