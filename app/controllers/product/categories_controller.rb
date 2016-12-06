class Product::CategoriesController < Product::ProductController

  def index
  	@products = Product.all.order(created_at: :desc).paginate(page: params[:page], :per_page => 12)
  	@categories = Category.all
  end

  def show
  	@category = Category.find_by_id(params[:id])
  	@products = @category.groupcategory.order(created_at: :desc).paginate(page: params[:page], :per_page => 12)
  end
end
