#=================================================CLASE GEN=================================================
class Gen
	#Funcion initialize de un gen - Asigna un valor aleatorio a este
	def initialize
		@valor = rand(-9...9)

  	end

  	def getValor
  		@valor
  	end

  	def setValor(v)
  		@valor = v
  	end

end
