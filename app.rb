require "sinatra"
require "sendgrid-ruby"
include SendGrid
require "json"

require_relative "helpers"

get "/" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :index
end

get "/about" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :about
end

get "/menu" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :menu
end

get "/membership" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :membership
end

get "/contact" do
  @page_title = "Warren's AI Cake Shop"
  @body_id = "home"
  @site_title = "Warren's AI Cake Shop"
  render_view :contact
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

  from = SendGrid::Email.new(email: "warren.w.tai@gmail.com")
  to = SendGrid::Email.new(email: @email)
  subject = "Our Catalogue"
  content = SendGrid::Content.new(
    type: "text/plain",
    value: "Dear " + @name + ",\n
    Attached is the catalogue of our bakery. Enjoy!\n
    Sincerely, Warren",
  )

  # create a email object with from, to, subject, and content
  mail = SendGrid::Mail.new(from, subject, to, content)
  attachment = Attachment.new
  attachment.type = "application/pdf"
  attachment.filename = "/catalogue.pdf"
  attachment.disposition = "attachment"
  attachment.content_id = "Catalogue"
  mail.add_attachment(attachment)
  # sets up the API kwy

  sg = SendGrid::API.new(
    api_key: ENV["SENDGRID_API_KEY"],
  )

  # sends the email
  response = sg.client.mail._("send").post(request_body: mail.to_json)

  erb :post
end
