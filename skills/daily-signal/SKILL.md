---
name: daily-signal
description: |
  Daily Signal（每日信号）— Windeye 系统的每日简报组件。读取活跃的 Focus 条目，发现新信息，生成每日信号。触发词："生成信号"、"每日简报"、"今日发现"、"daily signal".
version: 1.0.0
---

# Daily Signal（每日信号）

Daily Signal 是 Windeye 系统的每日简报组件。

## 核心目标

从 Focus（关注点）中发现新信息，生成 Signal（信号），为决策提供支持。

## 工作流程

```
读取活跃的 Focus 条目（Insight Hub）
           ↓
    对每个 Focus：
    ├── 访问 source_url
    ├── AI 分析内容
    ├── 判断是否有新发现
    └── 有 → 生成信号片段
           ↓
    汇总所有信号片段
           ↓
    生成 Daily Signal
           ↓
    存储到 Insight Hub
           ↓
    同步到本地文件
```

## 命令

### 信号生成（Signal Generate）

生成每日信号。

**触发**：用户请求生成信号

**工作流**：

1. **获取 Focus 条目**
   - 调用 `GET http://localhost:8090/api/v1/items?type=focus&status=active`
   - 获取所有活跃的 Focus 条目

2. **处理每个 Focus**
   - 对于有 `source_url` 的 Focus：
     - 使用 GitHub API 或 web_fetch 获取内容
     - AI 分析：「自上次检查以来是否有新发现？」
     - 有：生成信号片段

3. **汇总信号**
   - 合并所有信号片段
   - 添加元数据（日期、focus 数量、来源）

4. **存储信号**
   - 调用 `POST http://localhost:8090/api/v1/items`
   - type: `signal`
   - source_system: `windeye`
   - source_agent: `daily-signal`

5. **同步本地**
   - 写入 `/Users/wh/.openclaw/workspace-tech-doc/memory/reports/signals/YYYY-MM-DD.md`

**输出**：Signal ID 和摘要

---

### 信号列表（Signal List）

列出最近的信号。

**工作流**：
1. 调用 `GET http://localhost:8090/api/v1/items?type=signal&limit=10`
2. 格式化为表格视图

---

## 数据结构

```json
{
  "type": "signal",
  "source_system": "windeye",
  "source_agent": "daily-signal",
  "title": "每日信号 2026-03-06",
  "content": "今日发现：\n1. llm-d v0.5.1 发布...\n2. vLLM 新增功能...",
  "occurred_at": "2026-03-06T00:00:00Z",
  "metadata": {
    "focus_count": 5,
    "discovery_count": 3,
    "sources": ["github.com/llm-d/llm-d", "github.com/vllm-project/vllm"]
  }
}
```

## ID 格式

```
windeye:signal:YYYY-MM-DD

示例：
- windeye:signal:2026-03-06
- windeye:signal:2026-03-07
```

## 错误处理

| 错误 | 处理 |
|------|------|
| 无活跃 Focus | 报告「无活跃的关注点」 |
| Insight Hub 不可用 | 中止并报错 |
| source_url 无法访问 | 跳过该 Focus，继续处理其他 |
| 无发现 | 生成空信号并说明 |

## 资源

- [信号模板](resources/template.md)
- [Focus 处理指南](resources/focus-processing.md)
