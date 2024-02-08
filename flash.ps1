$startTime = Get-Date

# 在此处添加要计时的代码块
# 例如：
openocd -f ./openocd.cfg -c "program build/output.elf verify reset exit"

$endTime = Get-Date
$totalTime = $endTime - $startTime

Write-Output "代码块执行时间: $totalTime"




# xmake project -k compile_commands .vscode