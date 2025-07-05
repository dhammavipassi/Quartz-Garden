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

# 1. 移动文件（避免重复）
echo "🔄 正在移动文章从Obsidian到Quartz Garden..."

# 检查源目录是否存在且不为空
if [ ! -d "$SOURCE_DIR" ] || [ -z "$(ls -A "$SOURCE_DIR" 2>/dev/null)" ]; then
    echo "⚠️  源目录不存在或为空：$SOURCE_DIR"
    exit 0
fi

# 确保目标目录存在
mkdir -p "$DEST_DIR"

# 移动所有文件到目标目录
echo "📁 移动文件..."
mv "$SOURCE_DIR"/* "$DEST_DIR/" 2>/dev/null || {
    echo "⚠️  没有文件需要移动，或移动失败"
    exit 0
}

echo "✅ 文件移动完成，Obsidian中的Publish文件夹现已清空"

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