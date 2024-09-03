# db/seeds.rb


# Creando preguntas para Introducción a la Algorítmica
question1 = Question.create(content: '¿Qué es un algoritmo?')
question2 = Question.create(content: '¿Cuál de los siguientes es un tipo de estructura de control?')
question3 = Question.create(content: '¿Qué es la eficiencia de un algoritmo?')
question4 = Question.create(content: '¿Qué es la notación Big O?')
question5 = Question.create(content: '¿Cuál es el propósito de un diagrama de flujo?')
question6 = Question.create(content: '¿Qué es la recursividad en un algoritmo?')
question7 = Question.create(content: '¿Qué es la corrección de un algoritmo?')
question8 = Question.create(content: '¿Qué es un pseudocódigo?')
question9 = Question.create(content: '¿Qué es un caso base en un algoritmo recursivo?')
question10 = Question.create(content: '¿Qué es la complejidad espacial de un algoritmo?')

# Creando opciones para la primera pregunta
option1_1 = Option.create(content: 'Una secuencia de instrucciones para resolver un problema.', question: question1)
option1_2 = Option.create(content: 'Un lenguaje de programación.', question: question1)
option1_3 = Option.create(content: 'Un conjunto de datos.', question: question1)

# Creando opciones para la segunda pregunta
option2_1 = Option.create(content: 'Variable.', question: question2)
option2_2 = Option.create(content: 'Bucle.', question: question2)
option2_3 = Option.create(content: 'Comentario.', question: question2)

# Creando opciones para la tercera pregunta
option3_1 = Option.create(content: 'La rapidez con la que se escribe el código.', question: question3)
option3_2 = Option.create(content: 'La cantidad de memoria que utiliza.', question: question3)
option3_3 = Option.create(content: 'El tiempo de ejecución y uso de recursos.', question: question3)

# Creando opciones para la cuarta pregunta
option4_1 = Option.create(content: 'Una forma de representar la complejidad temporal de un algoritmo.', question: question4)
option4_2 = Option.create(content: 'Un tipo de dato primitivo.', question: question4)
option4_3 = Option.create(content: 'Un operador lógico.', question: question4)

# Creando opciones para la quinta pregunta
option5_1 = Option.create(content: 'Representar gráficamente los pasos de un algoritmo.', question: question5)
option5_2 = Option.create(content: 'Crear bases de datos.', question: question5)
option5_3 = Option.create(content: 'Controlar el flujo de electricidad en un circuito.', question: question5)

# Creando opciones para la sexta pregunta
option6_1 = Option.create(content: 'La capacidad de un algoritmo para ejecutarse en paralelo.', question: question6)
option6_2 = Option.create(content: 'Cuando una función se llama a sí misma.', question: question6)
option6_3 = Option.create(content: 'Un tipo de estructura de datos.', question: question6)

# Creando opciones para la séptima pregunta
option7_1 = Option.create(content: 'Que el algoritmo tiene un nombre válido.', question: question7)
option7_2 = Option.create(content: 'Que el algoritmo produce los resultados correctos para todas las entradas.', question: question7)
option7_3 = Option.create(content: 'Que el código está comentado adecuadamente.', question: question7)

# Creando opciones para la octava pregunta
option8_1 = Option.create(content: 'Un programa compilado.', question: question8)
option8_2 = Option.create(content: 'Una descripción textual y no formal de un algoritmo.', question: question8)
option8_3 = Option.create(content: 'Un lenguaje de programación de alto nivel.', question: question8)

# Creando opciones para la novena pregunta
option9_1 = Option.create(content: 'El paso que resuelve el problema directamente sin hacer más llamadas recursivas.', question: question9)
option9_2 = Option.create(content: 'La primera iteración de un bucle.', question: question9)
option9_3 = Option.create(content: 'Un error en la recursión.', question: question9)

# Creando opciones para la décima pregunta
option10_1 = Option.create(content: 'El tiempo que tarda en ejecutarse.', question: question10)
option10_2 = Option.create(content: 'La cantidad de memoria que requiere.', question: question10)
option10_3 = Option.create(content: 'La cantidad de datos que puede procesar.', question: question10)

# Definiendo las respuestas correctas para Introducción a la Algorítmica
Answer.create(question: question1, option: option1_1) # Correcta: Una secuencia de instrucciones para resolver un problema.
Answer.create(question: question2, option: option2_2) # Correcta: Bucle.
Answer.create(question: question3, option: option3_3) # Correcta: El tiempo de ejecución y uso de recursos.
Answer.create(question: question4, option: option4_1) # Correcta: Una forma de representar la complejidad temporal de un algoritmo.
Answer.create(question: question5, option: option5_1) # Correcta: Representar gráficamente los pasos de un algoritmo.
Answer.create(question: question6, option: option6_2) # Correcta: Cuando una función se llama a sí misma.
Answer.create(question: question7, option: option7_2) # Correcta: Que el algoritmo produce los resultados correctos para todas las entradas.
Answer.create(question: question8, option: option8_2) # Correcta: Una descripción textual y no formal de un algoritmo.
Answer.create(question: question9, option: option9_1) # Correcta: El paso que resuelve el problema directamente sin hacer más llamadas recursivas.
Answer.create(question: question10, option: option10_2) # Correcta: La cantidad de memoria que requiere.

# Creando preguntas para Cálculo 1
question11 = Question.create(content: '¿Qué representa la derivada de una función en un punto?')
question12 = Question.create(content: '¿Qué es el límite de una función?')
question13 = Question.create(content: '¿Qué es una función continua?')
question14 = Question.create(content: '¿Cuál es la regla del producto para derivadas?')
question15 = Question.create(content: '¿Qué es una integral indefinida?')
question16 = Question.create(content: '¿Qué es un punto crítico de una función?')
question17 = Question.create(content: '¿Cuál es el teorema fundamental del cálculo?')
question18 = Question.create(content: '¿Qué es la derivada segunda de una función?')
question19 = Question.create(content: '¿Qué representa la integral definida?')
question20 = Question.create(content: '¿Qué es una asíntota horizontal?')

# Creando opciones para la primera pregunta
option11_1 = Option.create(content: 'La pendiente de la tangente en ese punto.', question: question11)
option11_2 = Option.create(content: 'El área bajo la curva.', question: question11)
option11_3 = Option.create(content: 'El valor de la función en ese punto.', question: question11)

# Creando opciones para la segunda pregunta
option12_1 = Option.create(content: 'El valor que toma la función en un punto.', question: question12)
option12_2 = Option.create(content: 'El valor al que se aproxima la función cuando la variable se acerca a un número específico.', question: question12)
option12_3 = Option.create(content: 'La máxima altura de la gráfica de la función.', question: question12)

# Creando opciones para la tercera pregunta
option13_1 = Option.create(content: 'Una función que tiene una derivada.', question: question13)
option13_2 = Option.create(content: 'Una función que no tiene saltos, saltos ni interrupciones.', question: question13)
option13_3 = Option.create(content: 'Una función que nunca toma el valor cero.', question: question13)

# Creando opciones para la cuarta pregunta
option14_1 = Option.create(content: 'Derivar el primer factor y multiplicarlo por el segundo.', question: question14)
option14_2 = Option.create(content: 'Derivar cada factor por separado y luego multiplicar.', question: question14)
option14_3 = Option.create(content: 'Derivar el primer factor, multiplicar por el segundo sin derivar, más el primer factor sin derivar multiplicado por la derivada del segundo.', question: question14)

# Creando opciones para la quinta pregunta
option15_1 = Option.create(content: 'Una suma de áreas bajo la curva.', question: question15)
option15_2 = Option.create(content: 'Una función que representa la acumulación de área bajo la curva sin límites específicos.', question: question15)
option15_3 = Option.create(content: 'El límite de la función.', question: question15)

# Creando opciones para la sexta pregunta
option16_1 = Option.create(content: 'Un punto donde la derivada es cero o no existe.', question: question16)
option16_2 = Option.create(content: 'Un punto donde la función tiene un valor máximo.', question: question16)
option16_3 = Option.create(content: 'Un punto donde la función no está definida.', question: question16)

# Creando opciones para la séptima pregunta
# Creando opciones para la séptima pregunta
option17_1 = Option.create(content: 'Relaciona la derivada de una función con su integral.', question: question17)
option17_2 = Option.create(content: 'Es una fórmula para derivar productos de funciones.', question: question17)
option17_3 = Option.create(content: 'Establece que toda función continua tiene una antiderivada.', question: question17)

# Creando opciones para la octava pregunta
option18_1 = Option.create(content: 'La primera derivada de la primera derivada.', question: question18)
option18_2 = Option.create(content: 'El área bajo la curva de la función original.', question: question18)
option18_3 = Option.create(content: 'El límite de la función cuando la variable tiende a infinito.', question: question18)

# Creando opciones para la novena pregunta
option19_1 = Option.create(content: 'El área bajo la curva entre dos puntos.', question: question19)
option19_2 = Option.create(content: 'El valor máximo de la función.', question: question19)
option19_3 = Option.create(content: 'El valor promedio de la función.', question: question19)

# Creando opciones para la décima pregunta
option20_1 = Option.create(content: 'Una línea que la gráfica de la función se aproxima a medida que la variable independiente tiende al infinito.', question: question20)
option20_2 = Option.create(content: 'Un punto donde la derivada es cero.', question: question20)
option20_3 = Option.create(content: 'El eje x de la gráfica.', question: question20)

# Definiendo las respuestas correctas para Cálculo 1
Answer.create(question: question11, option: option11_1) # Correcta: La pendiente de la tangente en ese punto.
Answer.create(question: question12, option: option12_2) # Correcta: El valor al que se aproxima la función cuando la variable se acerca a un número específico.
Answer.create(question: question13, option: option13_2) # Correcta: Una función que no tiene saltos, saltos ni interrupciones.
Answer.create(question: question14, option: option14_3) # Correcta: Derivar el primer factor, multiplicar por el segundo sin derivar, más el primer factor sin derivar multiplicado por la derivada del segundo.
Answer.create(question: question15, option: option15_2) # Correcta: Una función que representa la acumulación de área bajo la curva sin límites específicos.
Answer.create(question: question16, option: option16_1) # Correcta: Un punto donde la derivada es cero o no existe.
Answer.create(question: question17, option: option17_1) # Correcta: Relaciona la derivada de una función con su integral.
Answer.create(question: question18, option: option18_1) # Correcta: La primera derivada de la primera derivada.
Answer.create(question: question19, option: option19_1) # Correcta: El área bajo la curva entre dos puntos.
Answer.create(question: question20, option: option20_1) # Correcta: Una línea que la gráfica de la función se aproxima a medida que la variable independiente tiende al infinito.

# Creando preguntas para Cálculo 2
question21 = Question.create(content: '¿Qué es una serie infinita?')
question22 = Question.create(content: '¿Qué es la convergencia de una serie?')
question23 = Question.create(content: '¿Qué es la integral por partes?')
question24 = Question.create(content: '¿Qué es una integral impropia?')
question25 = Question.create(content: '¿Qué es una serie de Taylor?')
question26 = Question.create(content: '¿Qué es un polinomio de Taylor?')
question27 = Question.create(content: '¿Qué es una ecuación diferencial ordinaria?')
question28 = Question.create(content: '¿Qué es una transformada de Laplace?')
question29 = Question.create(content: '¿Qué es un límite en el infinito?')
question30 = Question.create(content: '¿Qué es una integral de línea?')

# Creando opciones para la primera pregunta
option21_1 = Option.create(content: 'Una suma finita de términos.', question: question21)
option21_2 = Option.create(content: 'Una suma infinita de términos.', question: question21)
option21_3 = Option.create(content: 'Un producto de infinitos factores.', question: question21)

# Creando opciones para la segunda pregunta
option22_1 = Option.create(content: 'Cuando la serie suma un valor finito.', question: question22)
option22_2 = Option.create(content: 'Cuando la serie suma un valor infinito.', question: question22)
option22_3 = Option.create(content: 'Cuando la serie no tiene un límite.', question: question22)

# Creando opciones para la tercera pregunta
option23_1 = Option.create(content: 'Una técnica de integración que usa la regla del producto.', question: question23)
option23_2 = Option.create(content: 'Un método para resolver ecuaciones diferenciales.', question: question23)
option23_3 = Option.create(content: 'Una forma de calcular límites.', question: question23)

# Creando opciones para la cuarta pregunta
option24_1 = Option.create(content: 'Una integral definida en un intervalo cerrado.', question: question24)
option24_2 = Option.create(content: 'Una integral cuyo límite de integración es infinito o la función tiene una discontinuidad.', question: question24)
option24_3 = Option.create(content: 'Una integral donde la función es continua.', question: question24)

# Creando opciones para la quinta pregunta
option25_1 = Option.create(content: 'Una aproximación de una función mediante un polinomio.', question: question25)
option25_2 = Option.create(content: 'Una suma de derivadas.', question: question25)
option25_3 = Option.create(content: 'Una ecuación diferencial.', question: question25)

# Creando opciones para la sexta pregunta
option26_1 = Option.create(content: 'Una suma de términos constantes.', question: question26)
option26_2 = Option.create(content: 'Una aproximación de una función alrededor de un punto.', question: question26)
option26_3 = Option.create(content: 'Un límite de una función.', question: question26)

# Creando opciones para la séptima pregunta
option27_1 = Option.create(content: 'Una ecuación que involucra derivadas de una función con respecto a una variable independiente.', question: question27)
option27_2 = Option.create(content: 'Una ecuación que involucra integrales.', question: question27)
option27_3 = Option.create(content: 'Una ecuación algebraica que no tiene derivadas.', question: question27)

# Creando opciones para la octava pregunta
option28_1 = Option.create(content: 'Una técnica para convertir ecuaciones diferenciales en ecuaciones algebraicas.', question: question28)
option28_2 = Option.create(content: 'Un método para encontrar máximos y mínimos de funciones.', question: question28)
option28_3 = Option.create(content: 'Una técnica para resolver integrales.', question: question28)

# Creando opciones para la novena pregunta
option29_1 = Option.create(content: 'El valor que toma una función cuando su variable independiente se aproxima al infinito.', question: question29)
option29_2 = Option.create(content: 'Una función que nunca converge.', question: question29)
option29_3 = Option.create(content: 'El área bajo la curva en un intervalo infinito.', question: question29)

# Creando opciones para la décima pregunta
option30_1 = Option.create(content: 'Una integral que suma valores a lo largo de una curva en un espacio.', question: question30)
option30_2 = Option.create(content: 'Una integral sobre un intervalo en la recta real.', question: question30)
option30_3 = Option.create(content: 'Un método de aproximación para el valor de una función.', question: question30)