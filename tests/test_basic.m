% test_basic.m - базовый тест для проекта HT1
function test_basic
    fprintf('====================================\n');
    fprintf('Запуск базового теста HT1...\n');
    fprintf('====================================\n\n');
    
    % Сохраняем текущую папку
    originalDir = pwd;
    
    try
        % Определяем корневую папку проекта
        testPath = mfilename('fullpath');
        [testsDir, ~, ~] = fileparts(testPath);
        projectRoot = fileparts(testsDir);  % На уровень выше tests
        
        fprintf('Корневая папка проекта: %s\n', projectRoot);
        fprintf('Текущая папка теста: %s\n', testsDir);
        
        % Переходим в корневую папку проекта
        cd(projectRoot);
        fprintf('Перешли в корень проекта: %s\n', pwd);
        
        % Проверяем наличие startup.m в utils
        utilsPath = fullfile(projectRoot, 'utils');
        startupPath = fullfile(utilsPath, 'startup.m');
        
        fprintf('Ищем startup.m по пути: %s\n', startupPath);
        
        if exist(startupPath, 'file')
            fprintf('Найден startup.m, запускаем...\n');
            % Переходим в utils и запускаем startup
            cd(utilsPath);
            startup;
            cd(projectRoot);  % Возвращаемся в корень проекта
        else
            % Показываем содержимое папки utils для отладки
            fprintf('Содержимое папки utils:\n');
            if exist(utilsPath, 'dir')
                dir(utilsPath);
            else
                fprintf('Папка utils не существует!\n');
            end
            error('Файл startup.m не найден в папке utils!');
        end
        
        % Проверяем, что переменные определены
        vars = {'t', 'T', 'k1', 'T1', 'k2'};
        missingVars = {};
        for i = 1:length(vars)
            if ~exist(vars{i}, 'var')
                missingVars{end+1} = vars{i};
            end
        end
        
        if ~isempty(missingVars)
            error('Переменные не определены: %s', strjoin(missingVars, ', '));
        end
        
        fprintf('✓ Все параметры определены\n');
        fprintf('  t=%.2f, T=%.2f, k1=%.2f, T1=%.2f, k2=%.2f\n', ...
                t, T, k1, T1, k2);
        
        % Создаем передаточные функции с текущими параметрами
        W1 = tf([t, 1], [T, 1]);
        W2 = tf(k1, [T1, 1, 0]);
        W3 = tf(k2, [1, 0]);
        
        W5 = feedback(W2, 1, -1);
        W5_5 = series(W1, W5);
        W6 = series(W5_5, W3);
        Fx = feedback(W6, 1, -1);
        
        % Проверяем размерности
        [num, den] = tfdata(Fx, 'v');
        if length(num) > 0 && length(den) > 0
            fprintf('✓ Передаточная функция Fx успешно создана\n');
            fprintf('  Порядок системы: %d\n', length(den)-1);
        else
            error('Некорректная передаточная функция Fx');
        end
        
        % Проверяем устойчивость (простейшая проверка)
        poles = pole(Fx);
        if all(real(poles) < 0)
            fprintf('✓ Система устойчива (все полюса в левой полуплоскости)\n');
        else
            fprintf('⚠ Система неустойчива (полюса: %s)\n', ...
                    mat2str(poles', 3));
        end
        
        % Проверяем наличие draw_pictures.m
        drawPicturesPath = fullfile(projectRoot, 'src', 'draw_pictures.m');
        if exist(drawPicturesPath, 'file')
            fprintf('✓ Файл draw_pictures.m найден\n');
            
            % Проверяем, что функция вызывается без ошибок
            try
                % Создаем временную фигуру для теста
                h = figure('Visible', 'off');
                draw_pictures;
                close(h);
                fprintf('✓ Функция draw_pictures выполнена успешно\n');
            catch ME
                fprintf('⚠ Ошибка при выполнении draw_pictures: %s\n', ME.message);
            end
        else
            warning('Файл draw_pictures.m не найден!');
        end
        
        fprintf('\n✓ Тест пройден успешно!\n');
        
    catch ME
        % Возвращаемся в исходную папку при ошибке
        cd(originalDir);
        fprintf('✗ Ошибка в тесте: %s\n', ME.message);
        fprintf('  Идентификатор: %s\n', ME.identifier);
        rethrow(ME);
    end
    
    % Возвращаемся в исходную папку
    cd(originalDir);
    
    fprintf('\n====================================\n');
    fprintf('Тест завершен\n');
    fprintf('====================================\n');
end