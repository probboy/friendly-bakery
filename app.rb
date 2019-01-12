require "sinatra"

require_relative "helpers"

get "/" do
  @page_title = "Cake Shop"
  @body_id = "home"
  @site_title = "Cake Shop"
  render_view :index
end

get "images/*.jpg" do
end
