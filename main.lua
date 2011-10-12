------------------------------------------
--	Universidade Estadual do Piauí - UESPI
--
-- Bac. Em Ciências da Computação, 2011.2
--
--	AJ Alves - aj.zerokol@gmail.com - 2007.1 
--
------------------------------------------
-- Array para os valores de entrada
samples_values = {}
-- Array para saidas desejadas
desired_results = {}
-- Array para os pesos sinápticos
synaptic_weights = {}
-- Especificar taxa de aprendizagem
learning_rate = 0.01
-- Inicando as épocas
age = 0

error_flag = nil

-- Função para ler o arquivo que está em CVS
function read_archive(file)
  local fp = assert(io.open(file))
  for line in fp:lines() do
    local row = {}
    for value in line:gmatch("[^,]*") do
	    if value ~= '' then	
	    	if #row == 4 then
	    		desired_results[#desired_results+1] = value
	    	else
	      	row[#row+1] = value
	      end
	    end
    end
    samples_values[#samples_values+1] = row
  end
end

function write_archive(file)
  local fp = assert(io.open(file, "w"))
  for index, value in ipairs(synaptic_weights) do
  	fp:write(tostring(value)..",")
  end
  fp:write("/n")
end

-- Função para incializar aleatoriamente os pesos sinápticos
function start_synaptic_weights()
	for x = #synaptic_weights, 4 do
		synaptic_weights[x] = (math.random(0,100) / 100)
	end
end

function signal(value)
	if value >= 0 then
		return 1
	elseif value < 0 then
		return -1
	else
		return nil
	end
end

read_archive("archives/training_samples.csv")
start_synaptic_weights()

repeat
	print("Entrando na época: "..age)
	error_flag = false
	for i, samples in ipairs(samples_values) do
		activation_potential = 0
		for j, sample in ipairs(samples) do
			activation_potential = activation_potential + (synaptic_weights[j] * sample)
		end
		y = signal(activation_potential)
		for j = 1, #synaptic_weights do
			print(y)
			if y ~= desired_results[i] then
				synaptic_weights[j] = synaptic_weights[j] + learning_rate * (desired_results[i] - y) * samples[j]
				error_flag = true
			end
		end
	end
	age = age + 1
until error_flag == false or age > 100

write_archive("archives/synaptic_weights_values.csv")