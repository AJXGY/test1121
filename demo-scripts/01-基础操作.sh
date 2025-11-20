#!/bin/bash

# ============================================
# Git 基础操作演示脚本
# 演示内容：工作区、暂存区、本地仓库操作
# ============================================

echo "======================================"
echo "Git 基础操作演示"
echo "======================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
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
# 1. 查看文件状态
# ============================================
demo "1. 查看当前 Git 仓库状态"
git status
pause

# ============================================
# 2. 修改文件并查看差异
# ============================================
demo "2. 修改 README.md 文件"
echo "" >> README.md
echo "## 更新日志" >> README.md
echo "- $(date '+%Y-%m-%d'): 添加更新日志部分" >> README.md

echo -e "${GREEN}文件已修改${NC}"
pause

demo "3. 查看文件状态（应该显示 README.md 被修改）"
git status
pause

demo "4. 查看具体修改内容"
git diff README.md
pause

# ============================================
# 3. 添加到暂存区
# ============================================
demo "5. 将修改添加到暂存区"
git add README.md

echo -e "${GREEN}文件已添加到暂存区${NC}"
pause

demo "6. 再次查看状态（应该显示绿色）"
git status
pause

demo "7. 查看暂存区的内容"
git diff --staged
pause

# ============================================
# 4. 提交到本地仓库
# ============================================
demo "8. 提交更改到本地仓库"
git commit -m "docs: 添加更新日志部分"

echo -e "${GREEN}提交成功！${NC}"
pause

demo "9. 查看提交历史"
git log --oneline -5
pause

# ============================================
# 5. 演示撤销操作
# ============================================
demo "10. 演示撤销工作区修改"
echo "这是一个测试修改" >> index.html
echo -e "${YELLOW}已修改 index.html${NC}"

echo ""
echo "查看状态："
git status

pause

echo ""
echo "撤销修改："
git restore index.html

echo -e "${GREEN}修改已撤销${NC}"
git status
pause

# ============================================
# 6. 演示从暂存区移除
# ============================================
demo "11. 演示从暂存区移除文件"
echo "测试内容" >> app.js
git add app.js

echo -e "${YELLOW}已将 app.js 添加到暂存区${NC}"
git status
pause

echo ""
echo "从暂存区移除："
git restore --staged app.js

echo -e "${GREEN}已从暂存区移除${NC}"
git status
pause

# 清理
git restore app.js

# ============================================
# 总结
# ============================================
echo ""
echo "======================================"
echo -e "${GREEN}基础操作演示完成！${NC}"
echo "======================================"
echo ""
echo "你学会了："
echo "  ✓ git status - 查看文件状态"
echo "  ✓ git diff - 查看文件差异"
echo "  ✓ git add - 添加到暂存区"
echo "  ✓ git commit - 提交到仓库"
echo "  ✓ git log - 查看提交历史"
echo "  ✓ git restore - 撤销修改"
echo ""
