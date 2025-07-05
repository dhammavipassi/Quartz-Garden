#!/bin/bash

# === 本地预览脚本 ===
# 用法:
# ./preview.sh

# 默认使用 4000 端口进行预览
PORT=4000

# Git 仓库目录
REPO_DIR="/Users/dhammavipassi/Github_projects/Quartz-Garden"

# Quartz 子模块目录
QUARTZ_DIR="$REPO_DIR/quartz"

echo "👀 准备在端口 $PORT 上启动本地预览..."

# 1. 进入 Quartz 子模块目录
cd "$QUARTZ_DIR" || { echo "❌ 错误：无法进入 Quartz 子模块目录 $QUARTZ_DIR"; exit 1; }

# 2. 检查并安装依赖 (如果 node_modules 不存在)
if [ ! -d "node_modules" ]; then
  echo "📦 未找到 node_modules，正在安装依赖..."
  npm install
fi

# 3. 启动预览服务器
echo "🚀 启动预览服务器，请在浏览器中打开 http://localhost:$PORT"
npx quartz build -d ../content --serve --port "$PORT"
