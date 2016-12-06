class User::AddressListsController < User::UserController
  before_action :logged_in_user

  def new
    @user = current_user
    @address_list = AddressList.new
  end
  
  def index
    @user = current_user
    @address_lists = @user.address_lists.paginate(page: params[:page])
  end

  def create
    @user = current_user
    @address = AddressList.new(address_params)
    if @address.save
      flash[:success] = "Created new address successful!"
      redirect_back_or address_lists_path
    else
      redirect_to new_address_list_path
    end
  end

  def edit
    @user = current_user
    @address_list = AddressList.find(params[:id])
  end

  def update
    @user = current_user
    @address_list = AddressList.find(params[:id])
    if @address_list.update_attributes(address_params)
      flash[:success] = "Updated address successful!"
      redirect_to address_lists_path
    else
      redirect_to edit_address_list_path(params[:id])
    end
  end

  def destroy
    AddressList.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to address_lists_path
  end

  def filter_districts_by_province
    @filtered_districts = District.all.where(province_id: params[:selected_province])
  end

  def filter_wards_by_district
    @filtered_wards = Ward.all.where(district_id: params[:selected_district])
  end

  private
    def address_params
      params.require(:address_list).permit( :name,:user_id,:phone_number, :address,:ward_id  )
    end
end
