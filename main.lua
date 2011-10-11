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
    	if #row == 4 then
    		desired_results[#desired_results+1] = value
    	else
      	row[#row+1] = value
      end
    end
    samples_values[#samples_values+1] = row
  end
end

function write_archive(file,tab)
  local fp = assert(io.open(file,"w"))
  for i,row in ipairs(tab) do
    for i,value in ipairs(row) do
      fp:write(tostring(value)..",")
    end
    fp:write "\\n"
  end
end

-- Função para incializar aleatoriamente os pesos sinápticos
function start_synaptic_weights()
	for x = #synaptic_weights, x < 4, x++ do
		synaptic_weights[x] = (math.random(0,1) / 100)
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

repeat
	print("Entrando na época: "..age)
	error_flag = false
	for i, samples in pairs(samples_values) do
		activation_potential = 0
		for j, sample in pairs(samples) do
			activation_potential += (synaptic_weights[j] * sample)
		end
		y = signal(activation_potential)
		if y ~= desired_results[i] then
			synaptic_weights[j] = synaptic_weights[j] + learning_rate * (desired_results[i] - y) * sample
			error_flag = true
		end
	end
	age++
until error_flag == false
