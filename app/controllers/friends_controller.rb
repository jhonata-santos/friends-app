class FriendsController < ApplicationController
  # GET /friends
  def index
    @friends = Friend.order(:first_name).page(params[:page])
  end

  # GET /friends/1
  def show
    @friend = Friend.find(params[:id])
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
    @friend = Friend.find(params[:id])
  end

  # DELETE /friends/1
  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy

    respond_to do |format|
      if @friend.destroyed?
        format.html { redirect_to friends_url, flash: { success: 'Friend was successfully deleted.' } }
      else
        format.html { redirect_to friends_url, flash: { error: 'Friend was not deleted successfully' } }
      end
    end
  end

  # PATCH/PUT /friends/1
  def update
    @friend = Friend.find(params[:id])

    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friends_url, flash: { success: 'Friend was successfully updated.' } }
      else
        format.html { render :edit, flash: { error: 'Friend was not updated successfully' } }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :email, :phone, :gender)
  end
end
