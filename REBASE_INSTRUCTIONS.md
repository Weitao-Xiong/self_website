# 修复乱码提交信息的步骤

## 方法 1：使用 git rebase（推荐）

由于已经推送到远程，需要按以下步骤操作：

### 步骤 1：开始交互式 rebase
```bash
git rebase -i e3b4fa9
```

### 步骤 2：在打开的编辑器中
将需要修改的提交前的 `pick` 改为 `reword`（或 `r`），例如：
```
pick 986d970 修复 build 工作流：允许更新 lockfile
pick f93e234 修复 Biome 工作流：允许更新 lockfile
pick 8f9afc8 修复 Biome 工作流：使用项目中的 Biome 版本而不是 latest
pick f2b0cf0 修复 Biome 代码检查错误：使用 node: 协议导入 Node.js 内置模块并格式化代码
pick 4f6c1bd 修复 pnpm lockfile 不同步问题，允许在 CI 中更新 lockfile
pick 50cb5f5 优化 GitHub Pages 部署配置
pick 5c728df 在根目录添加 .nojekyll 禁用 Jekyll
pick b3dbd59 添加 .nojekyll 文件禁用 Jekyll 构建
pick 4e324a7 配置 GitHub Pages 部署
```

保存并关闭编辑器。

### 步骤 3：逐个修改提交信息
Git 会逐个打开编辑器让你修改每个提交的信息。将乱码改为正确的英文或中文。

### 步骤 4：完成 rebase 后强制推送
```bash
git push --force-with-lease origin main
```

## 方法 2：使用脚本自动修复（如果方法 1 不可行）

如果编辑器有问题，可以使用以下 PowerShell 命令：

```powershell
# 设置 Git 使用简单的编辑器
$env:GIT_EDITOR = "powershell -Command `"Get-Content `$args[0] | ForEach-Object { if (`$_ -match '^pick') { `$_ -replace '^pick', 'reword' } else { `$_ } } | Set-Content `$args[0]`""

# 开始 rebase
git rebase -i e3b4fa9
```

## 注意事项

⚠️ **重要**：修改已推送的提交历史需要 `force push`，这会影响其他协作者。如果这是个人项目或只有你一个人在使用，可以安全地进行。如果是团队项目，请先与团队沟通。

