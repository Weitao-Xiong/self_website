# 快速修复乱码提交信息
# 使用方法：在项目根目录运行 .\quick_fix_commits.ps1

Write-Host "=== 修复乱码提交信息 ===" -ForegroundColor Green
Write-Host ""

# 检查工作区状态
$status = git status --porcelain
if ($status) {
    Write-Host "警告：有未提交的更改" -ForegroundColor Yellow
    Write-Host $status
    $continue = Read-Host "是否继续？(y/n)"
    if ($continue -ne "y") { exit }
}

Write-Host "开始修复..." -ForegroundColor Cyan
Write-Host ""

# 使用 git filter-branch 来批量修改提交信息
# 这个方法更安全，不会改变提交的 hash（只改变提交信息）

$commitMap = @{
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

Write-Host "方法 1：使用 git rebase（推荐）" -ForegroundColor Yellow
Write-Host ""
Write-Host "执行以下命令：" -ForegroundColor Cyan
Write-Host "  git rebase -i e7ca60b" -ForegroundColor White
Write-Host ""
Write-Host "在打开的编辑器中：" -ForegroundColor Cyan
Write-Host "  1. 将所有乱码提交的 'pick' 改为 'reword'（或 'r'）" -ForegroundColor White
Write-Host "  2. 保存并关闭编辑器" -ForegroundColor White
Write-Host "  3. Git 会逐个打开编辑器，将乱码改为正确的英文" -ForegroundColor White
Write-Host "  4. 完成后运行: git push --force-with-lease origin main" -ForegroundColor White
Write-Host ""

$choice = Read-Host "是否现在执行 git rebase？(y/n)"
if ($choice -eq "y") {
    # 设置编辑器为 notepad
    $env:GIT_EDITOR = "notepad"
    $env:GIT_SEQUENCE_EDITOR = "notepad"
    
    Write-Host "开始 rebase..." -ForegroundColor Cyan
    git rebase -i e7ca60b
    
    Write-Host ""
    Write-Host "如果 rebase 成功完成，运行以下命令推送：" -ForegroundColor Green
    Write-Host "  git push --force-with-lease origin main" -ForegroundColor White
} else {
    Write-Host "已取消。你可以稍后手动执行 git rebase -i e7ca60b" -ForegroundColor Yellow
}

