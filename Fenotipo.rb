require 'rubygems'
require 'bundler/setup'

require "./Gen"
require "./Cromosoma"
require "./AlgoritmoGenetico"


#===============================================CLASE FENOTIPO==============================================
class Fenotipo


	def initialize(sizeA)
		#Tamaño de la matriz a ser solucionada
		@tamA = sizeA.to_i 
		
		#Se crea la matriz "A" la cual simula el sistema de ecuaciones
		@A = []
		@tamA.times do
			@A.push(Array.new(@tamA) { rand(-9...9) })
		end

		puts('Matriz A')
		puts('Constantes del sistema de ecuaciones')
		puts @A.to_s
		puts('====================')

		#Se crea el vector "c" o el vector solución que debemos hallar por medio del algoritmo evolutivo
		@c = Array.new(@tamA) { rand(-9...9) }


		#Con base en la multiplicación de la matriz "A" y el vector "c" se calcula el vector solucion "B" 
		@B = Array.new(@tamA)

		for i in (0...@tamA)

			var = 0

			for j in (0...@tamA)
				var = var + (@A[i][j].to_i * @c[j].to_i)
			end

			@B[i] = var

		end

		puts('Vector B')
		puts('Resultado de multiplicar las constantes por las variables a encontrar')
		puts @B.to_s
		puts('====================')

		puts('Vector x')
		puts('Este es el vector solución que deseamos hallar ')
		puts @c.to_s
		puts('=================================================================')
		puts('=================================================================')

	end

	def empezar
		ag = AlgoritmoGenetico.new(@tamA,@A,@B,@c)
		ag.evolucion()
	end	


end
#===========================================================================================================

puts "=================================================================================================="
puts "===                                         Bienvenido                                         ==="
puts "=================================================================================================="

puts "Aqui podras encontrar la solución de un sistema de ecuaciones de manera evolutiva"
puts "El sistema de ecuaciones sera generado de manera automatica"
puts "Recuerda que el sistema de ecuaciones posee la forma Ax=B"
puts "Lo que queremos hallar es el valor x"

puts "=================================================================================================="
puts "Ingresa el tamaño de la matriz que desees"
puts "(Un solo dígito ya que la matriz es cuadrada)"
tamano = gets.to_i
puts "=================================================================================================="
cr = Fenotipo.new(tamano)
cr.empezar()