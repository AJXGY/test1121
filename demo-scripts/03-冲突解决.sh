#!/bin/bash

# ============================================
# Git 冲突解决演示脚本
# 演示内容：制造冲突、查看冲突、解决冲突
# ============================================

echo "======================================"
echo "Git 冲突解决演示"
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
# 1. 准备：确保在 main 分支
# ============================================
demo "1. 确保在 main 分支"
git switch main
echo -e "${GREEN}当前在 main 分支${NC}"
pause

# ============================================
# 2. 在 main 分支修改文件
# ============================================
demo "2. 在 main 分支修改 validateLogin 函数"

# 备份原文件
cp app.js app.js.backup

# 修改 validateLogin 函数（版本1）
cat > temp_login.js << 'EOF'
// 用户登录验证函数 - main 分支版本
function validateLogin(username, password) {
    console.log('开始验证登录信息...');
    
    if (!username || !password) {
        return {
            success: false,
            message: '用户名和密码不能为空'
        };
    }
    
    // 增强的验证逻辑 - main 分支
    if (username.length < 5) {
        return {
            success: false,
            message: '用户名至少需要5个字符'  // main: 改为5个字符
        };
    }
    
    if (password.length < 8) {
        return {
            success: false,
            message: '密码至少需要8个字符'  // main: 改为8个字符
        };
    }
    
    console.log('验证通过！');
    return {
        success: true,
        message: '登录成功！'
    };
}
EOF

# 替换 validateLogin 函数
sed -i.bak '/^\/\/ 用户登录验证函数/,/^}$/d' app.js
cat temp_login.js >> app.js
rm temp_login.js

echo -e "${GREEN}main 分支：修改了密码验证规则（5个字符用户名，8个字符密码）${NC}"
pause

demo "3. 提交 main 分支的更改"
git add app.js
git commit -m "feat: 增强登录验证规则（main分支）"

echo -e "${GREEN}main 分支提交成功${NC}"
pause

# ============================================
# 4. 创建并切换到新分支
# ============================================
demo "4. 创建并切换到 feature-security 分支"

# 先回到修改前的状态
git reset --hard HEAD~1
cp app.js.backup app.js
rm app.js.backup

git switch -c feature-security

echo -e "${GREEN}已切换到 feature-security 分支${NC}"
pause

# ============================================
# 5. 在新分支修改同一位置
# ============================================
demo "5. 在 feature-security 分支修改 validateLogin 函数"

# 修改 validateLogin 函数（版本2 - 冲突版本）
cat > temp_login.js << 'EOF'
// 用户登录验证函数 - feature-security 分支版本
function validateLogin(username, password) {
    console.log('执行安全验证...');
    
    if (!username || !password) {
        return {
            success: false,
            message: '用户名和密码不能为空'
        };
    }
    
    // 安全增强的验证逻辑 - feature-security 分支
    if (username.length < 4) {
        return {
            success: false,
            message: '用户名至少需要4个字符'  // feature: 改为4个字符
        };
    }
    
    if (password.length < 10) {
        return {
            success: false,
            message: '密码至少需要10个字符，并包含特殊字符'  // feature: 改为10个字符
        };
    }
    
    // 检查密码复杂度
    if (!/[!@#$%^&*]/.test(password)) {
        return {
            success: false,
            message: '密码必须包含特殊字符'
        };
    }
    
    console.log('安全验证通过！');
    return {
        success: true,
        message: '登录成功！'
    };
}
EOF

sed -i.bak '/^\/\/ 用户登录验证函数/,/^}$/d' app.js
cat temp_login.js >> app.js
rm temp_login.js
rm app.js.bak 2>/dev/null

echo -e "${GREEN}feature-security 分支：修改了密码验证规则（4个字符用户名，10个字符密码+特殊字符）${NC}"
pause

demo "6. 提交 feature-security 分支的更改"
git add app.js
git commit -m "feat: 添加密码复杂度验证（feature-security分支）"

echo -e "${GREEN}feature-security 分支提交成功${NC}"
pause

# ============================================
# 7. 尝试合并 - 产生冲突
# ============================================
demo "7. 切换回 main 分支"
git switch main
pause

demo "8. 尝试合并 feature-security 分支（会产生冲突）"
echo -e "${YELLOW}注意：这里会产生冲突！${NC}"
pause

git merge feature-security || true

echo ""
echo -e "${RED}合并冲突！${NC}"
echo ""
pause

# ============================================
# 9. 查看冲突
# ============================================
demo "9. 查看冲突状态"
git status
pause

demo "10. 查看冲突文件内容"
echo -e "${YELLOW}冲突标记说明：${NC}"
echo "  <<<<<<< HEAD        - 当前分支（main）的内容"
echo "  =======             - 分隔符"
echo "  >>>>>>> feature-security - 要合并的分支的内容"
echo ""
pause

echo "冲突文件内容："
cat app.js | grep -A 30 "<<<<<<< HEAD" || echo "查看完整文件："
cat app.js
pause

# ============================================
# 11. 解决冲突（自动）
# ============================================
demo "11. 解决冲突"
echo -e "${YELLOW}在实际操作中，你需要手动编辑文件，删除冲突标记，保留需要的代码${NC}"
echo ""
echo "这里我们自动解决冲突，保留 feature-security 分支的更严格验证..."
pause

# 自动解决冲突：保留 feature-security 的版本
cat > temp_login.js << 'EOF'
// 用户登录验证函数 - 合并后的版本（保留更严格的验证）
function validateLogin(username, password) {
    console.log('执行安全验证...');
    
    if (!username || !password) {
        return {
            success: false,
            message: '用户名和密码不能为空'
        };
    }
    
    // 合并后的验证逻辑：采用更严格的规则
    if (username.length < 4) {
        return {
            success: false,
            message: '用户名至少需要4个字符'
        };
    }
    
    if (password.length < 10) {
        return {
            success: false,
            message: '密码至少需要10个字符，并包含特殊字符'
        };
    }
    
    // 检查密码复杂度
    if (!/[!@#$%^&*]/.test(password)) {
        return {
            success: false,
            message: '密码必须包含特殊字符'
        };
    }
    
    console.log('安全验证通过！');
    return {
        success: true,
        message: '登录成功！'
    };
}
EOF

# 移除冲突的部分，保留解决后的版本
sed -i.bak '/^<<<<<<< HEAD$/,/^>>>>>>> feature-security$/d' app.js
cat temp_login.js >> app.js
rm temp_login.js
rm app.js.bak 2>/dev/null

echo -e "${GREEN}冲突已解决！${NC}"
pause

# ============================================
# 12. 标记冲突已解决并完成合并
# ============================================
demo "12. 标记冲突已解决"
git add app.js

echo -e "${GREEN}已标记 app.js 为已解决${NC}"
git status
pause

demo "13. 完成合并提交"
git commit -m "Merge branch 'feature-security' - 采用更严格的密码验证规则"

echo -e "${GREEN}合并完成！${NC}"
pause

# ============================================
# 14. 查看合并历史
# ============================================
demo "14. 查看合并后的历史"
git log --graph --oneline --all -10
pause

# ============================================
# 15. 清理
# ============================================
demo "15. 删除 feature-security 分支"
git branch -d feature-security

echo -e "${GREEN}分支已删除${NC}"
pause

# ============================================
# 总结
# ============================================
echo ""
echo "======================================"
echo -e "${GREEN}冲突解决演示完成！${NC}"
echo "======================================"
echo ""
echo "你学会了："
echo "  ✓ 理解什么时候会产生冲突"
echo "  ✓ 识别冲突标记（<<<<<<< ======= >>>>>>>）"
echo "  ✓ 手动编辑文件解决冲突"
echo "  ✓ 使用 git add 标记冲突已解决"
echo "  ✓ 使用 git commit 完成合并"
echo ""
echo -e "${YELLOW}重要提示：${NC}"
echo "  - 冲突是正常的，不要害怕"
echo "  - 仔细查看冲突内容，理解两个版本的差异"
echo "  - 保留正确的代码，删除冲突标记"
echo "  - 测试解决后的代码是否正常工作"
echo ""
