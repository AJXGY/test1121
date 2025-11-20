// Git 演示项目 - JavaScript 文件

// 显示欢迎消息
function showMessage() {
    const messageDiv = document.getElementById('message');
    messageDiv.innerHTML = '<p class="success">✓ 恭喜！你成功触发了一个 JavaScript 函数！</p>';
    messageDiv.style.display = 'block';
    
    // 3秒后隐藏消息
    setTimeout(() => {
        messageDiv.style.display = 'none';
    }, 3000);
}

// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    console.log('Git 演示项目已加载');
    console.log('这个文件用于演示 Git 的版本控制功能');
});

// 用户登录验证函数（用于演示分支合并冲突）
function validateLogin(username, password) {
    if (!username || !password) {
        return {
            success: false,
            message: '用户名和密码不能为空'
        };
    }
    
    // 简单的验证逻辑
    if (username.length < 3) {
        return {
            success: false,
            message: '用户名至少需要3个字符'
        };
    }
    
    if (password.length < 6) {
        return {
            success: false,
            message: '密码至少需要6个字符'
        };
    }
    
    return {
        success: true,
        message: '登录成功！'
    };
}

// 导出函数（用于模块化演示）
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        showMessage,
        validateLogin
    };
}
