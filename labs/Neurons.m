function [post_excitation] = post_excite(input_vector, weight_vector)
    check_vector_sizes(input_vector, weight_vector, 'post_excite')
    post_excitation = input_vector' * weight_vector;
end

function check_vector_sizes(vector_one, vector_two, func_name)
    % Check for vector size equality
    % This would be trivial to program in C, and I will. I just hadn't
    %   thought of giving vectors a "length"
    if length(vector_one) ~= length(vector_two);
        disp('Error in: ' + func_name);
        disp('Dimensions of weights and weight are different');
    end
end

function [neuron_output] = spikegen(threshold, excitation)
    % Error detection
    if length(excitation) > 1
        disp('Function spikegen takes a scalar and not a vector or matrix')
    end
    
    % Threshold function
    if excitation < threshold
        neuron_output = 0;
    else
        neuron_output = 1;
    end
end