class FriendsController < ApplicationController
  helper_method :sort_column, :sort_direction
  skip_before_action :verify_authenticity_token
  respond_to :html, :json

  # GET /friends
  def index
    @friends = Friend.order("#{sort_column} #{sort_direction}").page(params[:page])
    respond_with(@friends)
  end

  # GET /friends/1
  def show
    @friend = find_friend
    respond_with(@friend)
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not found friend' }.to_json, status: 404
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
    @friend = find_friend
  end

  # POST /friends
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friends_url, flash: { success: 'Friend successfully created.' } }
        format.json { render json: { success: 'Friend successfully created.' }.to_json, status: 201 }
      else
        format.html { render :new, flash: { error: 'Friend was NOT created!' } }
        format.json { render json: { error: 'Friend was NOT created!' }.to_json, status: 400 }
      end
    end
  end

  # PATCH/PUT /friends/1
  def update
    @friend = find_friend

    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friends_url, flash: { success: 'Friend was successfully updated.' } }
        format.json { render json: { success: 'Friend was successfully updated.' }.to_json, status: 200 }
      else
        format.html { render :edit, flash: { error: 'Friend was NOT updated!' } }
        format.json { render json: { error: 'Friend was NOT updated!' }.to_json, status: 400 }
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not found friend' }.to_json, status: 404
  end

  # DELETE /friends/1
  def destroy
    @friend = find_friend
    @friend.destroy

    respond_to do |format|
      if @friend.destroyed?
        format.html { redirect_to friends_url, flash: { success: 'Friend was successfully deleted.' } }
        format.json { render json: { success: 'Friend was successfully deleted.' }.to_json, status: 200 }
      else
        format.html { redirect_to friends_url, flash: { error: 'Friend was NOT deleted!' } }
        format.json { render json: { error: 'Friend was NOT deleted!' }.to_json, status: 400 }
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not found friend' }.to_json, status: 404
  end

  private

  def find_friend
    Friend.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :email, :phone, :gender, :city, :state, :postal_code)
  end

  def sort_column
    Friend.column_names.include?(params[:sort]) ? params[:sort] : 'first_name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
