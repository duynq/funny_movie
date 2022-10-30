class UnauthorizedController < ApplicationController
  class << self
    def call(env)
      @respond ||= action :respond
      @respond.call env
    end
  end

  def respond
    flash[:danger] = request.env['warden.options'].fetch(:message, "unauthorized.user") unless request.get?
    redirect_to root_url
  end
end
