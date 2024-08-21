# Correr app: ruby app.rb
# http://127.0.0.1:3000/

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cors'
require 'dotenv/load'
require 'pdf-reader'
require 'openai'
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
  erb :loginReg
end

get '/login' do
  erb :login
end

post '/login' do
  if !isAnUserPresent
    username = params[:username] || email = params[:email]
    password = params[:password]

    if (username && password)
      @user = User.find_by(username: username, email: email, password: password)
      if @user
        isAnUserPresent = true
        redirect '/'
      else
        @error = 'Datos incorrectos, por favor revisar nuevamente!'
        erb :login
      end
    else
      @error = 'Datos incorrectos, por favor revisar nuevamente!'
      erb :login
    end
  else
    @error = 'Para entrar en una cuenta primero se debe salir de la cuenta actual!'
    erb :login
  end
end

post '/register' do
  if !isAnUserPresent
    username = params[:username]
    name = params[:name]
    lastname = params[:lastname] || 'Apellido No registrado'
    cellphone = params[:cellphone] || 'Celular No registrado'
    email = params[:email]
    password = params[:password]

    if username.nil? || name.nil? || email.nil? || password.nil?
      @error = 'Se debe llenar los campos Username, Name, Email y Password obligatoriamente!'
      erb :loginReg
    else
      @user = User.create(username: username, name: name, lastname: lastname, cellphone: cellphone, email: email, password: password)
      if @user.persisted?
        isAnUserPresent = true
        redirect '/'
      else
        @error = 'Error al registrar el usuario. Intente nuevamente.'
        erb :loginReg
      end
    end

    isAnUserPresent = @user ? true : false
  else
    @error = 'Para registrar un nuevo usuario primero se debe salir de la cuenta actual!'
    erb :loginReg
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

def client
  options =
    if open_ai?
      { access_token: ENV['TOKEN_OPENAI'], log_errors: true }
    else
      { uri_base: OLLAMA_LOCAL_CONFIGURATION }
    end

  puts "Initializing #{open_ai? ? 'OpenAI' : 'Ollama'} AI..."

  @client ||= OpenAI::Client.new(**options)
end

def open_ai?
  ENV['AI_ENGINE'] == 'openai' && ENV.key?('TOKEN_OPENAI')
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
    parameters: {
      model: open_ai? ? 'gpt-3.5-turbo' : 'llama3',
      messages: [
        { role: 'system', content: prompt },
        { role: 'user', content: full_text }
      ],
      temperature: 0.7
    }
  )

  parse_response(response)
end

# Response is slightly different depending of the AI engine used
#
def parse_response(response)
  if open_ai?
    response['choices'].map do |choice|
      JSON.parse(choice.dig('message', 'content'))
    end
  else
    # Make our best effort to parse the answer
    raw_string = response.dig('choices', 0, 'message', 'content')
    json_part = raw_string.split("\n\n", 2).last
    cleaned_str = json_part.gsub(/\\n/, '').gsub('\n', '')
    begin
      JSON.parse(cleaned_str)
    rescue JSON::ParserError
      cleaned_str
    end
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
