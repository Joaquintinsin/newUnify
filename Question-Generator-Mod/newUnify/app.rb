require 'sinatra'
require 'dotenv/load'
require 'openai'
require 'byebug'
require 'pdf/reader'

OLLAMA_LOCAL_CONFIGURATION = 'http://localhost:11434'.freeze

get '/' do
  erb :index, locals: { text_response: nil }
end

post '/search' do
  file = params[:file][:tempfile]
  pdf_text = extract_text_from_pdf(file)
  @questions = generate_questions(pdf_text)

  erb :index
end

# Initialize Ollama AI client
#
def client
  options = { uri_base: OLLAMA_LOCAL_CONFIGURATION }

  puts 'Initializing Ollama AI...'

  @client ||= OpenAI::Client.new(**options)
end

# Generate questions based on `full_text`
#
# returns an array of questions with options and one answer
#
def generate_questions(full_text)
  prompt = <<-STRING
    Generate 3 questions based on the following text.
    For each question, provide 3 multiple-choice options and indicate the correct answer.
    Format the response strictly as a single JSON array containing 3 objects with the following keys:
      * 'question'
      * 'options' (a list of choices)
      * 'answer' (the correct choice)
    Do not include any extra text or explanation.
  STRING

  response = client.chat(
    parameters: {
      model: 'llama3',
      messages: [
        { role: 'system', content: prompt },
        { role: 'user', content: full_text }
      ],
      temperature: 0.7
    }
  )

  parse_response(response)
end

def parse_response(response)
  raw_string = response.dig('choices', 0, 'message', 'content')
  puts "Raw response: #{raw_string}" # Debugging

  # Eliminar saltos de línea y otros caracteres innecesarios
  cleaned_str = raw_string.gsub(/\\n/, '').gsub('\n', '')

  # Dividir en posibles arreglos JSON
  json_strings = cleaned_str.split("\n\n")

  # Intentar parsear cada parte
  parsed_questions = []
  json_strings.each do |json_str|
    parsed_questions.concat(JSON.parse(json_str))
  rescue JSON::ParserError
    puts "JSON parse error: #{json_str}"
  end

  parsed_questions
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
