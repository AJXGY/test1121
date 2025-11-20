#!/bin/bash

# ============================================
# Git 分支管理演示脚本
# 演示内容：分支创建、切换、合并、删除
# ============================================

echo "======================================"
echo "Git 分支管理演示"
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
# 1. 查看当前分支
# ============================================
demo "1. 查看所有分支"
git branch
pause

# ============================================
# 2. 创建新分支
# ============================================
demo "2. 创建新分支 feature-login"
git branch feature-login

echo -e "${GREEN}分支创建成功！${NC}"
git branch
pause

# ============================================
# 3. 切换分支
# ============================================
demo "3. 切换到 feature-login 分支"
git switch feature-login

echo -e "${GREEN}已切换到 feature-login 分支${NC}"
git branch
pause

# ============================================
# 4. 在新分支上开发
# ============================================
demo "4. 在 feature-login 分支上添加登录功能"

# 创建登录相关代码
cat >> app.js << 'EOF'

// 登录功能 - feature-login 分支添加
function login(username, password) {
    console.log('执行登录操作...');
    const result = validateLogin(username, password);
    
    if (result.success) {
        console.log('登录成功！');
        // 保存登录状态
        localStorage.setItem('isLoggedIn', 'true');
        localStorage.setItem('username', username);
    } else {
        console.log('登录失败：' + result.message);
    }
    
    return result;
}

// 登出功能
function logout() {
    localStorage.removeItem('isLoggedIn');
    localStorage.removeItem('username');
    console.log('已登出');
}
EOF

echo -e "${GREEN}登录功能代码已添加${NC}"
pause

demo "5. 提交更改"
git add app.js
git commit -m "feat: 添加用户登录和登出功能"

echo -e "${GREEN}提交成功！${NC}"
git log --oneline -3
pause

# ============================================
# 6. 切换回主分支
# ============================================
demo "6. 切换回 main 分支"
git switch main

echo -e "${GREEN}已切换回 main 分支${NC}"
echo ""
echo "注意：main 分支上没有登录功能的代码"
pause

# ============================================
# 7. 创建另一个分支
# ============================================
demo "7. 创建并切换到 feature-ui 分支"
git switch -c feature-ui

echo -e "${GREEN}已创建并切换到 feature-ui 分支${NC}"
pause

demo "8. 在 feature-ui 分支上修改样式"

# 添加新样式
cat >> style.css << 'EOF'

/* 登录表单样式 - feature-ui 分支添加 */
.login-form {
    max-width: 400px;
    margin: 2rem auto;
    padding: 2rem;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.login-form input {
    width: 100%;
    padding: 0.8rem;
    margin: 0.5rem 0;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.login-form button {
    width: 100%;
    margin-top: 1rem;
}
EOF

echo -e "${GREEN}UI 样式已添加${NC}"
pause

demo "9. 提交 UI 更改"
git add style.css
git commit -m "style: 添加登录表单样式"

echo -e "${GREEN}提交成功！${NC}"
pause

# ============================================
# 10. 合并分支
# ============================================
demo "10. 切换回 main 分支并合并 feature-login"
git switch main
pause

echo ""
echo "合并 feature-login 分支："
git merge feature-login

echo -e "${GREEN}feature-login 分支合并成功！${NC}"
pause

demo "11. 合并 feature-ui 分支"
git merge feature-ui

echo -e "${GREEN}feature-ui 分支合并成功！${NC}"
pause

# ============================================
# 12. 查看分支图
# ============================================
demo "12. 查看分支合并历史（图形化）"
git log --graph --oneline --all -10
pause

# ============================================
# 13. 删除已合并的分支
# ============================================
demo "13. 删除已合并的分支"
git branch -d feature-login
git branch -d feature-ui

echo -e "${GREEN}分支删除成功！${NC}"
echo ""
echo "当前分支列表："
git branch
pause

# ============================================
# 总结
# ============================================
echo ""
echo "======================================"
echo -e "${GREEN}分支管理演示完成！${NC}"
echo "======================================"
echo ""
echo "你学会了："
echo "  ✓ git branch - 查看和创建分支"
echo "  ✓ git switch - 切换分支"
echo "  ✓ git switch -c - 创建并切换分支"
echo "  ✓ git merge - 合并分支"
echo "  ✓ git branch -d - 删除分支"
echo "  ✓ git log --graph - 查看分支图"
echo ""
