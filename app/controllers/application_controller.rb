class ApplicationController < ActionController::Base
  helper_method :render_turbo_flash

  def render_turbo_flash
    return unless request.format.turbo_stream?
    return if response.status == 301 || response.status == 302

    turbo_stream.update('service-section', partial: 'shared/flash')
  end
end
