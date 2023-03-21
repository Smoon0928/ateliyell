class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.product_id = product.id
    if comment.save
       flash[:notice] = "コメント投稿に成功しました"
       redirect_to product_path(product)
    else
       flash[:notice] = "コメントできませんでした"
       redirect_to product_path(product)
    end
  end
  
  # def destroy
  #   Comment.find(params[:id]).destroy
  #   ##redirect_to product_path(params[:product_id])
  #   if comment.destroy
  #     flash[:notice] = "コメントの削除に成功しました"
  #     redirect_to product_path(product)
  #   else
  #     flash[:notice] = "コメント削除できませんでした"
  #     redirect_to product_path(product)
  #   end
  # end
  
  def destroy
  comment = Comment.find_by(id: params[:id])
    if comment
      comment.destroy
      flash[:notice] = "コメントの削除に成功しました"
    else
      flash[:alert] = "コメント削除に失敗しました"
    end
    redirect_to product_path(params[:product_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
