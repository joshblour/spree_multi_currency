module Spree
  module Admin
    class PricesController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink

      def create
        params[:vp].each do |variant_id, prices|
          variant = Spree::Variant.find(variant_id)
          base_currency = Spree::Config[:currency]
          base_price = prices[base_currency][:price].to_money(base_currency)
          
          if variant
            supported_currencies.each do |currency|
              price = variant.price_in(currency.iso_code)
              price.preferred_auto_update = currency == base_currency ? false : prices[currency.iso_code][:auto_update]
              
              if price.preferred_auto_update
                price.price = base_price.exchange_to(currency.iso_code)
              else
                price.price = (prices[currency.iso_code].blank? ? nil : prices[currency.iso_code][:price])
              end

              price.save! if price.changed?
            end
          end
        end
        render :action => :index
      end
      
    end
  end
end
