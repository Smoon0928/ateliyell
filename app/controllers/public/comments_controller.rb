class Public::CommentsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.product_id = product.id
    comment.save
    redirect_to product_path(product)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
