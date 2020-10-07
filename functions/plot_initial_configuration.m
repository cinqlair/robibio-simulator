function [handle] = plot_initial_configuration(x, lb, ub)
    
    hold on; grid on;
    plot (0,0,'k.', 'MarkerSize', 20);
    plot (0,-380,'k.', 'MarkerSize', 20);
    plot (0,-738.5,'k.', 'MarkerSize', 20);
    plot (121,-792.5,'k.', 'MarkerSize', 20);

    line ([0,0],[0,-380]);
    line ([0,0],[-380,-738.5]);
    line ([0,121],[-738.5, -792.5]);

    patch ([lb(1) ub(1) ub(1) lb(1)] , [lb(2) lb(2) ub(2) ub(2)], 'r', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);
    patch ([lb(3) ub(3) ub(3) lb(3)] , [lb(4) lb(4) ub(4) ub(4)]-380, 'b', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);

    patch ([lb(6) ub(6) ub(6) lb(6)] , [lb(7) lb(7) ub(7) ub(7)]-380, 'r', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);
    patch ([lb(8) ub(8) ub(8) lb(8)] , [lb(9) lb(9) ub(9) ub(9)]-738.5, 'b', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);

    patch ([lb(11) ub(11) ub(11) lb(11)] , [lb(12) lb(12) ub(12) ub(12)]-738.5, 'r', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);
    patch ([lb(13) ub(13) ub(13) lb(13)]+121 , [lb(14) lb(14) ub(14) ub(14)]-792.5, 'b', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);

    patch ([lb(16) ub(16) ub(16) lb(16)] , [lb(17) lb(17) ub(17) ub(17)], 'r', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);
    patch ([lb(18) ub(18) ub(18) lb(18)] , [lb(19) lb(19) ub(19) ub(19)]-738.5, 'b', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);

    patch ([lb(21) ub(21) ub(21) lb(21)] , [lb(22) lb(22) ub(22) ub(22)]-380, 'r', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);
    patch ([lb(23) ub(23) ub(23) lb(23)]+121 , [lb(24) lb(24) ub(24) ub(24)]-792.5, 'b', 'FaceAlpha', 0.1, 'EdgeAlpha', 0.4);

    line ([x(1) x(3)],[x(2) x(4)-380], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
    line ([x(6) x(8)],[x(7)-380 x(9)-738.5], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
    line ([x(11) x(13)+121],[x(12)-738.5 x(14)-792.5], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
    line ([x(16) x(18)],[x(17) x(19)-738.5], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
    line ([x(21) x(23)+121],[x(22)-380 x(24)-792.5], 'LineWidth', 5, 'Color', [1,0,0,0.2], 'Marker', '.');
    axis square equal;
end

