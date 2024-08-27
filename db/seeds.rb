# db/seeds.rb

# Creando preguntas
question1 = Question.create(content: '¿Cuál es la capital de Francia?')
question2 = Question.create(content: '¿Cuál es el resultado de 2 + 2?')

# Creando opciones para la primera pregunta
option1_1 = Option.create(content: 'París', question: question1)
option1_2 = Option.create(content: 'Londres', question: question1)
option1_3 = Option.create(content: 'Berlín', question: question1)

# Creando opciones para la segunda pregunta
option2_1 = Option.create(content: '3', question: question2)
option2_2 = Option.create(content: '4', question: question2)
option2_3 = Option.create(content: '5', question: question2)

# Definiendo las respuestas correctas
Answer.create(question: question1, option: option1_1) # París es la respuesta correcta
Answer.create(question: question2, option: option2_2) # 4 es la respuesta correcta