function [post_excitation] = post_excite(input_vector, weight_vector)
    check_vector_sizes(input_vector, weight_vector, 'post_excite')
    post_excitation = input_vector' * weight_vector;
end

function check_vector_sizes(vector_one, vector_two, func_name)
    If length(vector_one) ~= length(vector_two)
        disp('Error in: ' + func_name);
        disp('Dimensions of weights and weight are different');
end

function [truth] = check_for_col_vector(input, desired_dim,... func_name)
    error_found = ['Function checkfor_col_vector has detected an error in', func_name];
    truth = 1;
    [numb_rows, numb_cols] = size(input);
    
    if numb_cols ~= 1
        beep
        truth = 0;
        disp(error_found)
        disp('Not a column vector')
    elseif numb_rows ~= desired_dim
        beep
        truth = 0;
        disp(errorfound);
        disp('Column vector is not desired length')
    end
end