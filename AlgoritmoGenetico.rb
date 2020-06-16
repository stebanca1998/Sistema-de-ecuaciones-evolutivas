require "deep_clone"
#==========================================CLASE ALGOROTMO GENETICO=========================================
class AlgoritmoGenetico


	def initialize(n,matriz,vector,esperado)
		@tam = n
		@poblacion = []
		@evolucionar = true

		@matrizA = matriz
		@vectorB = vector
		@vectorc = esperado

		100.times do
			var = Cromosoma.new(n)
			@poblacion.push(var)
		end
	end

	def evaluarGeneracion

		@aptitudes = []

		@poblacion.each do |crom|
			crom.calcularResultado(@matrizA)
			@aptitudes.push(crom.errorCuadratico(@vectorB))
		end	
	end	

	def parada
		cond = @aptitudes.max



		if cond > -0.0005

			@indexResultado = @aptitudes.index(cond)

			

			#Verifica que la solución encontrada sea igual a la esperada
			iguales = @vectorc.to_s == @poblacion[@indexResultado].getGenesValor.to_s

			#Si esa condicion se cumple se da por terminada la evolución
			#Este if asegura que la solución encontrada sea la solución con las que se planteo el problema
			#En caso de requerir cualquier solución sacar las 2 lineas del if
			if iguales
				@resultado = @poblacion[@indexResultado].getGenesValor
				@evolucionar = false

				return @evolucionar
			end

			puts 'Otra solución encontrada' + @poblacion[@indexResultado].getGenesValor.to_s

		end

		@evolucionar
	end	


	def seleccionTorneo

		@matingPool = []

		#Selección por torneo: se seleccionan 50 cromosomas para el mating pool 
		50.times do
			index1 = rand(0...100)
			index2 = rand(0...100)

			if (@aptitudes[index1] > @aptitudes[index2])

				@matingPool.push(index1)
			else
				@matingPool.push(index2)

			end
		end

	end


	def cruce

		indexPadre1 = 0
		indexPadre2 = 1
		@hijos = []

		25.times do

			# Extraemos los padres del array de seleccionados "mating pool"
			padre1 = @poblacion[@matingPool[indexPadre1]]
			padre2 = @poblacion[@matingPool[indexPadre2]]

			#Se clonan los cromosomas padres en 2 variables hijo
			hijo1 = DeepClone.clone(padre1)
			hijo2 = DeepClone.clone(padre2)

			#Se define en a partir de que indice se ponen los genes del segundo padre
			cut = rand (0...@tam)

			#A partir del indice de corte se reemplazan los genes por el gen correspondiente del segundo padre en cada caso
			for i in (cut...@tam)
				hijo1.getGenes[i].setValor(padre2.getGenes[i].getValor) 
				hijo2.getGenes[i].setValor(padre1.getGenes[i].getValor)
			end

			#Con estas dos lineas se asegura que haya mutación en los hijos
			mutacion(hijo1)
			mutacion(hijo2)

			#Se introducen los hijos recien nacidos a un arra Hijos
			@hijos.push(hijo1,hijo2)

			#Se suman dos espacios a los indices de los padres para que recorran todo el array del mating pool
			indexPadre1 = indexPadre1 + 2
			indexPadre2 = indexPadre2 + 2
		end

	end


	def mutacion(cromo)

		aMutar =  rand(0...@tam)

		gn = cromo.getGenes[aMutar]

		muto = rand (-9...9)
		#puts 'se cambia la ubicación ' + aMutar.to_s + 'del valor ' + gn.getValor.to_s + ' a ' + muto.to_s
		gn.setValor(muto)


	end


	def reemplazo

		#El reemplazo será del tip0 generacional
		for i in (0...@matingPool.length)
			@poblacion[@matingPool[i]] = @hijos[i]
		end

	end

	def evolucion

		iteracion = 0

		while @evolucionar or iteracion==30

			evaluarGeneracion()
			seleccionTorneo()
			cruce() #Este metodo incluye la mutación
			reemplazo()
			parada()

			iteracion = iteracion + 1
		end

		puts "================================================================="
		puts "================================================================="

		puts 'Le tomo ' + iteracion.to_s + ' generaciones'
		puts 'El vector resultado es ' + @resultado.to_s
	end

end
#===========================================================================================================