# Git 演示项目

这个项目用于 Git 版本控制系统入门课程的实战演示。

## 📁 项目结构

```
test1121/
├── README.md                    # 本文件
├── .gitignore                   # Git 忽略文件配置
├── demo-scripts/                # 演示脚本文件夹
│   ├── 01-基础操作.sh           # 基础 Git 操作演示
│   ├── 02-分支管理.sh           # 分支创建、切换、合并演示
│   ├── 03-冲突解决.sh           # 冲突场景演示
│   └── 04-远程协作.sh           # GitHub 推送拉取演示
├── index.html                   # 示例网页文件
├── app.js                       # 示例 JavaScript 文件
└── style.css                    # 示例 CSS 文件
```

## 🎯 使用说明

### 1. 初始化仓库
```bash
cd test1121
git init
git add .
git commit -m "Initial commit"
```

### 2. 连接到 GitHub
```bash
git remote add origin https://github.com/AJXGY/test1121.git
git push -u origin main
```

### 3. 运行演示脚本
```bash
# 基础操作演示
bash demo-scripts/01-基础操作.sh

# 分支管理演示
bash demo-scripts/02-分支管理.sh

# 冲突解决演示
bash demo-scripts/03-冲突解决.sh

# 远程协作演示
bash demo-scripts/04-远程协作.sh
```

## 📚 演示脚本说明

### 01-基础操作.sh
演示内容：
- 查看文件状态 (`git status`)
- 查看文件差异 (`git diff`)
- 添加文件到暂存区 (`git add`)
- 提交更改 (`git commit`)
- 查看提交历史 (`git log`)

### 02-分支管理.sh
演示内容：
- 创建分支 (`git branch`)
- 切换分支 (`git switch`)
- 合并分支 (`git merge`)
- 删除分支 (`git branch -d`)

### 03-冲突解决.sh
演示内容：
- 制造合并冲突
- 查看冲突文件
- 手动解决冲突
- 完成合并

### 04-远程协作.sh
演示内容：
- 添加远程仓库 (`git remote add`)
- 推送到远程 (`git push`)
- 从远程拉取 (`git pull`)
- 查看远程仓库 (`git remote -v`)

## 🎓 学习建议

1. **按顺序学习**：从 01 到 04 依次学习
2. **动手实践**：不要只看，要自己敲命令
3. **理解原理**：每个命令背后的原理要理解
4. **多次练习**：重复练习直到熟练

## 📖 相关资源

- [Git 官方文档](https://git-scm.com/doc)
- [GitHub 官方教程](https://docs.github.com/cn)
- [Learn Git Branching](https://learngitbranching.js.org/)
- [Pro Git 电子书](https://git-scm.com/book/zh/v2)

## 👨‍🏫 讲师信息

**讲师：** 储李节  
**课程：** Git 版本控制系统入门  
**时长：** 约 60 分钟

---

**祝学习愉快！🎉**
