% startup.m - инициализация проекта HT1
fprintf('====================================\n');
fprintf('Инициализация проекта HT1...\n');
fprintf('====================================\n\n');

% Определяем корневую папку проекта
currentPath = mfilename('fullpath');
utilsDir = fileparts(currentPath);
projectRoot = fileparts(utilsDir);  % На уровень выше utils

% 1. Переходим в корень проекта
cd(projectRoot);
fprintf('Текущая рабочая папка: %s\n', pwd);

% 2. Добавляем необходимые пути
addpath(projectRoot);                % Корень проекта (для HT1.m)
addpath(fullfile(projectRoot, 'src'));      % Основные скрипты
addpath(fullfile(projectRoot, 'tests'));    % Тесты
addpath(fullfile(projectRoot, 'utils'));    % Утилиты

% 3. Инициализация параметров системы (из задания/варианта)
% Замените значения на свои или загрузите из файла
t = 0.4;    % Параметр для W1
T = 7.0;    % Параметр для W1
k1 = 20;   % Коэффициент усиления W2
T1 = 0.025;   % Постоянная времени W2
k2 = 45.0;   % Коэффициент усиления W3

% 4. Вывод информации
disp('Параметры инициализированы:');
disp(['t = ', num2str(t)]);
disp(['T = ', num2str(T)]);
disp(['k1 = ', num2str(k1)]);
disp(['T1 = ', num2str(T1)]);
disp(['k2 = ', num2str(k2)]);

% 5. Проверка наличия основных файлов
% Проверяем HT1.m в нескольких возможных местах
ht1Paths = {
    fullfile(projectRoot, 'HT1.m'),           % В корне
    fullfile(projectRoot, 'src', 'HT1.m')     % В папке src
};

ht1Found = false;
for i = 1:length(ht1Paths)
    if exist(ht1Paths{i}, 'file')
        fprintf('Основной файл HT1.m найден: %s\n', ht1Paths{i});
        ht1Found = true;
        break;
    end
end

if ~ht1Found
    warning('Основной файл HT1.m не найден!');
    fprintf('Искали в следующих местах:\n');
    for i = 1:length(ht1Paths)
        fprintf('  %s\n', ht1Paths{i});
    end
    fprintf('Текущая папка: %s\n', pwd);
    fprintf('Содержимое текущей папки:\n');
    dir(pwd);
end

% Проверяем draw_pictures.m
drawPicturesPath = fullfile(projectRoot, 'src', 'draw_pictures.m');
if exist(drawPicturesPath, 'file')
    disp('Файл draw_pictures.m найден');
else
    warning('Файл draw_pictures.m не найден!');
end

fprintf('\nПроект готов. Для запуска системы выполните HT1\n');
fprintf('====================================\n\n');