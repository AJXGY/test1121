#!/bin/bash

# ============================================
# Git 远程协作演示脚本
# 演示内容：连接 GitHub、推送、拉取
# ============================================

echo "======================================"
echo "Git 远程协作演示"
echo "======================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 演示函数
demo() {
    echo -e "${BLUE}>>> $1${NC}"
    echo ""
}

pause() {
    echo ""
    echo -e "${YELLOW}按回车键继续...${NC}"
    read
}

# ============================================
# 1. 查看远程仓库
# ============================================
demo "1. 查看当前配置的远程仓库"
git remote -v

if [ $? -ne 0 ] || [ -z "$(git remote)" ]; then
    echo -e "${YELLOW}还没有配置远程仓库${NC}"
else
    echo -e "${GREEN}已配置的远程仓库${NC}"
fi
pause

# ============================================
# 2. 添加远程仓库
# ============================================
demo "2. 添加远程仓库"
echo "远程仓库 URL: https://github.com/AJXGY/test1121.git"
echo ""

# 检查是否已经添加了 origin
if git remote | grep -q "^origin$"; then
    echo -e "${YELLOW}远程仓库 origin 已存在，跳过添加${NC}"
else
    echo "执行命令: git remote add origin https://github.com/AJXGY/test1121.git"
    git remote add origin https://github.com/AJXGY/test1121.git
    echo -e "${GREEN}远程仓库添加成功！${NC}"
fi
pause

demo "3. 再次查看远程仓库"
git remote -v
pause

# ============================================
# 4. 查看远程仓库详细信息
# ============================================
demo "4. 查看远程仓库详细信息"
git remote show origin 2>/dev/null || echo -e "${YELLOW}需要网络连接才能查看远程仓库详细信息${NC}"
pause

# ============================================
# 5. 推送到远程仓库
# ============================================
demo "5. 推送本地代码到远程仓库"
echo -e "${YELLOW}注意：首次推送需要使用 -u 参数设置上游分支${NC}"
echo ""
echo "执行命令: git push -u origin main"
echo ""
echo -e "${RED}实际推送需要：${NC}"
echo "  1. 确保 GitHub 仓库已创建"
echo "  2. 配置了 Git 凭据（用户名/密码或 SSH 密钥）"
echo "  3. 有网络连接"
echo ""
echo -e "${YELLOW}这里我们只演示命令，不实际执行推送${NC}"
echo ""
echo "如果要实际推送，请运行："
echo "  git push -u origin main"
pause

# ============================================
# 6. 模拟远程有更新
# ============================================
demo "6. 从远程仓库拉取更新"
echo -e "${YELLOW}在实际协作中，其他人可能会推送新代码到远程仓库${NC}"
echo "你需要定期拉取更新："
echo ""
echo "执行命令: git pull origin main"
echo ""
echo -e "${YELLOW}这里我们只演示命令，不实际执行拉取${NC}"
echo ""
echo "如果要实际拉取，请运行："
echo "  git pull origin main"
pause

# ============================================
# 7. fetch vs pull 对比
# ============================================
demo "7. git fetch 和 git pull 的区别"
echo ""
echo -e "${BLUE}git fetch:${NC}"
echo "  - 只下载远程更新到本地"
echo "  - 不会自动合并到当前分支"
echo "  - 更安全，可以先查看更新内容"
echo "  - 命令: git fetch origin"
echo ""
echo -e "${BLUE}git pull:${NC}"
echo "  - 下载远程更新并自动合并"
echo "  - 相当于 git fetch + git merge"
echo "  - 更方便，但可能产生冲突"
echo "  - 命令: git pull origin main"
echo ""
pause

# ============================================
# 8. 推送分支
# ============================================
demo "8. 推送特定分支到远程"
echo "创建一个新分支并推送："
echo ""

# 创建演示分支
git switch -c demo-feature 2>/dev/null || git switch demo-feature
echo "已切换到 demo-feature 分支"
echo ""

# 做一些修改
echo "# Demo Feature" >> README.md
git add README.md
git commit -m "feat: 添加 demo feature 说明" 2>/dev/null || echo "已有提交"

echo ""
echo "推送分支到远程："
echo "  git push -u origin demo-feature"
echo ""
echo -e "${YELLOW}这里我们只演示命令，不实际执行推送${NC}"
pause

# 切换回 main
git switch main

# ============================================
# 9. 克隆远程仓库
# ============================================
demo "9. 克隆远程仓库"
echo "如果你想获取一个远程仓库的完整副本："
echo ""
echo "执行命令: git clone https://github.com/AJXGY/test1121.git"
echo ""
echo "这会："
echo "  1. 下载整个仓库到本地"
echo "  2. 自动配置远程仓库为 origin"
echo "  3. 自动切换到默认分支（通常是 main）"
pause

# ============================================
# 10. 协作工作流程
# ============================================
demo "10. 典型的协作工作流程"
echo ""
echo -e "${GREEN}步骤 1: 拉取最新代码${NC}"
echo "  git pull origin main"
echo ""
echo -e "${GREEN}步骤 2: 创建功能分支${NC}"
echo "  git switch -c feature-xxx"
echo ""
echo -e "${GREEN}步骤 3: 开发并提交${NC}"
echo "  # 编写代码..."
echo "  git add ."
echo "  git commit -m \"feat: 添加新功能\""
echo ""
echo -e "${GREEN}步骤 4: 推送到远程${NC}"
echo "  git push -u origin feature-xxx"
echo ""
echo -e "${GREEN}步骤 5: 在 GitHub 创建 Pull Request${NC}"
echo "  # 在 GitHub 网页上操作"
echo ""
echo -e "${GREEN}步骤 6: 代码审查后合并${NC}"
echo "  # 团队成员审查代码"
echo "  # 合并到 main 分支"
echo ""
echo -e "${GREEN}步骤 7: 删除本地和远程分支${NC}"
echo "  git branch -d feature-xxx"
echo "  git push origin --delete feature-xxx"
pause

# ============================================
# 11. 常见问题
# ============================================
demo "11. 远程协作常见问题"
echo ""
echo -e "${YELLOW}问题 1: push 被拒绝${NC}"
echo "  原因: 远程有新提交，你的本地版本落后了"
echo "  解决: git pull origin main，然后再 push"
echo ""
echo -e "${YELLOW}问题 2: 拉取时产生冲突${NC}"
echo "  原因: 你和别人修改了同一文件的同一位置"
echo "  解决: 手动解决冲突，然后提交"
echo ""
echo -e "${YELLOW}问题 3: 忘记设置上游分支${NC}"
echo "  原因: 首次推送没有使用 -u 参数"
echo "  解决: git push -u origin main"
echo ""
echo -e "${YELLOW}问题 4: 认证失败${NC}"
echo "  原因: GitHub 密码认证已废弃"
echo "  解决: 使用 Personal Access Token 或 SSH 密钥"
pause

# ============================================
# 12. 实用技巧
# ============================================
demo "12. 远程协作实用技巧"
echo ""
echo -e "${GREEN}技巧 1: 设置默认推送分支${NC}"
echo "  git config --global push.default current"
echo "  # 之后只需 git push，无需指定分支名"
echo ""
echo -e "${GREEN}技巧 2: 查看远程分支${NC}"
echo "  git branch -r          # 查看远程分支"
echo "  git branch -a          # 查看所有分支（本地+远程）"
echo ""
echo -e "${GREEN}技巧 3: 删除远程分支${NC}"
echo "  git push origin --delete branch-name"
echo ""
echo -e "${GREEN}技巧 4: 强制推送（危险！）${NC}"
echo "  git push -f origin main"
echo "  # 警告：会覆盖远程历史，谨慎使用！"
pause

# ============================================
# 总结
# ============================================
echo ""
echo "======================================"
echo -e "${GREEN}远程协作演示完成！${NC}"
echo "======================================"
echo ""
echo "你学会了："
echo "  ✓ git remote add - 添加远程仓库"
echo "  ✓ git remote -v - 查看远程仓库"
echo "  ✓ git push - 推送到远程"
echo "  ✓ git pull - 从远程拉取"
echo "  ✓ git fetch - 获取远程更新"
echo "  ✓ git clone - 克隆远程仓库"
echo ""
echo -e "${YELLOW}下一步操作：${NC}"
echo "  1. 在 GitHub 创建仓库: https://github.com/new"
echo "  2. 执行: git push -u origin main"
echo "  3. 在 GitHub 查看你的代码"
echo ""
echo -e "${BLUE}GitHub 仓库地址:${NC}"
echo "  https://github.com/AJXGY/test1121"
echo ""
