class Product::ProductsController < Product::ProductController

  def show
    @product = Product.find_by_id(params[:id])
    if @product.nil?
      redirect_to root_path
    else
      @categories = @product.incategory
    end
  end



  def index
  
  	if(params[:search].nil? || params[:search].empty?)
		@product = Product.all.order(created_at: :desc)
	else
		@product = Product.order(created_at: :desc).search(params[:category], params[:search])
	end
	if @product
  		@products = @product.paginate(page: params[:page], :per_page => 12)
  	else
  		@products = @product
  	end

  	@categories = Category.all
  end



end
