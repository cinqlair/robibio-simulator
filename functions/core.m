function [motors] = core(motors, dataset, start, step, stop)
% motors is a structure containing the motor parameters (attachement points
% and offset
% dataset is the HuMoD / ROBIBIO input 2d dataset used for the simulation
% start is the starting step for the simulation
% Stop is the end step for the simulation
    
    motors.start = start;
    motors.step = step;
    motors.stop = stop;

    index = 1;
    for i=start:step:stop

        %% Initialize Jacobian
        jacobian.left = zeros(3,5);
        jacobian.right = zeros(3,5);
        
        

        %% Get transformation matrices
        T_Hip_to_Knee_Left      = reshape (dataset.transformation_matrices.hip_to_knee_left(:,i),[4,4]);
        T_Hip_to_Knee_Right     = reshape (dataset.transformation_matrices.hip_to_knee_right(:,i),[4,4]);
        T_Hip_to_Ankle_Left     = reshape (dataset.transformation_matrices.hip_to_ankle_left(:,i),[4,4]);
        T_Hip_to_Ankle_Right    = reshape (dataset.transformation_matrices.hip_to_ankle_right(:,i),[4,4]);
        T_Hip_to_Foot_Left      = reshape (dataset.transformation_matrices.hip_to_foot_left(:,i),[4,4]);
        T_Hip_to_Foot_Right     = reshape (dataset.transformation_matrices.hip_to_foot_right(:,i),[4,4]);


        %% Hip motors
        motors.max_force.hip.left(index) = 0;
        motors.max_force.hip.right(index) = 0;
        if (motors.enable.hip)

            % Motor joint coordinates
            motors.trajectories.hip.left.trunk(:,index)     = [motors.parameters.hip.trunk ; 0 ; 1];
            motors.trajectories.hip.right.trunk(:,index)    = [motors.parameters.hip.trunk ; 0 ; 1];
            motors.trajectories.hip.left.thigh(:,index)     = T_Hip_to_Knee_Left * [motors.parameters.hip.thigh ; 0 ; 1];
            motors.trajectories.hip.right.thigh(:,index)    = T_Hip_to_Knee_Right * [motors.parameters.hip.thigh ; 0 ; 1];

            % Distance between attachment points
            motors.length.hip.left(index)                   = norm (motors.trajectories.hip.left.thigh(:,index) - motors.trajectories.hip.left.trunk(:,index));
            motors.length.hip.right(index)                  = norm (motors.trajectories.hip.right.thigh(:,index) - motors.trajectories.hip.right.trunk(:,index));

            % Motor maximal force and motor state
            [Force, State] = motors.parameters.hip.reference(motors.length.hip.left(index), motors.parameters.hip.offset);
            motors.max_force.hip.left(index) = Force;
            motors.state.hip.left(index) = State;

            [Force, State] = motors.parameters.hip.reference(motors.length.hip.right(index), motors.parameters.hip.offset);
            motors.max_force.hip.right(index) = Force;
            motors.state.hip.right(index) = State;


            % Compute maximum available torque
            vector_motor = motors.trajectories.hip.left.thigh(:,index) - motors.trajectories.hip.left.trunk(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            vector_lever = motors.trajectories.hip.left.thigh(:,index) / 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(3,5) = J(3);
            motors.max_torque.hip.left(index) = abs(motors.max_force.hip.left(index) * jacobian.left(3,5));
            

            vector_motor = motors.trajectories.hip.right.thigh(:,index) - motors.trajectories.hip.right.trunk(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            vector_lever = motors.trajectories.hip.right.thigh(:,index) / 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(3,5) = J(3);
            motors.max_torque.hip.right(index) = abs(motors.max_force.hip.right(index) * jacobian.left(3,5));

            
        end;

            
        %% Knee motor
        motors.max_force.knee.left(index) = 0;
        motors.max_force.knee.right(index) = 0;
        if (motors.enable.knee)
            motors.trajectories.knee.left.thigh(:,index)    = T_Hip_to_Knee_Left * [motors.parameters.knee.thigh ; 0 ; 1];
            motors.trajectories.knee.right.thigh(:,index)   = T_Hip_to_Knee_Right * [motors.parameters.knee.thigh ; 0 ; 1];
            motors.trajectories.knee.left.shang(:,index)    = T_Hip_to_Ankle_Left * [motors.parameters.knee.shang ; 0 ; 1];
            motors.trajectories.knee.right.shang(:,index)   = T_Hip_to_Ankle_Right * [motors.parameters.knee.shang ; 0 ; 1];

            % Distance between attachment points
            motors.length.knee.left(index)                  = norm (motors.trajectories.knee.left.thigh(:,index) - motors.trajectories.knee.left.shang(:,index));
            motors.length.knee.right(index)                 = norm (motors.trajectories.knee.right.thigh(:,index) - motors.trajectories.knee.right.shang(:,index));

            % Motor maximal force and motor state
            [Force, State] = motors.parameters.knee.reference(motors.length.knee.left(index), motors.parameters.knee.offset);
            motors.max_force.knee.left(index) = Force;
            motors.state.knee.left(index) = State;

            [Force, State] = motors.parameters.knee.reference(motors.length.knee.right(index), motors.parameters.knee.offset);
            motors.max_force.knee.right(index) = Force;
            motors.state.knee.right(index) = State;

            % Compute maximum available torque
            vector_motor = motors.trajectories.knee.left.shang(:,index) - motors.trajectories.knee.left.thigh(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            vector_lever = (motors.trajectories.knee.left.thigh(:,index) - dataset.trajectories.joints.left.knee(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(2,3) = J(3);
            motors.max_torque.knee.left(index) = abs(motors.max_force.knee.left(index) * jacobian.left(3,3));

            vector_motor = motors.trajectories.knee.right.shang(:,index) - motors.trajectories.knee.right.thigh(:,index);
            vector_motor_unit =  vector_motor/norm(vector_motor);
            vector_lever = (motors.trajectories.knee.right.thigh(:,index) - dataset.trajectories.joints.right.knee(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(2,3) = J(3);
            motors.max_torque.knee.right(index) = abs(motors.max_force.knee.right(index) * jacobian.right(3,3));

        end;

        %% Ankle motor
        motors.max_force.ankle.left(index) = 0;
        motors.max_force.ankle.right(index) = 0;
        if (motors.enable.ankle)

            % Motor joint coordinates
            motors.trajectories.ankle.left.shang(:,index)   = T_Hip_to_Ankle_Left * [motors.parameters.ankle.shang; 0 ; 1];
            motors.trajectories.ankle.right.shang(:,index)  = T_Hip_to_Ankle_Right * [motors.parameters.ankle.shang ; 0 ; 1];
            motors.trajectories.ankle.left.foot(:,index)    = T_Hip_to_Foot_Left * [motors.parameters.ankle.foot ; 0 ; 1];
            motors.trajectories.ankle.right.foot(:,index)   = T_Hip_to_Foot_Right * [motors.parameters.ankle.foot ; 0 ; 1];


            % Distance between attachment points
            motors.length.ankle.left(index)                 = norm (motors.trajectories.ankle.left.shang(:,index) - motors.trajectories.ankle.left.foot(:,index));
            motors.length.ankle.right(index)                = norm (motors.trajectories.ankle.right.shang(:,index) - motors.trajectories.ankle.right.foot(:,index));

            % Motor maximal force and motor state
            [Force, State] = motors.parameters.ankle.reference(motors.length.ankle.left(index), motors.parameters.ankle.offset);
            motors.max_force.ankle.left(index) = Force;
            motors.state.ankle.left(index) = State;

            [Force, State] = motors.parameters.ankle.reference(motors.length.ankle.right(index), motors.parameters.ankle.offset);
            motors.max_force.ankle.right(index) = Force;
            motors.state.ankle.right(index) = State;


            % Compute maximum available torque
            vector_motor = motors.trajectories.ankle.left.foot(:,index) - motors.trajectories.ankle.left.shang(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            vector_lever = (motors.trajectories.ankle.left.foot(:,index) - dataset.trajectories.joints.left.ankle(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(1,1) = J(3);
            motors.max_torque.ankle.left(index) = abs(motors.max_force.ankle.left(index) * jacobian.left(1,1));

            vector_motor = motors.trajectories.ankle.right.foot(:,index) - motors.trajectories.ankle.right.shang(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            vector_lever = (motors.trajectories.ankle.right.foot(:,index) - dataset.trajectories.joints.right.knee(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(1,1) = J(3);
            motors.max_torque.ankle.right(index) = abs(motors.max_force.ankle.right(index) * jacobian.right(1,1));

        end;

        %% Hip-knee motor (biarticular)
        motors.max_force.hip_knee.left(index) = 0;
        motors.max_force.hip_knee.right(index) = 0;
        if (motors.enable.hip_knee)

            % Motor joint coordinates
            motors.trajectories.hip_knee.left.trunk(:,index)    = [motors.parameters.hip_knee.trunk; 0 ; 1];
            motors.trajectories.hip_knee.right.trunk(:,index)   = [motors.parameters.hip_knee.trunk ; 0 ; 1];
            motors.trajectories.hip_knee.left.shang(:,index)    = T_Hip_to_Ankle_Left * [motors.parameters.hip_knee.shang; 0 ; 1];
            motors.trajectories.hip_knee.right.shang(:,index)   = T_Hip_to_Ankle_Right * [motors.parameters.hip_knee.shang ; 0 ; 1];


            % Distance between attachment points
            motors.length.hip_knee.left(index)                  = norm (motors.trajectories.hip_knee.left.trunk(:,index) - motors.trajectories.hip_knee.left.shang(:,index));
            motors.length.hip_knee.right(index)                 = norm (motors.trajectories.hip_knee.right.trunk(:,index) - motors.trajectories.hip_knee.right.shang(:,index));

            % Motor maximal force and motor state
            [Force, State] = motors.parameters.hip_knee.reference(motors.length.hip_knee.left(index), motors.parameters.hip_knee.offset);
            motors.max_force.hip_knee.left(index) = Force;
            motors.state.hip_knee.left(index) = State;

            [Force, State] = motors.parameters.hip_knee.reference(motors.length.hip_knee.right(index), motors.parameters.hip_knee.offset);
            motors.max_force.hip_knee.right(index) = Force;
            motors.state.hip_knee.right(index) = State;

            % Compute maximum available torque on hip and knee
            vector_motor = motors.trajectories.hip_knee.left.shang(:,index) - motors.trajectories.hip_knee.left.trunk(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            % Left hip
            vector_lever = (motors.trajectories.hip_knee.left.trunk(:,index) - [0; 0; 0 ;1] )/ 1000;
            J = cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(3,4) = J(3);
            motors.max_torque.hip_knee.hip.left(index) = abs(motors.max_force.hip_knee.left(index) * jacobian.left(3,4));
            % Left knee
            vector_lever = (motors.trajectories.hip_knee.left.shang(:,index) - dataset.trajectories.joints.left.knee(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(2,4) = J(3);
            motors.max_torque.hip_knee.knee.left(index) = abs(motors.max_force.hip_knee.left(index) * jacobian.left(2,4));

            vector_motor = motors.trajectories.hip_knee.right.shang(:,index) - motors.trajectories.hip_knee.right.trunk(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            % Right hip
            vector_lever = (motors.trajectories.hip_knee.right.trunk(:,index) - [0; 0; 0 ;1] )/ 1000;
            J = cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(3,4) = J(3);
            motors.max_torque.hip_knee.hip.right(index) = abs(motors.max_force.hip_knee.right(index) * jacobian.right(3,4));
            % Right knee
            vector_lever = (motors.trajectories.hip_knee.right.shang(:,index) - dataset.trajectories.joints.right.knee(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(2,4) = J(3);
            motors.max_torque.hip_knee.knee.right(index) = abs(motors.max_force.hip_knee.right(index) * jacobian.right(2,4));




        end;

        %% Knee-ankle motor (biarticular)
        motors.max_force.knee_ankle.left(index) = 0;
        motors.max_force.knee_ankle.right(index) = 0;
        if (motors.enable.knee_ankle)

            % Motor joint coordinates
            motors.trajectories.knee_ankle.left.thigh(:,index)   = T_Hip_to_Knee_Left * [motors.parameters.knee_ankle.thigh; 0 ; 1];
            motors.trajectories.knee_ankle.right.thigh(:,index)  = T_Hip_to_Knee_Right * [motors.parameters.knee_ankle.thigh ; 0 ; 1];
            motors.trajectories.knee_ankle.left.foot(:,index)    = T_Hip_to_Foot_Left * [motors.parameters.knee_ankle.foot; 0 ; 1];
            motors.trajectories.knee_ankle.right.foot(:,index)   = T_Hip_to_Foot_Right * [motors.parameters.knee_ankle.foot ; 0 ; 1];


            % Distance between attachment points
            motors.length.knee_ankle.left(index)                 = norm (motors.trajectories.knee_ankle.left.thigh(:,index) - motors.trajectories.knee_ankle.left.foot(:,index));
            motors.length.knee_ankle.right(index)                = norm (motors.trajectories.knee_ankle.right.thigh(:,index) - motors.trajectories.knee_ankle.right.foot(:,index));

            % Motor maximal force and motor state
            [Force, State] = motors.parameters.knee_ankle.reference(motors.length.knee_ankle.left(index), motors.parameters.knee_ankle.offset);
            motors.max_force.knee_ankle.left(index) = Force;
            motors.state.knee_ankle.left(index) = State;

            [Force, State] = motors.parameters.knee_ankle.reference(motors.length.knee_ankle.right(index), motors.parameters.knee_ankle.offset);
            motors.max_force.knee_ankle.right(index) = Force;
            motors.state.knee_ankle.right(index) = State;

            % Compute maximum available torque on knee and ankle
            vector_motor = motors.trajectories.knee_ankle.left.foot(:,index) - motors.trajectories.knee_ankle.left.thigh(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            % Left knee
            vector_lever = (motors.trajectories.knee_ankle.left.thigh(:,index) - dataset.trajectories.joints.left.knee(:,i) )/ 1000;
            J = cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(2,2) = J(3);
            motors.max_torque.knee_ankle.knee.left(index) = abs(motors.max_force.knee_ankle.left(index) * jacobian.left(2,2));
            % Left foot
            vector_lever = (motors.trajectories.knee_ankle.left.foot(:,index) - dataset.trajectories.joints.left.ankle(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.left(1,2) = J(3);
            motors.max_torque.knee_ankle.ankle.left(index) = abs(motors.max_force.knee_ankle.left(index) * jacobian.left(1,2));

            % Compute maximum available torque on knee and ankle
            vector_motor = motors.trajectories.knee_ankle.right.foot(:,index) - motors.trajectories.knee_ankle.right.thigh(:,index);
            vector_motor_unit = vector_motor/norm(vector_motor);
            % Right knee
            vector_lever = (motors.trajectories.knee_ankle.right.thigh(:,index) - dataset.trajectories.joints.right.knee(:,i)  )/ 1000;
            J = cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(2,2) = J(3);
            motors.max_torque.knee_ankle.knee.right(index) = abs(motors.max_force.knee_ankle.right(index) * jacobian.right(2,2));
            % Right foot
            vector_lever = (motors.trajectories.knee_ankle.right.foot(:,index) - dataset.trajectories.joints.right.ankle(:,i)  )/ 1000;
            J = -cross (vector_motor_unit(1:3), vector_lever(1:3));
            jacobian.right(1,2) = J(3);
            motors.max_torque.knee_ankle.ankle.right(index) = abs(motors.max_force.knee_ankle.right(index) * jacobian.right(1,2));
        end;
    
        motors.jacobian.left(:,index) = reshape (jacobian.left, [15,1]);
        motors.jacobian.right(:,index) = reshape (jacobian.right, [15,1]);
        
        motors.humod_step(index) = i;
        
        
        
        %% Compute motors velocity
        if (index == 1)
            motors.velocity.hip.left(:,index)=0;
            motors.velocity.hip.right(:,index)=0;
            motors.velocity.knee.left(:,index)=0;
            motors.velocity.knee.right(:,index)=0;
            motors.velocity.ankle.left(:,index)=0;
            motors.velocity.ankle.right(:,index)=0;
            motors.velocity.hip_knee.left(:,index)=0;
            motors.velocity.hip_knee.right(:,index)=0;
            motors.velocity.knee_ankle.left(:,index)=0;
            motors.velocity.knee_ankle.right(:,index)=0; 
        else
            if (motors.enable.hip)
                motors.velocity.hip.left(:,index) = diff((motors.length.hip.left(end-1:end)/1000)*dataset.frame_rate);
                motors.velocity.hip.right(:,index) = diff((motors.length.hip.right(end-1:end)/1000)*dataset.frame_rate);
            else
                motors.velocity.hip.left(:,index)=0;
                motors.velocity.hip.right(:,index)=0;        
            end

            if (motors.enable.knee)
                motors.velocity.knee.left(:,index) = diff((motors.length.knee.left(end-1:end)/1000)*dataset.frame_rate);
                motors.velocity.knee.right(:,index) = diff((motors.length.knee.right(end-1:end)/1000)*dataset.frame_rate);
            else
                motors.velocity.knee.left(:,index)=0;
                motors.velocity.knee.right(:,index)=0;                
            end

            if (motors.enable.ankle)
                motors.velocity.ankle.left(:,index) = diff((motors.length.ankle.left(end-1:end)/1000)*dataset.frame_rate);
                motors.velocity.ankle.right(:,index) = diff((motors.length.ankle.right(end-1:end)/1000)*dataset.frame_rate);
            else
                motors.velocity.ankle.left(:,index)=0;
                motors.velocity.ankle.right(:,index)=0;            
            end

            if (motors.enable.hip_knee)
                motors.velocity.hip_knee.left(:,index) = diff((motors.length.hip_knee.left(end-1:end)/1000)*dataset.frame_rate);
                motors.velocity.hip_knee.right(:,index) = diff((motors.length.hip_knee.right(end-1:end)/1000)*dataset.frame_rate);     
            else
                motors.velocity.hip_knee.left(:,index)=0;
                motors.velocity.hip_knee.right(:,index)=0;
            end

            if (motors.enable.knee_ankle)
                motors.velocity.knee_ankle.left(:,index) = diff((motors.length.knee_ankle.left(end-1:end)/1000)*dataset.frame_rate);
                motors.velocity.knee_ankle.right(:,index) = diff((motors.length.knee_ankle.right(end-1:end)/1000)*dataset.frame_rate);
            else
                motors.velocity.knee_ankle.left(:,index)=0;
                motors.velocity.knee_ankle.right(:,index)=0;          
            end
        end
    

                
        %% Optim for finding a feasable solution
        
%         %% Left leg optimization
%         options = optimset('Display','off');
%         T = [dataset.torques.q(1,i) ; dataset.torques.q(3,i) ; dataset.torques.q(5,i)];
%         ub = [motors.max_force.ankle.left(index) ; motors.max_force.knee_ankle.left(index) ; motors.max_force.knee.left(index) ; motors.max_force.hip_knee.left(index) ; motors.max_force.hip.left(index)];
%         lb = -ub;
%         
%                 
%         [forcesLeft,resnorm,residualLeft,exitFlag,output,lambda] = lsqlin(jacobian.left, T, [], [], [], [], lb, ub, [], options);
%         motors.forces.left(:,index) = forcesLeft;
%         motors.status.left(:,index) = [resnorm; residualLeft; exitFlag; output.constrviolation];
%         
%         
%         %% Right leg optimization
%         options = optimset('Display','off');
%         T = [dataset.torques.q(2,i) ; dataset.torques.q(4,i) ; dataset.torques.q(6,i)];
%         ub = [motors.max_force.ankle.right(index) ; motors.max_force.knee_ankle.right(index) ; motors.max_force.knee.right(index) ; motors.max_force.hip_knee.right(index) ; motors.max_force.hip.right(index)];
%         lb = -ub;
%                 
%         [forcesRight,resnorm,residualRight,exitFlag,output,lambda] = lsqlin(jacobian.right, T, [], [], [], [], lb, ub, [], options);
%         motors.forces.right(:,index) = forcesRight;
%         motors.status.right(:,index) = [resnorm; residualRight; exitFlag; output.constrviolation];
%         
%         
%         if (max(abs(residualLeft))<1 && max(abs(residualRight))<1)
%             motors.feasable(:,index)=1;
%         else
%             motors.feasable(:,index)=0;
%         end
        
        
        %% Optim for finding a feasable solution and power minimization

        %% Left leg minimize power
        options = optimset('Display','off');
        motors.feasable(index)=1;
        
        % Minimize power
        C_left = eye(5);
        C_left(1,1) = motors.velocity.ankle.left(:,index);
        C_left(2,2) = motors.velocity.knee_ankle.left(:,index);
        C_left(3,3) = motors.velocity.knee.left(:,index);
        C_left(4,4) = motors.velocity.hip_knee.left(:,index);
        C_left(5,5) = motors.velocity.hip.left(:,index);
        
        % System to solve
        Aeq = jacobian.left;
        beq = [dataset.torques.q(1,i) ; dataset.torques.q(3,i) ; dataset.torques.q(5,i)];
        
        % Bounds
        ub = [motors.max_force.ankle.left(index) ; motors.max_force.knee_ankle.left(index) ; motors.max_force.knee.left(index) ; motors.max_force.hip_knee.left(index) ; motors.max_force.hip.left(index)];
        ub(ub==0)=0.1;
        lb = -ub;
        
                
        [forcesLeft,resnorm,residualLeft,exitFlagLeft,output,lambda] = lsqlin(C_left, zeros(5,1), [], [], Aeq, beq, lb, ub, [], options);
        
        % Motion is not feasable, optimize without boundaries
        if (exitFlagLeft ~= 1)
            motors.feasable(index)=0;            
            [forcesLeft,resnorm,residualLeft,exitFlagLeft,output,lambda] = lsqlin(C_left, zeros(5,1), [], [], Aeq, beq, [], [], [], options);
        end
        motors.forces.left(:,index) = forcesLeft;
        motors.power.left(:,index) = abs(residualLeft * 9.80665);
        motors.status.left(:,index) = [resnorm; residualLeft; exitFlagLeft; output.constrviolation];

        
        
        %% Right leg minimize power
       
        % Minimize power
        C_right = eye(5);
        C_right(1,1) = motors.velocity.ankle.right(:,index);
        C_right(2,2) = motors.velocity.knee_ankle.right(:,index);
        C_right(3,3) = motors.velocity.knee.right(:,index);
        C_right(4,4) = motors.velocity.hip_knee.right(:,index);
        C_right(5,5) = motors.velocity.hip.right(:,index);
        
        % System to solve
        Aeq = jacobian.right;
        beq = [dataset.torques.q(2,i) ; dataset.torques.q(4,i) ; dataset.torques.q(6,i)];
        
        % Bounds
        ub = [motors.max_force.ankle.right(index) ; motors.max_force.knee_ankle.right(index) ; motors.max_force.knee.right(index) ; motors.max_force.hip_knee.right(index) ; motors.max_force.hip.right(index)];
        ub(ub==0)=0.1;
        lb = -ub;
        
                
        [forcesRight,resnorm,residualRight,exitFlagRight,output,lambda] = lsqlin(C_right, zeros(5,1), [], [], Aeq, beq, lb, ub, [], options);
        
        % Motion is not feasable, optimize without boundaries
        if (exitFlagRight ~= 1)
            motors.feasable(index)=0;            
            [forcesRight,resnorm,residualRight,exitFlagRight,output,lambda] = lsqlin(C_right, zeros(5,1), [], [], Aeq, beq, [], [], [], options);
        end
            
        motors.forces.right(:,index) = forcesRight;    
        motors.power.right(:,index) = abs(residualRight * 9.80665);
        motors.status.right(:,index) = [resnorm; exitFlagRight; output.constrviolation];
        
        %% Compute total motor power
        
        motors.power.total(index) = sum(motors.status.right(:,index)) + sum(motors.status.left(:,index));
        
        
        
        %% Compute efficiency
        if (index == 1)
            motors.efficiency(index) = 0;
        else            
            motors.efficiency(index) = dataset.power.total(:,i) /(sum(motors.power.left(:,index)) + sum(motors.power.right(:,index)));
        end
        %motors.efficiency(index) = min([dataset.power.total(:,i) /(sum(motors.power.left(:,index)) + sum(motors.power.right(:,index))),1]);
        
%         %% Check if motion is feasable
%         if (exitFlagLeft==1 && exitFlagRight==1)
%             motors.feasable(index)=1;
%             motors.efficiency(index) = (dataset.power.total(:,i) /(sum(motors.power.left(:,index)) + sum(motors.power.right(:,index))));
%         else
%             
%             motors.feasable(index)=0;
%             motors.efficiency(index) = 0;
%             motors.forces.right(:,index) = zeros(5,1);
%             motors.power.right(:,index) = zeros(5,1);
%             motors.forces.left(:,index) = zeros(5,1);
%             motors.power.left(:,index) = zeros(5,1);
%         end
%         
        
        %% Next step
        index = index + 1;
    end
    
    

    motors.n_steps = index-1;

end

