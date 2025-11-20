测试内容
测试内容

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
