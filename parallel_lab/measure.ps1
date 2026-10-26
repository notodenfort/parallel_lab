# Автоматический замер всех режимов (PowerShell). Запуск из папки parallel_lab при активном .venv:
#   .\measure.ps1
# Результат: results.txt (время каждого прогона из последней строки pytest)
$ErrorActionPreference = "Continue"
"Ядер: $([Environment]::ProcessorCount)" | Tee-Object results.txt
$runs = @(
  @("sequential", "pytest -q"),
  @("n2", "pytest -q -n 2"),
  @("n4", "pytest -q -n 4"),
  @("auto", "pytest -q -n auto"),
  @("split-static-1", "pytest -q --splits 4 --group 1"),
  @("split-static-2", "pytest -q --splits 4 --group 2"),
  @("split-static-3", "pytest -q --splits 4 --group 3"),
  @("split-static-4", "pytest -q --splits 4 --group 4")
)
foreach ($r in $runs) {
  $out = Invoke-Expression ($r[1] + " 2>&1") | Select-Object -Last 1
  "$($r[0]): $out" | Tee-Object -Append results.txt
}
pytest -q --store-durations | Out-Null
foreach ($g in 1..4) {
  $out = Invoke-Expression "pytest -q --splits 4 --group $g --splitting-algorithm least_duration 2>&1" | Select-Object -Last 1
  "split-duration-${g}: $out" | Tee-Object -Append results.txt
}
