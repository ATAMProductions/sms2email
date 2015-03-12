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
  # POST /emailin
  def emailin
    render nothing: true
    @user = User.find(3)
    # Mandrill needs an ok in order to proceed to POST Mandrill events to this endpoint.
  	if request.head?
  		head :ok
  	else params['mandrill_events']
  		text_body = ''
  		JSON.parse(params['mandrill_events']).each do |raw_event|
  			event = Mandrill::WebHook::EventDecorator[raw_event]
  			text_body = event['msg']['text'].to_s
  			text_subject = event['msg']['subject']
  			text_subject[0..4] = ""
  			@content = text_body
        @message = Message.new(:body => text_body, :from => 'from' , :to => text_subject, :user_id => 3)
        @message.save
        # sms out
        sms_create(text_body, text_subject)
  		end

      # UserMailer.msg(@user, @content).deliver
    end
  end




    # UserMailer.msg(@user, content[:msg]).deliver
    #do some redick email stuff
    #sms out    sms_create(email_reply.body.decoded, to_gorp)


#email out
  def smsin
    @user = User.find(3)
    sms_body = params['Body']
    sms_from = params['From']
    sms_city = params['FromCity']
    UserMailer.msg(@user, sms_body + "From: "+ sms_city, sms_from).deliver
    if sms_body.to_s.length < 1
      render text: "No SMS."
    else
      render text: "The sms arrived. #{sms_body} From #{sms_city}"
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

    def sms_create(body, to)
      from = ENV['TWILIOFROM']
      account_sid = ENV['TSID']
      auth_token = ENV['TTOKEN']
      client = Twilio::REST::Client.new account_sid, auth_token
      client.account.messages.create(
        :body => body,
        :to => to,
        :from => from
      )
    end

end
