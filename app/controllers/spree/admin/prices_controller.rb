module Spree
  module Admin
    class PricesController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink

      def create
        params[:vp].each do |variant_id, prices|
          variant = Spree::Variant.find(variant_id)
          if variant
            supported_currencies.each do |currency|
              price = variant.price_in(currency.iso_code)
              price.preferred_auto_update = prices[currency.iso_code][:auto_update]
              price.price = (prices[currency.iso_code].blank? ? nil : prices[currency.iso_code][:price])
              price.save! if price.changed?
            end
          end
        end
        render :action => :index
      end
    end
  end
end
