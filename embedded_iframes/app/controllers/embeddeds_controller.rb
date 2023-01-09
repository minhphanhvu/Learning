class EmbeddedsController < ApplicationController
  def show
    headers["X-Frame-Options"] = "allowall"
    @embedded = Embedded.find_by(token: params[:id])
    render template: "#{@embedded.controller}/#{@embedded.action}", layout: false
  end

  def create
    @embedded = current_user.embeddeds.create(embedded_params)
    redirect_to [:edit, @embedded]
  end

  def edit
    @embedded = current_user.embeddeds.find(params[:id])
  end

  private

  def embedded_params
    params.require(:embedded).permit(:controller, :action)
  end
end
