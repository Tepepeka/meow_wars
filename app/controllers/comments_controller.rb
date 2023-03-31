class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to product_path(@product), notice: "Comment was successfully created."
    else
      redirect_to product_path(@product), alert: "Comment was not created."
    end

  end

  def destroy
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    redirect_to product_path(@product), status: :see_other, notice: "Comment was successfully destroyed."
  end


  #######
  private
  #######

  def comment_params
    params.require(:comment).permit(:body)
  end

end