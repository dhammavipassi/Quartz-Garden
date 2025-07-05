---
dg-publish: true
dg-home: true
---


### **基于 `sosiristseng/template-quartz` 的数字花园完整部署与使用指南**

本指南将带您从零开始，建立一个功能强大、易于维护的个人数字花园，并为您配置好一键发布和本地预览的自动化流程。

---

### **第一部分：首次安装与设置**

这部分操作仅需在初次建立网站时执行一次。

**步骤 1：克隆项目模板**

首先，我们需要将社区优化版的 Quartz 模板完整地克隆到您的电脑上。请打开终端执行以下命令：

```bash
# 在您的项目文件夹中，克隆模板并命名为 "Quartz-Garden"
# --recursive 参数至关重要，它会确保核心功能被一并下载
git clone --recursive https://github.com/sosiristseng/template-quartz.git /Users/dhammavipassi/Github_projects/Quartz-Garden
```

**步骤 2：创建 GitHub 仓库**

您需要在您的 GitHub 账户上创建一个新的、**空的**仓库，用于存放您的网站。
*   **仓库名称**: `Quartz-Garden` (建议与本地文件夹同名)
*   **仓库类型**: Public (公开)

**步骤 3：本地配置与关联**

进入新克隆的项目目录，并进行一系列初始化配置。

```bash
cd /Users/dhammavipassi/Github_projects/Quartz-Garden
```

1.  **修改网站配置 (`quartz.config.ts`)**:
    *   将 `pageTitle` 修改为您的网站名称。
    *   将 `baseUrl` 修改为您的 GitHub Pages 地址（**注意：不要加 `https://`**）。
    *   将 `locale` 修改为 `zh-CN`。

2.  **修改内部端口 (`quartz/quartz/cli/args.js`)**:
    *   为了避免端口冲突，我们将内部 WebSocket 端口从 `3001` 修改为 `8888`。

3.  **关联远程仓库**:
    *   将您本地的项目与您在 GitHub 上创建的新仓库关联起来。
    ```bash
    # 移除模板自带的旧链接
    git remote remove origin
    # 添加指向您自己仓库的新链接
    git remote add origin https://github.com/dhammavipassi/Quartz-Garden.git
    ```

**步骤 4：首次推送**

将您本地配置好的项目首次推送到 GitHub。

```bash
# 将所有文件添加到暂存区
git add .
# 创建一个初始提交
git commit -m "feat: initial setup of the digital garden"
# 推送到 main 分支
git push -u origin main
```

**步骤 5：设置 GitHub Pages**

这是在线部署的最后一步。
1.  访问您的新仓库设置页面: `https://github.com/dhammavipassi/Quartz-Garden/settings/pages`
2.  在 **"Build and deployment"** 部分，将 **"Source"** 选项从 "Deploy from a branch" 更改为 **"GitHub Actions"**。

至此，您的网站基础框架已经搭建完成并已开始首次部署。

---

### **第二部分：配置自动化脚本**

为了简化您的日常操作，我们创建了两个脚本。

**步骤 1：创建 `publish.sh` (一键发布脚本)**

这个脚本能将您在 Obsidian 中写好的文章一键发布到线上。

*   **文件路径**: `/Users/dhammavipassi/Github_projects/Quartz-Garden/publish.sh`
*   **功能**: 自动同步文章、提交代码并推送到 GitHub。

**步骤 2：创建 `preview.sh` (本地预览脚本)**

这个脚本能让您在发布前，先在自己电脑上预览网站效果。

*   **文件路径**: `/Users/dhammavipassi/Github_projects/Quartz-Garden/preview.sh`
*   **功能**: 在固定的 `4000` 端口启动一个本地预览服务器。

**步骤 3：为脚本添加执行权限**

在终端中运行以下命令，使这两个脚本可以被执行：

```bash
chmod +x /Users/dhammavipassi/Github_projects/Quartz-Garden/publish.sh
chmod +x /Users/dhammavipassi/Github_projects/Quartz-Garden/preview.sh
```

---

### **第三部分：您的最终工作流程**

在完成以上所有设置后，您未来的日常操作将变得极其简单。

1.  **写作**:
    *   在您的 Obsidian 中，将任何您想发布的文章放入或移动到 `/Users/dhammavipassi/Obsidian/00_Fleeting_notes/Publish` 文件夹。

2.  **本地预览 (可选)**:
    *   想在发布前先看看效果？打开终端，执行命令：
        ```bash
        /Users/dhammavipassi/Github_projects/Quartz-Garden/preview.sh
        ```
    *   在浏览器中打开 `http://localhost:4000` 即可预览。预览结束后，在终端按 `Ctrl + C` 停止。

3.  **一键发布**:
    *   对预览效果满意后，或想直接发布时，打开终端，执行命令：
        ```bash
        /Users/dhammavipassi/Github_projects/Quartz-Garden/publish.sh
        ```

