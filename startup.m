% startup.m - инициализация проекта HT1
fprintf('====================================\n');
fprintf('Инициализация проекта HT1...\n');
fprintf('====================================\n\n');

% Определяем корневую папку проекта
projectRoot = fileparts(mfilename('fullpath'));

% 1. Переходим в корень проекта
cd(projectRoot);

% 2. Добавляем необходимые пути
addpath(fullfile(projectRoot, 'src'));      % Основные скрипты
addpath(fullfile(projectRoot, 'tests'));    % Тесты (если есть)

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
if exist(fullfile(projectRoot, 'src', 'HT1.m'), 'file')
    disp('Основной файл HT1.m найден');
else
    warning('Основной файл HT1.m не найден!');
end

if exist(fullfile(projectRoot, 'src', 'draw_pictures.m'), 'file')
    disp('Файл draw_pictures.m найден');
else
    warning('Файл draw_pictures.m не найден!');
end

fprintf('\nПроект готов. Для запуска системы выполните HT1\n');
fprintf('====================================\n\n');