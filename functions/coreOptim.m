function [criteria] = coreOptim(x, motors, dataset, start, step, stop)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global best_solution;
    

    %% Add motor coordinates to structure
    motors = appendX2motors(x, motors);

    %% Run core
    motors = core(motors, dataset, start, step, stop);
    
    
    %% Optimization criteria    
    feasable = mean(motors.feasable);
    efficiency = mean(motors.efficiency .* motors.feasable);
    
    
    inv_input_power  = 1./motors.power.total;
    inv_input_power(motors.feasable==0)=0;
    
    
    %% Optimization criteria
    %criteria = 1-efficiency;
    %criteria = 1-feasable;
    criteria = 1-mean(inv_input_power);
    
    %% Store data in history
    data = [now, x, feasable, efficiency, criteria];
    dlmwrite('output/optim.csv',data,'-append','precision','%10.10f');
    dlmwrite('output/optim.mat','data');
    
    
    %% Update the best solution if needed
    if (isempty(best_solution) || best_solution(end) > criteria)
        best_solution = data;
        fprintf ('New solution: %.6f (%.2f%%)\n',efficiency,feasable *100);
    end
    

end

