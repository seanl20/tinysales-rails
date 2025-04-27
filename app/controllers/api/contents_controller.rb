module Api
  class ContentsController < ApplicationController
    protect_from_forgery with: :null_session
    # before_action :authenticate_user!

    def create
      result = Contents::Commands::Create.new.call(params: content_params)

      case result
      in Success(content:)
        render json: ContentSerializer.new(content).serializable_hash.to_json
      end
    end

    private

    def content_params
      params.require(:content).permit(:name)
    end
  end
end
