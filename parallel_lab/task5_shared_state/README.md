Задание 5. Файлы вынесены из `tests/`, чтобы базовые замеры (заданий 2–4) шли ровно на 24 тестах.

- `test_profile.py` — исходный тест с общим файлом `profile.json` (падает при `-n 4`).
- `test_profile_fixed.py` — исправленный (фикстура `tmp_path`).

Запуск (из папки parallel_lab):
    pytest task5_shared_state/test_profile.py -v
    pytest task5_shared_state/test_profile.py -n 4 -v      # 3 раза, считать падения
    pytest task5_shared_state/test_profile_fixed.py -n 4 -v   # 3 раза
