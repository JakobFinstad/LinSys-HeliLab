file = "negativ0_1_conugate2";
title = "-1 +-2*i";


plot_matFile(file + '.mat', [6], title, file)


function plot_matFile(file_path, rows, Title, save_as)
    % Load the .mat file
    data = load(file_path);
    
    % Extract the first numerical matrix with 7 rows
    fields = fieldnames(data);
    matrix = [];
    for i = 1:length(fields)
        if ismatrix(data.(fields{i})) && size(data.(fields{i}), 1) == 7
            matrix = data.(fields{i});
            break;
        end
    end
    
    if isempty(matrix)
        error('No valid 5-row matrix found in the .mat file.');
    end
    
    % Validate selected rows (excluding the first row, which is time)
    if any(rows < 2 | rows > 7)
        error('Invalid row selection. Choose rows between 2 and 5 (data rows).');
    end
    
    % Extract time and selected data rows
    time = matrix(1, :); % First row as time
    
    % Variable names corresponding to rows 2:7
    variable_names = {'Time','\lambda (travel)', 'r (travel rate)', 'p (pitch)', ...
                      "p' (pitch rate)", 'e (elevation)', "e' (elevation rate)"};
    
    delta_t = 0.25;
    
    t = 0:delta_t:delta_t*(140-1);
    % Create a plot
    figure;
    
    
    subplot(2,1,1);
    hold on;
    plot(time, matrix(4, :), 'DisplayName', variable_names{4}, 'LineWidth', 1);
    %plot(t,x1, 'r--',"LineWidth",1.5)
    hold off;
    
    xlabel('Time Steps');
    xlim([0,11])
    ylabel('Degrees');
    %ylim([-3,5]);
    title(Title + "- Pitch");
    legend;
    grid on;
    
    subplot(2,1,2);
    hold on;
    plot(time, matrix(6, :), 'DisplayName', variable_names{6}, 'LineWidth', 1);
    hold off;
    
    xlabel('Time Steps');
    xlim([0,11])
    ylabel('Degrees');
    %ylim([-3,5]);
    title(Title + "- Elevation");
    legend;
    grid on;
    %saveas(gcf, 'day2_' + save_as + '.png');
end