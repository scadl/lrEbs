# lrEbs — Библиотечная система

## Обзор проекта

**lrEbs** — это веб-приложение для управления библиотекой, предназначенное для археологов и других гуманитарных исследований.

### Стек технологий

**Backend:**
- **PHP 8.4** с **Laravel 12**
- **Laravel Fortify** — аутентификация (включая 2FA)
- **Inertia.js v2** — мост между сервером и клиентом
- **Laravel Wayfinder** — генерация TypeScript-функций для маршрутов

**Frontend:**
- **React 19** с TypeScript
- **Inertia.js v2** — клиентская навигация и формы
- **Tailwind CSS v4** — стилизация
- **Radix UI** + **shadcn/ui** — компоненты интерфейса
- **Vite 7** — сборка

**Тестирование:**
- **Pest v3** — фреймворк для тестирования
- **PHPUnit v11**

**Инструменты разработки:**
- **Laravel Pint** — форматирование кода
- **Laravel Boost** — MCP-сервер для разработки
- **ESLint v9** + **Prettier v3**

---

## Структура проекта

```
lrEbs/
├── app/
│   ├── Actions/          # Классы действий (business logic)
│   ├── Concerns/         # Traits
│   ├── Http/
│   │   ├── Controllers/  # Контроллеры
│   │   ├── Middleware/   # Middleware (HandleInertiaRequests, HandleAppearance)
│   │   └── Requests/     # Form Request для валидации
│   ├── Models/           # Eloquent модели (User)
│   └── Providers/        # Service providers
├── bootstrap/
│   ├── app.php           # Конфигурация приложения (Laravel 12)
│   └── providers.php     # Регистрация сервис-провайдеров
├── config/               # Конфигурационные файлы
├── database/
│   ├── factories/        # Фабрики для тестов
│   ├── migrations/       # Миграции БД
│   └── seeders/          # Сидеры
├── resources/
│   ├── css/
│   │   └── app.css       # Основные стили (Tailwind)
│   └── js/
│       ├── actions/      # Wayfinder-функции для контроллеров
│       ├── components/   # React-компоненты (в т.ч. shadcn/ui)
│       ├── hooks/        # Custom React hooks
│       ├── layouts/      # Layout-компоненты
│       ├── lib/          # Утилиты (cn, utils)
│       ├── pages/        # Inertia-страницы
│       ├── routes/       # Wayfinder-функции для именованных маршрутов
│       ├── types/        # TypeScript типы
│       └── wayfinder/    # Сгенерированные Wayfinder файлы
│       ├── app.tsx       # Точка входа
│       └── ssr.tsx       # SSR-рендеринг
├── routes/
│   ├── web.php           # Веб-маршруты
│   ├── settings.php      # Маршруты настроек (Fortify)
│   └── console.php       # Консольные команды
├── tests/
│   ├── Feature/          # Feature-тесты (Pest)
│   ├── Unit/             # Unit-тесты (Pest)
│   ├── Pest.php          # Конфигурация Pest
│   └── TestCase.php      # Базовый тест-кейс
└── public/               # Публичные ассеты
```

---

## Установка и запуск

### Требования
- PHP 8.4+
- Composer
- Node.js 20+
- SQLite (или другая БД)

### Первоначальная настройка

```bash
# Клонирование и установка зависимостей
composer install
npm install

# Копирование .env и генерация ключа
cp .env.example .env
php artisan key:generate

# Создание БД и миграции
touch database/database.sqlite
php artisan migrate

# Сборка фронтенда
npm run build
```

### Команды разработки

| Команда | Описание |
|---------|----------|
| `npm run dev` | Запуск dev-сервера (PHP + Vite) |
| `npm run build` | Сборка для продакшена |
| `npm run build:ssr` | SSR-сборка |
| `npm run format` | Форматирование TypeScript/React |
| `npm run lint` | ESLint с автоисправлением |
| `npm run types` | Проверка типов TypeScript |
| `composer run dev` | Запуск всех сервисов (server, queue, vite) |
| `composer run test` | Запуск всех тестов |
| `composer run lint` | Форматирование PHP (Pint) |

### Тестирование

```bash
# Все тесты
php artisan test --compact

# Конкретный тест
php artisan test --compact --filter=TestName

# Feature-тесты
php artisan test --compact tests/Feature

# Unit-тесты
php artisan test --compact tests/Unit
```

---

## Архитектурные особенности

### Laravel 12
- Middleware регистрируются в `bootstrap/app.php`
- Нет `app/Http/Kernel.php`
- Консольные команды в `app/Console/Commands/` регистрируются автоматически

### Inertia.js v2
- Страницы в `resources/js/pages/`
- Рендеринг через `Inertia::render()` вместо Blade
- **Новые возможности v2:** deferred props, infinite scroll, merging props, polling, prefetching

### Laravel Wayfinder
- Генерирует TypeScript-функции для маршрутов
- Импорт из `@/actions/` (контроллеры) или `@/routes/` (именованные маршруты)
- Пример:
  ```typescript
  import { dashboard } from '@/routes';
  import StorePost from '@/actions/StorePostController';
  
  // Использование
  dashboard();
  StorePost({ title: 'Post' });
  ```

### shadcn/ui + Radix UI
- Компоненты в `resources/js/components/ui/`
- Стиль: `new-york`
- Иконки: Lucide

---

## Соглашения разработки

### PHP
- Использовать **constructor property promotion** (PHP 8)
- Всегда указывать **типы возвращаемых значений**
- Использовать **PHPDoc** вместо inline-комментариев
- Фигурные скобки обязательны для всех управляющих структур

### Модели
- Метод `casts()` вместо свойства `$casts`
- Использовать **Eloquent relationships** вместо raw queries
- Избегать N+1 через eager loading (`with()`)

### Контроллеры
- Валидация через **Form Request** классы
- Использовать `auth()->user()` или типизированные параметры

### Тесты (Pest)
- Feature-тесты по умолчанию
- Использовать `RefreshDatabase` для изоляции
- Фабрики для создания моделей
- Следовать паттерну: `test_[functionality]_[condition]_[expected_result]`

### TypeScript/React
- Строгий режим типов (`strict: true`)
- Функциональные компоненты с typed props
- Path aliases: `@/*` → `./resources/js/*`

### Tailwind CSS v4
- Использовать утилитарные классы
- Проверять существующие паттерны перед добавлением новых

---

## База данных

### Текущая схема
- **users** — пользователи (id, name, email, password, email_verified_at, remember_token, timestamps)
- **password_reset_tokens** — токены сброса пароля
- **sessions** — сессии (для database session driver)

### Миграции
- При изменении колонки указывать **все** атрибуты (иначе будут потеряны)

---

## Аутентификация

Реализована через **Laravel Fortify**:
- Регистрация (опционально)
- Вход/выход
- Сброс пароля
- Двухфакторная аутентификация (2FA)

Маршруты аутентификации подключены через `require __DIR__.'/settings.php';` в `routes/web.php`.

---

## Полезные ссылки

- [Документация Laravel 12](https://laravel.com/docs/12.x)
- [Inertia.js v2](https://inertiajs.com/)
- [Pest PHP](https://pestphp.com/)
- [shadcn/ui](https://ui.shadcn.com/)
- [Tailwind CSS v4](https://tailwindcss.com/)
- [Laravel Wayfinder](https://github.com/laravel/wayfinder)
