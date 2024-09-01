# Correr app: ruby app.rb
# http://127.0.0.1:3000/

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cors'
require 'dotenv/load'
require 'pdf-reader'
require 'json'
require 'byebug'

require './config/environment'

set :allow_origin, 'http://127.0.0.1:3000'
set :port, 3000

OLLAMA_LOCAL_CONFIGURATION = 'http://localhost:11434'.freeze
isAnUserPresent = false

before do
  @isAnUserPresent = isAnUserPresent
end

get '/' do
  erb :index
end

get '/us' do
  erb :us
end

get '/register' do
  erb :register
end

get '/login' do
  erb :login
end


post '/login' do
  if !isAnUserPresent
    username_or_email = params[:username_or_email]
    password = params[:password]

    if (username_or_email && password)
      @user = User.find_by(username: username_or_email, password: password) || User.find_by(email: username_or_email, password: password)
      if @user
        isAnUserPresent = true
        redirect '/'
      else
        @error = 'No se encontró el usuario o el correo, o la contraseña es incorrecta!'
        erb :login
      end
    else
      @error = 'Ingrese el nombre de usuario o correo electronico y la contraseña!'
      erb :login
    end
  else
    @error = 'Para entrar en una cuenta primero se debe salir de la cuenta actual!'
    erb :login
  end
end

# Variable global a los metodos utilizada en POST Register para manejar errores
error_registration = ''
post '/register' do
  if !isAnUserPresent
    username = params[:username]
    name = params[:name]
    lastname = params[:lastname] || 'Apellido No registrado'
    cellphone = params[:cellphone] || 'Celular No registrado'
    email = params[:email]
    password = params[:password]

    if username.nil? || name.nil? || email.nil? || password.nil? || username.strip.empty? || name.strip.empty? || email.strip.empty? || password.strip.empty?
      error_registration = 'missing_fields'
      redirect '/error-register'
      # Entra solamente por aca cuando se ponen espacios, porque el ".nil?" ya lo controla el form en el ERB con la clausula "required"
    else
      @user = User.find_by(username: username) || User.find_by(email: email)
      if @user
        error_registration = 'user_exists'
        redirect '/error-register'
      else
        @user = User.create(username: username, name: name, lastname: lastname, cellphone: cellphone, email: email, password: password)
        if @user.persisted?
          error_registration = ''
          isAnUserPresent = true
          redirect '/'
        else
          error_registration = 'user_not_persisted'
          redirect '/error-register'
        end
      end
    end
  else
    error_registration = 'already_logged_in'
    redirect '/error-register'
  end
end

get '/error-register' do
  case error_registration
  when 'missing_fields'
    erb :error_missing_fields
  when 'user_exists'
    erb :error_user_exists
  when 'user_not_persisted'
    erb :error_registration_failed
  when 'already_logged_in'
    erb :error_already_logged_in
  else
    redirect '/register'
  end
end

get '/logout' do
  isAnUserPresent = false
  redirect '/'
end

post '/logout' do
  isAnUserPresent = false
  redirect '/'
end

get '/practice' do
  erb :practice
end

get '/question/:id' do
  @question = Question.find(params[:id])

  erb :question
end

post '/question/:id/answer' do
  question = Question.find(params[:id])
  selected_option = Option.find(params[:option_id])
  if question.answer.option == selected_option
    @result = 'Correcto!'
  else
    @result = 'Incorrectoooo!'
  end

  erb :result
end

def client
  token = ENV['OLLAMA_API_TOKEN']

  if token.nil? || token.empty?
    raise "Missing Ollama token!"
  else
    @client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )
    @client ||= Ollama::Client.new(api_key: token)
  end
end

# Generate questions based on `full_text`
#
# returns an array of questions with options and one answer
#
def generate_questions(full_text)
  prompt = <<-STRING
      Generate 3 questions based on the following text.
      For each question, provide 3 multiple-choice options and indicate the correct answer.
      Please format each question as a JSON object (don't add anything extra, leave the json string clean to be able to parse it with JSON.parse method) with:
          * 'question'
          * 'options' (a list of choices) and
          * 'answer' (the correct choice) keys.
  STRING

  response = client.chat(
    { model: 'llama2',
      messages: [ { role: 'user', content: prompt }],
      temperature: 0.7
    }
  )

  parse_response(response)
end

def parse_response(response)
  raw_string = response.dig('choices', 0, 'message', 'content')
  json_part = raw_string.split("\n\n", 2).last
  cleaned_str = json_part.gsub(/\\n/, '').gsub('\n', '')
  begin
    JSON.parse(cleaned_str)
  rescue JSON::ParserError
    cleaned_str
  end
end

def extract_text_from_pdf(file)
  pdf = PDF::Reader.new(file)

  # This is the real algorithm to extract all pdf text~
  pdf.pages.map { |page| page.text }.join
end

# Just for testing purposes to check what models we have available
#
# To use this method start a console with:
#
#  irb -I. -r app.rb
#  > check_existing_models
#
def check_existing_models
  puts client.models.list
end
