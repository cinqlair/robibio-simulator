function plot_joint_cumulated_power_positive_vs_negative(motors, dataset)

    plus_left=[];
    plus_right=[];
    index=1;
    for i=motors.start:motors.step:motors.stop
        % Left leg
        plus_left(index) = sum(dataset.power.q([1;0;1;0;1;0].*dataset.power.q(:,i)>0 , i));
        minus_left(index) = sum(dataset.power.q([1;0;1;0;1;0].*dataset.power.q(:,i)<0 , i));
        % Right leg
        plus_right(index) = sum(dataset.power.q([0;1;0;1;0;1].*dataset.power.q(:,i)>0 , i));
        minus_right(index) = sum(dataset.power.q([0;1;0;1;0;1].*dataset.power.q(:,i)<0 , i));

        index = index+1;
    end
    
    
    subplot(2,1,1); hold on; grid on;
    mono = cumsum(plus_left-minus_left);
    bi = cumsum(abs(plus_left+minus_left));
    %area (mono, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
    %area (bi, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
    plot (mono, 'b');
    plot(bi, 'r');
    title ('Cumulated power for left leg [W]');
    legend ('\Sigma |P⁺ + P^-|', '\Sigma |P⁺ - P^-|');

    subplot(2,1,2); hold on; grid on;
    mono = cumsum(plus_right-minus_right);
    bi = cumsum(abs(plus_right+minus_right));
    %area (mono, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
    %area (bi, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
    plot (mono, 'b');
    plot(bi, 'r');
    
    title ('Cumulated power for right leg [W]');
    legend ('\Sigma |P⁺ + P^-|', '\Sigma |P⁺ - P^-|');

end

