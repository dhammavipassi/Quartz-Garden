#!/bin/bash

# === 配置 ===
# 源目录：您存放待发布文章的地方
SOURCE_DIR="/Users/dhammavipassi/Obsidian/00_Fleeting_notes/Publish"

# 目标目录：您的 Quartz Garden 项目的内容文件夹
DEST_DIR="/Users/dhammavipassi/Github_projects/Quartz-Garden/content"

# Git 仓库目录
REPO_DIR="/Users/dhammavipassi/Github_projects/Quartz-Garden"

# 提交信息
COMMIT_MESSAGE="feat: publish updates on $(date +'%Y-%m-%d %H:%M:%S')"

# === 脚本开始 ===
echo "🚀 开始一键发布您的数字花园..."

# 1. 同步文件
# 使用 rsync 来确保源和目标目录的完全同步
# --delete 选项会删除目标目录中多余的文件
echo "🔄 正在同步文章从源目录到目标目录..."
rsync -av --delete "$SOURCE_DIR/" "$DEST_DIR/"

# 2. 进入 Git 仓库目录
cd "$REPO_DIR" || { echo "❌ 错误：无法进入仓库目录 $REPO_DIR"; exit 1; }

# 3. 执行 Git 操作
echo "📦 正在将更改添加到 Git..."
git add .

# 检查是否有文件被暂存
if git diff-index --quiet HEAD --; then
    echo "✅ 内容没有变化，无需发布。"
    exit 0
fi

echo "📝 正在创建 Git 提交..."
git commit -m "$COMMIT_MESSAGE"

echo "📤 正在推送到 GitHub..."
git push

echo "🎉 发布完成！网站将在几分钟后更新。"