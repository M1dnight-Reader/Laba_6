% run_tests.m - запуск всех тестов проекта
function run_tests
    fprintf('====================================\n');
    fprintf('Запуск тестов проекта HT1\n');
    fprintf('====================================\n\n');
    
    % Сохраняем текущую папку
    originalDir = pwd;
    
    try
        % Определяем корневую папку проекта
        scriptPath = mfilename('fullpath');
        projectRoot = fileparts(scriptPath);
        
        % Переходим в корень проекта и запускаем startup
        cd(projectRoot);
        startup;
        
        % Теперь переходим в папку тестов
        testsDir = fullfile(projectRoot, 'tests');
        if exist(testsDir, 'dir')
            cd(testsDir);
        else
            error('Папка tests не найдена!');
        end
        
        % Список тестов (добавляйте новые тесты здесь)
        testFiles = {
            'test_basic.m'
            % 'test_performance.m'  % пример для будущих тестов
            % 'test_validation.m'   % пример для будущих тестов
        };
        
        passed = 0;
        failed = 0;
        
        % Запускаем каждый тест
        for i = 1:length(testFiles)
            testFile = testFiles{i};
            fprintf('Запуск теста: %s\n', testFile);
            fprintf('----------------------------\n');
            
            % Проверяем существование файла
            if exist(testFile, 'file')
                % Получаем имя функции из имени файла
                [~, funcName] = fileparts(testFile);
                
                % Вызываем тестовую функцию
                try
                    feval(funcName);
                    fprintf('✓ Тест %s пройден\n\n', testFile);
                    passed = passed + 1;
                catch ME
                    fprintf('✗ Тест %s не пройден: %s\n\n', testFile, ME.message);
                    failed = failed + 1;
                end
            else
                fprintf('⚠ Тестовый файл %s не найден\n\n', testFile);
                failed = failed + 1;
            end
        end
        
        % Возвращаемся в исходную папку
        cd(originalDir);
        
        % Выводим итоги
        fprintf('====================================\n');
        fprintf('Итоги тестирования:\n');
        fprintf('  Пройдено: %d\n', passed);
        fprintf('  Не пройдено: %d\n', failed);
        fprintf('  Всего: %d\n', passed + failed);
        
        if failed == 0
            fprintf('✓ Все тесты пройдены успешно!\n');
        else
            fprintf('⚠ Некоторые тесты не пройдены\n');
        end
        fprintf('====================================\n');
        
    catch ME
        % Возвращаемся в исходную папку при ошибке
        cd(originalDir);
        fprintf('✗ Критическая ошибка: %s\n', ME.message);
        fprintf('====================================\n');
        rethrow(ME);
    end
end