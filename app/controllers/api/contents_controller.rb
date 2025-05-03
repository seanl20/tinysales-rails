module Api
  class ContentsController < ApplicationController
    protect_from_forgery with: :null_session
    # before_action :authenticate_user!

    def create
      result = Contents::Commands::Create.new.call(params: content_params)

      case result
      in Success(content:)
        @content = content
        respond_to do |format|
          format.turbo_stream
        end
      end
    end

    def update
      result = Contents::Commands::Update.new.call(id: params[:id], params: content_params)

      case result
      in Success(content:)
        @content = content
        respond_to do |format|
          format.json do
            render json: {}, status: 201
          end
        end
      end
    end

    private

    def content_params
      params.require(:content).permit(:name, :file_size, :file_type, :file)
    end
  end
end
