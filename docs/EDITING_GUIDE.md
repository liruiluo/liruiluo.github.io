# 个人站点维护速记（面向“好改+可视化”）

> 目标：你只需要记住“常改的 5 个文件夹/文件”，其余都当主题代码，不用碰。

## 一键预览（推荐）

```bash
./bin/dev
```

- 如果你装了 Docker：会优先使用 `docker compose up` / `docker-compose up`；如果都没有，会自动 `docker build` + `docker run`（端口 `8080`），浏览器打开 `http://localhost:8080`。
- 如果没装 Docker：会退回到本机 `bundle exec jekyll serve ...`（同样 `8080`）。
- 为了让本地预览更快，`./bin/dev` 会自动叠加 `_config.dev.yml`（比如关闭外部 RSS 拉取、关闭 WebP 生成等）；线上部署仍以 `_config.yml` 为准。

如果你修改了 `Dockerfile`/`Gemfile` 这类依赖相关文件，可以用：

```bash
./bin/dev --build
```

## 最常改的内容在哪里

### 1) 首页 / About

- `/_pages/about.md`
  - `permalink: /` 表示它就是首页
  - `subtitle:`、正文、以及 `news/selected_papers/social` 开关都在这里

### 2) Publications（论文列表）

- `/_bibliography/papers.bib`
  - 每条 BibTeX 就是一篇论文
  - `selected={true}` 会出现在首页的 “selected papers”
  - `preview={xxx.png}` 对应论文缩略图
- `/assets/img/publication_preview/`
  - 放 `preview` 引用的图片

### 3) News（首页的 news 列表）

- `/_news/*.md`
  - `inline: true` 表示直接显示正文，不需要点进去
  - `date:` 控制时间顺序

### 4) Blog / Experiences（首页 experiences）

- `/_posts/*.md`
  - 新增一篇文章：新建一个 Markdown 文件（推荐命名 `YYYY-MM-DD-title.md`）
  - `title/date/tags/categories` 都在 front matter 里

### 5) 全局配置（导航、开关、链接等）

- `/_config.yml`
  - 站点 URL、姓名、社交账号、功能开关都在这里
  - `collections:` 定义 `news/projects` 等集合

## “我想加一个新页面到导航栏”

1. 在 `/_pages/` 新建 `xxx.md`
2. 写 front matter（最小示例）：

```yaml
---
layout: page
title: xxx
permalink: /xxx/
nav: true
nav_order: 3
---
```

## “我想改样式（颜色/字号/布局）”

通常只需要从这两个地方开始：

- `/_sass/_variables.scss`（变量、颜色、间距等）
- `/_sass/_themes.scss`（亮/暗主题相关）

## 建议的“降复杂度”方式（不改主题源码）

1. 只把上面 5 个入口当作“你的内容区”，其他文件夹先不动。
2. 把不需要的示例内容/大文件删掉（示例 projects、示例媒体文件、示例预览图等），站点会立刻清爽很多。
3. 每次改动都用 `./bin/dev` 预览，确保“改哪里→立刻看到”。
