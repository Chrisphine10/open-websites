module Api
  module V1
    class ReviewsController < ApplicationController
      protect_from_forgery with: :null_session
      def create
        review = Review.new(review_params)

        if review.save
          render json: ReviewSerializer.new(review).serialized_json
        else
          render json {error: review.errors.message }, status: 422
        end
      end
      def destroy
        review = Review.find_by(params[:id])

        if review.destroy
          render json: ReviewSerializer.new(review).serialized_json
        else
          head :no_content
        end
      end

      private
      def review_params
        params.require(:reviews).permit(:title, :description, :score, :website_id)
      end
    end
  end
end