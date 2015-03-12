class MessagesController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Mine

  def emailin
    render nothing: true
    @user = User.find(3)
    #content = params['mandrill_events']
    # Mandrill needs an ok in order to proceed to POST Mandrill events to this endpoint.
  	if request.head?
  		head :ok
  	else params['mandrill_events']
  		text_body = ''
  		JSON.parse(params['mandrill_events']).each do |raw_event|
  			event = Mandrill::WebHook::EventDecorator[raw_event]
  			text_body = event['msg']['text'].to_s
  		end
      @content = text_body
      @message = @message.new(:body => text_body, :from => 'from' , :to => 'to', :user_id => 3)
      @message.save
      # UserMailer.msg(@user, @content).deliver
      # sms out
    end
  end


  			# Get the URL of the craigslist listing.
  		# 	url = text_body[/http\:(.*?)\.html/m]

  			# Mechanize to get email address and phone number.
  # 			a = Mechanize.new

  #       		begin
  # 				craigslist_listing = a.get(url.to_s)
		# 	rescue ArgumentError
		# 		# URL is not valid
		# 		puts "\n\n\n\nURL IS NOT VALID\n\n\n\n"
		# 		return "error"
		# 	else
		# 		# Regex to get email and phone number
		# 		email_addresses = craigslist_listing.content.to_s.scan(/[\w.!#\$%+-]+@[\w-]+(?:\.[\w-]+)+/).uniq!
		# 		phone_numbers = craigslist_listing.content.to_s.scan(/\W(\d{3}.?\d{3}.?\d{4})\W/m).uniq! - craigslist_listing.content.to_s.scan(/postingID=(.*?)\W/mi).uniq!

		# 		# 'Click-to-call'.
		# 		phone_numbers.each do |phone_number|
		# 			# puts phone_number
		# 			# Make outbound call to 314 (Andy, Jeff, whoever else).
		# 			# Then, make outbound call to phone number.
		# 			click_to_call(phone_number[0])
		# 		end

				# Send templatized email to email_address.

		# 	end
  # 		end
  # 	end
  # end





    # UserMailer.msg(@user, content[:msg]).deliver
    #do some redick email stuff
    #sms out    sms_create(email_reply.body.decoded, to_gorp)

  # end
    # mailin_user = ENV['MAILINUSER']
    #   mailin_pass = ENV['MAILINPASS']

    #   Mail.defaults do
    #   retriever_method :pop3, :address    => "pop.zoho.com",
    #                           :port       => 995,
    #                           :user_name  => mailin_user,
    #                           :password   => mailin_pass,
    #                           :enable_ssl => true
    #   end

    #   email_reply = Mail.first

    #   if Mail.all.any?
    #     to_gorp = email_reply.subject
    #     to_gorp[0..4] = ""

    #     sms_create(email_reply.body.decoded, to_gorp)

    #     Mail.delete_all
    #   end
    # end


  def smsin
    sms_body = params['Body']
    sms_from = params['From']

    mailout_user = ENV['MAILOUTUSER']
    mailout_pass = ENV['MAILOUTPASS']
    mailin_user = ENV['MAILINUSER']

    mailoptions = { :address         => "smtp.gmail.com",
              :port                 => 587,
              :domain               => 'gmail.com',
              :user_name            => mailout_user,
              :password             => mailout_pass,
              :authentication       => 'plain',
              :enable_starttls_auto => true  }

    Mail.defaults do
      delivery_method :smtp, mailoptions
    end

    Mail.deliver do
      to 'massaad@gmail.com'
      from 'massaad@gmail.com'
      reply_to mailin_user
      subject "#{sms_from}"
      body "From: #{sms_from} SMS: #{sms_body} "
    end


    if sms_body.to_s.length < 1
      "No SMS."
    else
      "The sms arrived. #{sms_body}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :from, :to, :user_id)
    end

end
