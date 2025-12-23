# 修复乱码提交信息的自动化脚本
# 使用方法：在项目根目录运行 .\fix_commit_messages.ps1

Write-Host "开始修复乱码提交信息..." -ForegroundColor Green
Write-Host ""

# 检查是否有未提交的更改
$status = git status --porcelain
if ($status) {
    Write-Host "警告：检测到未提交的更改，请先提交或暂存它们" -ForegroundColor Yellow
    Write-Host "未提交的文件：" -ForegroundColor Yellow
    Write-Host $status
    $continue = Read-Host "是否继续？(y/n)"
    if ($continue -ne "y") {
        exit
    }
}

# 创建临时文件来存储 rebase 指令
$rebaseFile = Join-Path $env:TEMP "git-rebase-todo.txt"

# 准备 rebase todo 列表
$rebaseContent = @"
reword 4e324a7 Configure GitHub Pages deployment
reword b3dbd59 Add .nojekyll file to disable Jekyll build
reword 5c728df Add .nojekyll in root directory to disable Jekyll
reword 50cb5f5 Optimize GitHub Pages deployment configuration
reword 4f6c1bd Fix pnpm lockfile sync issue: allow updating lockfile in CI
reword f2b0cf0 Fix Biome code check errors: use node: protocol for Node.js built-in modules and format code
reword 8f9afc8 Fix Biome workflow: use project Biome version instead of latest
reword f93e234 Fix Biome workflow: allow updating lockfile
reword 986d970 Fix build workflow: allow updating lockfile
pick e3b4fa9 Fix Astro type check errors
pick 05badfa Fix remaining Astro type check errors
pick 1cc88e3 Remove unused ts-expect-error directive
"@

# 创建提交信息文件
$commitMessages = @{
    "4e324a7" = "Configure GitHub Pages deployment"
    "b3dbd59" = "Add .nojekyll file to disable Jekyll build"
    "5c728df" = "Add .nojekyll in root directory to disable Jekyll"
    "50cb5f5" = "Optimize GitHub Pages deployment configuration"
    "4f6c1bd" = "Fix pnpm lockfile sync issue: allow updating lockfile in CI"
    "f2b0cf0" = "Fix Biome code check errors: use node: protocol for Node.js built-in modules and format code"
    "8f9afc8" = "Fix Biome workflow: use project Biome version instead of latest"
    "f93e234" = "Fix Biome workflow: allow updating lockfile"
    "986d970" = "Fix build workflow: allow updating lockfile"
}

Write-Host "准备开始 rebase..." -ForegroundColor Cyan
Write-Host "这将修改 Git 历史，完成后需要 force push" -ForegroundColor Yellow
Write-Host ""

# 设置 Git 编辑器为 PowerShell 脚本
$editorScript = Join-Path $env:TEMP "git-editor.ps1"
@"
# Git 编辑器脚本
param([string]`$file)

# 读取原始内容
`$content = Get-Content `$file -Raw

# 如果是 rebase todo 文件，使用预设的内容
if (`$file -like "*git-rebase-todo*") {
    Set-Content `$file -Value @'
$($rebaseContent)
'@
} else {
    # 如果是提交信息文件，根据提交 hash 设置正确的信息
    `$hash = git log -1 --format=%H
    `$shortHash = `$hash.Substring(0, 7)
    
    if (`$commitMessages.ContainsKey(`$shortHash)) {
        Set-Content `$file -Value `$commitMessages[`$shortHash]
    } else {
        # 保持原内容
        Set-Content `$file -Value `$content
    }
}
"@ | Set-Content $editorScript

# 设置 Git 使用我们的编辑器
$env:GIT_EDITOR = "powershell -File `"$editorScript`""
$env:GIT_SEQUENCE_EDITOR = "powershell -File `"$editorScript`""

Write-Host "开始执行 rebase..." -ForegroundColor Cyan
try {
    git rebase -i e7ca60b
    
    Write-Host ""
    Write-Host "Rebase 完成！" -ForegroundColor Green
    Write-Host ""
    Write-Host "请检查提交历史：" -ForegroundColor Cyan
    git log --oneline -15
    
    Write-Host ""
    Write-Host "如果一切正常，运行以下命令推送到远程：" -ForegroundColor Yellow
    Write-Host "  git push --force-with-lease origin main" -ForegroundColor White
    
} catch {
    Write-Host "Rebase 过程中出现错误：$_" -ForegroundColor Red
    Write-Host "如果 rebase 中断，可以运行 'git rebase --abort' 取消" -ForegroundColor Yellow
} finally {
    # 清理临时文件
    if (Test-Path $editorScript) { Remove-Item $editorScript -ErrorAction SilentlyContinue }
    if (Test-Path $rebaseFile) { Remove-Item $rebaseFile -ErrorAction SilentlyContinue }
}

