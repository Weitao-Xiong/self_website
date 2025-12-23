# 修复乱码提交信息指南

## 需要修复的提交（从旧到新）

1. `4e324a7` - 配置 GitHub Pages 部署
2. `b3dbd59` - 添加 .nojekyll 文件禁用 Jekyll 构建
3. `5c728df` - 在根目录添加 .nojekyll 禁用 Jekyll
4. `50cb5f5` - 优化 GitHub Pages 部署配置
5. `4f6c1bd` - 修复 pnpm lockfile 不同步问题，允许在 CI 中更新 lockfile
6. `f2b0cf0` - 修复 Biome 代码检查错误：使用 node: 协议导入 Node.js 内置模块并格式化代码
7. `8f9afc8` - 修复 Biome 工作流：使用项目中的 Biome 版本而不是 latest
8. `f93e234` - 修复 Biome 工作流：允许更新 lockfile
9. `986d970` - 修复 build 工作流：允许更新 lockfile

## 方法：使用 git rebase

### 步骤 1：开始交互式 rebase

从最后一个正常提交（`e7ca60b`）之后开始：

```bash
git rebase -i e7ca60b
```

### 步骤 2：在编辑器中修改

将需要修改的提交前的 `pick` 改为 `reword`（或简写 `r`）：

```
reword 4e324a7 配置 GitHub Pages 部署
reword b3dbd59 添加 .nojekyll 文件禁用 Jekyll 构建
reword 5c728df 在根目录添加 .nojekyll 禁用 Jekyll
reword 50cb5f5 优化 GitHub Pages 部署配置
reword 4f6c1bd 修复 pnpm lockfile 不同步问题，允许在 CI 中更新 lockfile
reword f2b0cf0 修复 Biome 代码检查错误：使用 node: 协议导入 Node.js 内置模块并格式化代码
reword 8f9afc8 修复 Biome 工作流：使用项目中的 Biome 版本而不是 latest
reword f93e234 修复 Biome 工作流：允许更新 lockfile
reword 986d970 修复 build 工作流：允许更新 lockfile
pick e3b4fa9 Fix Astro type check errors
pick 05badfa Fix remaining Astro type check errors
pick 1cc88e3 Remove unused ts-expect-error directive
```

### 步骤 3：逐个修改提交信息

Git 会逐个打开编辑器，将乱码改为正确的英文：

- `4e324a7` → `Configure GitHub Pages deployment`
- `b3dbd59` → `Add .nojekyll file to disable Jekyll build`
- `5c728df` → `Add .nojekyll in root directory to disable Jekyll`
- `50cb5f5` → `Optimize GitHub Pages deployment configuration`
- `4f6c1bd` → `Fix pnpm lockfile sync issue: allow updating lockfile in CI`
- `f2b0cf0` → `Fix Biome code check errors: use node: protocol for Node.js built-in modules and format code`
- `8f9afc8` → `Fix Biome workflow: use project Biome version instead of latest`
- `f93e234` → `Fix Biome workflow: allow updating lockfile`
- `986d970` → `Fix build workflow: allow updating lockfile`

### 步骤 4：完成并推送

```bash
# 检查状态
git log --oneline -15

# 强制推送（谨慎使用！）
git push --force-with-lease origin main
```

## ⚠️ 重要提示

- `--force-with-lease` 比 `--force` 更安全，它会检查远程是否有其他人的提交
- 如果这是个人项目，可以安全使用
- 如果是团队项目，请先与团队沟通
- 修改历史后，其他协作者需要重新克隆或重置他们的本地仓库

