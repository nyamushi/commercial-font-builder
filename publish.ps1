# ==========================================================================
#  发布 commercial-font-builder 到 GitHub
#
#  用法（在【你自己的 PowerShell 窗口】里执行）：
#      cd D:\dsh\commercial-font-builder
#      powershell -ExecutionPolicy Bypass -File publish.ps1
#
#  前置条件：先在 GitHub 上创建一个空仓库
#      https://github.com/new
#      名称填 commercial-font-builder
#      不要勾选 Add README / .gitignore / license（否则推送会冲突）
#
#  首次推送会弹出 GitHub 登录窗口（浏览器授权一次即可）。
#  沙箱环境不允许 git 调用凭据弹窗，所以这一步必须由你在自己的终端完成。
#  若凭据已缓存，也可直接执行：git push -u origin main
# ==========================================================================

$ErrorActionPreference = 'Continue'

function Step($t) { Write-Host "`n=== $t ===" -ForegroundColor Cyan }

Step '本地仓库状态'
if (-not (Test-Path (Join-Path $PWD '.git'))) {
    Write-Host '未找到 .git，请确认当前目录是 commercial-font-builder' -ForegroundColor Red
    exit 1
}
Write-Host ('目录    : ' + $PWD)
Write-Host ('提交    : ' + (git log --oneline -1))
Write-Host ('远程    : ' + (git remote get-url origin 2>$null))

Step '待提交改动检查'
$dirty = git status --short
if ($dirty) {
    Write-Host '有以下未提交改动，先提交再推送：' -ForegroundColor Yellow
    $dirty | ForEach-Object { Write-Host ('  ' + $_) }
    $ans = Read-Host '现在自动提交？(y/N)'
    if ($ans -match '^[yY]') {
        git add -A
        git commit -q -m 'Update skill documentation'
        Write-Host '已提交' -ForegroundColor Green
    } else {
        Write-Host '已跳过，推送的将是上一次提交的内容' -ForegroundColor Yellow
    }
} else {
    Write-Host '工作区干净' -ForegroundColor Green
}

Step '推送'
git push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "`n推送失败，常见原因：" -ForegroundColor Red
    Write-Host '  1. GitHub 上还没创建这个仓库 —— 先到 https://github.com/new 建一个空仓库'
    Write-Host '  2. 创建时勾选了 README / .gitignore / license，导致远程已有提交'
    Write-Host '     这种情况先执行：git pull --rebase origin main  再重新 push'
    Write-Host '  3. 未登录或 Token 无 repo 权限'
    Write-Host "  4. 仓库地址不对（当前: $(git remote get-url origin)）"
    exit 1
}

Step '完成'
Write-Host '仓库: https://github.com/nyamushi/commercial-font-builder' -ForegroundColor Green
Write-Host ''
Write-Host '建议顺手做两件事：'
Write-Host '  1. 在仓库 Settings → General 里填写 Description 与 Topics'
Write-Host '     建议 Topics：agent-skill, font-design, typography, fonttools, ufo, opentype'
Write-Host '  2. 确认 LICENSE 已被 GitHub 识别为 MIT（仓库首页右侧会显示 MIT license）'
