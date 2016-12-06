module ProductsHelper
  def robohash_for(product)
    robohash_url = "https://robohash.org/#{product.name}.png?size=250x300"
    image_tag(robohash_url, alt: product.name, class: "robohash")
  end
end
