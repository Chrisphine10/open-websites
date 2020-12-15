module Api
    module V1
      class WebsitesController < ApplicationController
        protect_from_forgery with: :null_session
        def index
          websites = Website.all
          render json: WebsiteSerializer.new(websites, options).serialized_json
        end
        def show
          website = Website.find_by(slug: params[:slug])
          render json: WebsiteSerializer.new(website, options).serialized_json
        end
        def create
          website = Website.new(website_params)

          if website.save
            render json: WebsiteSerializer.new(website).serialized_json
          else
            render json: {error: website.errors.messages }, status: 422
          end
        end
        def update
          website = Website.find_by(slug: params[:slugs])

          if website.update(website_params)

            render json: WebsiteSerializer.new(website, options).serialized_json
          else
            render json: {error: website.messages }, status: 422
          end
        end
        def destroy
            website = Website.find_by(slug: params[:slugs])
  
            if website.destroy
  
              head :no_content
            else
              render json: {error: website.messages }, status: 422
            end
        end
        private
        def website_params
          params.require(:website).permit(:name, :image_url, :slug)
        end
        def options
          @options ||= {include: %i[reviews]}
        end
      end
    end
  end