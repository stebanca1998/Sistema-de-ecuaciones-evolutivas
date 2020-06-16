#==============================================CLASE CROMOSOMA==============================================
class Cromosoma

	def initialize(size)
		@size = size
		@genes = []

		#Crea los genes dependiendo del tamaño del cromosoma, y los guarda en un array
		@size.to_i.times do
			var = Gen.new
			@genes.push(var)
		end

  	end

  	
  	#Funcíón que calcula el resultado de operar este cromosoma con la matriz A
  	def calcularResultado(matriz)
  		
  		@resVec = Array.new(@size) #se define el Vector Resultado como resVec 

		for i in (0...@size)

			var = 0

			for j in (0...@size)
				var = var + (matriz[i][j].to_i * @genes[j].getValor)
			end

			@resVec[i] = var

		end

  	end	

  	#Halla el valor de la aptitud por medio del error cuadratico
  	def errorCuadratico(vector)
  		
  		var = 0

  		for i in (0...@size)

  			var = var + ((@resVec[i] - vector[i].to_i)**2)

		end

		@aptitud = var*(-1)

		return @aptitud
  	end	

  	#================================MÉTODOS GET================================

  	def getGenes
  		@genes
  	end

  	def getResVec
  		@resVec
  	end

  	def getGenesValor

  		@arrayValores = []

  		@genes.each do |n|
  			@arrayValores.push(n.getValor)
  		end

  		@arrayValores
  	end

end
#===========================================================================================================