class FeedbacksController < ApplicationController
    # GET /products/:product_id/feedbacks
    def index
        @product = Product.find(params[:product_id])
        @feedbacks = @product.feedbacks
    end

    # GET /products/:product_id/feedbacks/new
    def new
        @product = Product.find(params[:product_id])
        @feedback = @product.feedbacks.build
    end

    def create
        @feedback = Feedback.new(feedback_params)
        @product = Product.find(feedback_params[:product_id])

        respond_to do |format|
            if @feedback.save
                format.html { redirect_to products_path, notice: "Feedback submitted!" }
            end
        end
    end

    private

    def feedback_params
        params.require(:feedback).permit(:product_id, :rating, :content)
    end
end
