--[[++++++++++++++++++++++++++++++++++++++++++++
++	Universidade Estadual do Piauí - UESPI
++
++	Bac. Em Ciências da Computação, 2011.2
++
++	AJ Alves - aj.zerokol@gmail.com - 2007.1 
++
++++++++++++++++++++++++++++++++++++++++++++++++]]
A_VALUE = -1
B_VALUE = 1
-- Array para os pesos sinápticos
synaptic_weights = {}
-- Array para os valores de especificação
inputs_for_classification = {}

function load_synaptic_weights(file)
  local fp = assert(io.open(file))
  for line in fp:lines() do
    for value in line:gmatch("[^,]*") do
	    if value ~= '' then	
	    	synaptic_weights[#synaptic_weights+1] = (value * 1)
	    end
    end
  end
end

function input_parser(string)
  for value in string:gmatch("[^,]*") do
    if value ~= '' then	
    	inputs_for_classification[#inputs_for_classification+1] = (value * 1)
    end
  end
end

function signal(value)
	if value >= 0 then
		return 1.0000
	elseif value < 0 then
		return -1.0000
	else
		return nil
	end
end

print("Insira os três valores a serem classificados")
io.write("Separados por virgula: ")
inputs_to_classify = io.read()

input_parser(inputs_to_classify)

load_synaptic_weights("archives/synaptic_weights_values.csv")

activation_potential = 0
for j, input in ipairs(inputs_for_classification) do
	activation_potential = activation_potential + (synaptic_weights[j] * input)
end

y = signal(activation_potential)

if y == A_VALUE then
	print("A amostra pertence ao grupo de óleo P1")
elseif y == B_VALUE then
	print("A amostra pertence ao grupo de óleo P2")
else
	print("ERRO")
end