require "sinatra"
require "sendgrid-ruby"
include SendGrid
# require "json"
#require "mail"

require_relative "helpers"

get "/" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :index
end

get "/menu" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :menu
end

get "/product" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :product
end

post "/" do
  @name = params["name"]
  @email = params["email"]

  # Mail.deliver do
  #   from "warren.w.tai@gmail.com"
  #   to @email
  #   subject "Our Catalogue"
  #   body File.read("public/body.txt")
  # end

  from = SendGrid::Email.new(email: "warren.w.tai@gmail.com")
  to = SendGrid::Email.new(email: @email)
  subject = "Our Catalogue"
  content = SendGrid::Content.new(
    type: "text/plain",
    value: "Dear " + @name + ",\n
      Attached is the link to the catalogue of our bakery. Enjoy!\n
      Sincerely, \n
      Warren\n
      https://fathomless-island-16806.herokuapp.com/catalogue.pdf",
  )

  # create a email object with from, to, subject, and content
  mail = SendGrid::Mail.new(from, subject, to, content)

  # sets up the API kwy s

  sg = SendGrid::API.new(
    api_key: ENV["SENDGRID_API_KEY"],
  )

  # sends the email
  response = sg.client.mail._("send").post(request_body: mail.to_json)
  puts response.status_code

  # display http response body
  puts response.body

  # display http response headers
  puts response.headers
  render_view :post
end
