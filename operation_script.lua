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

function load_operation_inputs(file)
  local fp = assert(io.open(file))
  for line in fp:lines() do
    local row = {}
    for value in line:gmatch("[^,]*") do
	    if value ~= '' then	
	      row[#row+1] = value
	    end
    end
    inputs_for_classification[#inputs_for_classification+1] = row
  end
end

function input_parser(string)
	inputs_for_classification[1] = -1
  for value in string:gmatch("[^,]*") do
    if value ~= '' then	
    	inputs_for_classification[#inputs_for_classification+1] = tonumber(value)
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

--Carregando os pesos já treinados
load_synaptic_weights("archives/synaptic_weights_values.csv")

repeat
	print("Selecione o mode de operação:")
	print("\t\t1 - Para inserir entradas manualmente")
	print("\t\t2 - Para ler do arquivo archives/operation_inputs.cvs")
	print("\t\t3 - Sair")
	io.write("Opção: ")
	option_mode = io.read()

	if option_mode == '1' then
		print("Insira os três valores a serem classificados")
		io.write("Separados por virgula: ")
		inputs_to_classify = io.read()

		input_parser(inputs_to_classify)

		activation_potential = 0
		for j, input in ipairs(inputs_for_classification) do
			activation_potential = activation_potential + (synaptic_weights[j] * input)
		end

		y = signal(activation_potential)

		for x = 1, #synaptic_weights do
			print("\tAmostra "..x..": "..inputs_for_classification[x])
			print("\tPeso Sináptico "..x..": "..synaptic_weights[x])
		end

		if y == A_VALUE then
			print("\tA amostra pertence ao grupo de óleo P1\n\n")
		elseif y == B_VALUE then
			print("\tA amostra pertence ao grupo de óleo P2\n\n")
		else
			print("ERRO")
		end
	elseif option_mode == '2' then
		load_operation_inputs("archives/operation_inputs.cvs")
		for i, inputs in ipairs(inputs_for_classification) do
			activation_potential = 0
			for j, input in ipairs(inputs) do
				activation_potential = activation_potential + (synaptic_weights[j] * input)
			end

			y = signal(activation_potential)

			for x = 1, #synaptic_weights do
				print("\tAmostra "..x..": "..inputs_for_classification[i][x])
				print("\tPeso Sináptico "..x..": "..synaptic_weights[x])
			end

			if y == A_VALUE then
				print("\tA amostra pertence ao grupo de óleo P1\n\n")
			elseif y == B_VALUE then
				print("\tA amostra pertence ao grupo de óleo P2\n\n")
			else
				print("ERRO")
			end
		end
	elseif option_mode == '3' then
		print("até logo!")
	else
		print("Opção inválida!")
	end
until option_mode == '3'