@echo off
echo ===============================
echo Laravel + Inertia Setup Script
echo ===============================

REM 1. Установка PHP-зависимостей
echo Installing PHP dependencies...
composer install

REM 2. Проверка наличия pnpm
where pnpm >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo pnpm not found. Installing globally...
    npm install -g pnpm
)

REM 3. Установка Node-зависимостей
echo Installing Node dependencies...
pnpm install

REM 4. Проверка наличия .env
IF NOT EXIST ".env" (
    echo Copying .env.example to .env...
    copy .env.example .env
)

REM 5. Генерация ключа приложения
echo Generating app key...
php artisan key:generate

REM 6. Создание SQLite базы (если используется)
IF NOT EXIST "database\database.sqlite" (
    echo Creating SQLite database file...
    type nul > database\database.sqlite
)

REM 7. Прогон миграций
echo Running migrations...
php artisan migrate

REM 8. Очистка кэшей
echo Clearing caches...
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo ===============================
echo Setup complete!
echo You can now run:
echo   php artisan serve
echo   pnpm run dev
echo ===============================
pause