# Windeye（风眼）

> AI 时代的信息感知系统

---

## 简介

Windeye（风眼）是一个 AI 驱动的信息感知系统，帮助你从海量信息中提取有价值的内容。

**核心理念**：
- 人定义问题（Focus）
- AI 发现问题（Daily Signal）
- AI 挖掘价值（Insight）
- 人做决策

---

## 系统架构

```
Windeye（风眼）
├── Wind Radar（风雷达）— 追踪组件，记录"我关注什么"
├── Daily Signal（每日信号）— 简报组件，发现新信息
├── Insight（洞察）— 提炼组件，挖掘价值
└── Insight Hub — 数据组件，存储与检索
```

详见 [docs/architecture.md](docs/architecture.md)

---

## 组件

### Insight Hub（数据层）

数据存储与检索服务，提供 REST API。

**仓库**：[github.com/kitsnail/insight-hub](https://github.com/kitsnail/insight-hub)

**数据类型**：
| type | 中文名 | 说明 |
|------|--------|------|
| `focus` | 关注点 | 追踪主题 |
| `signal` | 信号 | 每日简报 |
| `tracking` | 追踪记录 | 趋势/前沿/问题/洞察/结论 |

### Wind Radar（风雷达）

OpenClaw Skill，记录和追踪关注点。

### Daily Signal（每日信号）

OpenClaw Skill，自动检测关注点的更新并生成信号。

---

## 快速开始

### 1. 启动 Insight Hub

Insight Hub 位于独立仓库：`/Users/wh/data/worklib/src/github.com/kitsnail/insight-hub`

```bash
cd /Users/wh/data/worklib/src/github.com/kitsnail/insight-hub
docker-compose up -d
```

### 2. 配置 OpenClaw Skills

Skills 位于 `skills/` 目录，复制到 `~/.agents/skills/` 即可使用。

---

## 项目结构

```
windeye/
├── README.md                 # 本文档
├── docs/                     # 文档
│   ├── architecture.md       # 架构设计
│   └── naming.md             # 命名体系
├── insight-hub/              # Insight Hub 服务
│   ├── api/                  # API 后端
│   ├── db/                   # 数据库
│   └── web/                  # Web UI 前端
├── skills/                   # OpenClaw Skills
│   ├── wind-radar/           # 风雷达
│   └── daily-signal/         # 每日信号
└── scripts/                  # 管理脚本
    ├── sync.sh               # 同步
    └── deploy.sh             # 部署
```

---

## 版本历史

| 版本 | 日期 | 说明 |
|------|------|------|
| v0.1.0 | 2026-03-06 | 初始版本，整合 Insight Hub + Skills |

---

## License

MIT
