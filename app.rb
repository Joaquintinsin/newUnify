# Correr app: ruby app.rb
# http://127.0.0.1:3000/

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cors'
require 'sinatra/json'
require 'byebug'
require 'fileutils'
require 'dotenv/load'
require 'pdf-reader'
require 'json'
require 'openai'

require './config/environment'

set :allow_origin, 'http://127.0.0.1:3000'
set :port, 3000

OpenAI.configure do |config|
  config.access_token = ENV['TOKEN_OPENAI']
end

# Variable global para el manejo de un usuario activo o inactivo
isAnUserPresent = false

# Variable global a los metodos utilizada en POST Register para manejar errores
error_registration = ''

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

get '/error-register' do
  case error_registration
  when 'missing_fields'
    erb :error_missing_fields
  when 'user_exists'
    erb :error_user_exists
  when 'user_not_persisted'
    erb :error_registration_failed
  else
    redirect '/register'
  end
end

get '/logout' do
  isAnUserPresent = false
  redirect '/'
end

get '/practice' do
  erb :practice
end

post '/login' do
  if !isAnUserPresent
    username_or_email = params[:username_or_email]
    password = params[:password]

    if username_or_email && password
      @user = User.find_by(username: username_or_email,
                           password: password) || User.find_by(email: username_or_email,
                                                               password: password)
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

post '/register' do
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
      @user = User.create(username: username, name: name, lastname: lastname, cellphone: cellphone, email: email,
                          password: password)
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
end

post '/logout' do
  isAnUserPresent = false
  redirect '/'
end

post '/practice' do
  logger.info 'Received request to generate quiz'
  logger.info "Params: #{params.inspect}"

  file = nil

  if params[:file] && params[:file][:tempfile]
    file = params[:file][:tempfile]
    status 200
    logger.info 'Successfully received file from tempfile'
  elsif params[:url]
    begin
      file = URI.open(params[:url])
      status 200
      logger.info 'Successfully opened file from URL'
    rescue StandardError => e
      logger.error "Failed to open file from URL: #{e.message}"
      status 400
      return json error: 'Failed to open file from URL'
    end
  end

  if file.nil?
    logger.error 'No file or URL provided'
    status 400
    return json error: 'No file or URL provided'
  end

  full_text = extract_text_from_pdf(file)

  if full_text.empty?
    logger.error 'Failed to extract text from PDF'
    status 500
    return json error: 'Failed to extract text from PDF'
  end

  structured_prompt = '' + "
  Generate 10 insightful questions based on the following text. For each question, provide 4 multiple-choice options and indicate the correct answer.
  Please format each question as a JSON object within a list, with 'question', 'options' (a list of choices), and 'answer' (the correct choice) keys.
  Provide the response in Spanish.
  " + ''

  begin
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system', content: structured_prompt },
          { role: 'user', content: full_text }
        ],
        max_tokens: 3000,
        temperature: 0.5
      }
    )

    logger.info 'Received response from OpenAI'
    logger.info "Response: #{response.inspect}"

    response_content = response['choices'][0]['message']['content'].strip

    response_content.gsub!(/^```json\n/, '')
    response_content.gsub!(/\n```$/, '')

    structured_response = JSON.parse(response_content)

    status 200
    json questions_and_answers: structured_response
  rescue JSON::ParserError => e
    logger.error "Failed to parse JSON response: #{e.message}"
    status 502
    return json error: 'Failed to parse JSON response'
  rescue StandardError => e
    logger.error "Failed to generate quiz: #{e.message}"
    status 503
    return json error: 'Failed to generate quiz'
  end
end

def extract_text_from_pdf(file)
  text = ''

  begin
    reader = PDF::Reader.new(file)
    reader.pages.each do |page|
      text << page.text
    end
  rescue StandardError => e
    logger.error "Direct PDF text extraction failed: #{e.message}"
  end

  if text.strip.empty?
    logger.info 'Attempting OCR extraction as fallback'
    begin
      images = pdf_to_images(file)
      images.each do |image|
        ocr_text = extract_text_from_image(image)
        text << ocr_text
      end
    rescue StandardError => e
      logger.error "OCR text extraction failed: #{e.message}"
    end
  end

  if text.strip.empty?
    logger.warn 'No text could be extracted from the PDF'
    text = 'No se pudo extraer texto del archivo PDF.'
  end

  text
end
