---
name: insight
description: |
  Insight（洞察）— Windeye 系统的价值挖掘组件。从 Signal 和 Tracking 中提炼洞察、识别趋势、发现问题、生成结论。触发词："挖掘洞察"、"分析趋势"、"生成结论"、"insight".
version: 1.0.0
---

# Insight（洞察）

Insight 是 Windeye 系统的价值挖掘组件，回答"对我有什么影响"。

## 核心目标

从 Signal（每日信号）和 Tracking（追踪记录）中挖掘价值，辅助决策。

## 工作流程

```
读取近期 Signal（Insight Hub）
           ↓
    读取 Tracking 记录
           ↓
    AI 深度分析：
    ├── 识别趋势（Trend）
    ├── 发现问题（Question）
    ├── 提炼洞察（Insight）
    └── 生成结论（Conclusion）
           ↓
    存储到 Insight Hub
           ↓
    同步到本地文件
```

## 命令

### 洞察生成（Insight Generate）

从近期信号中挖掘洞察。

**触发**：用户请求挖掘洞察

**工作流**：

1. **获取近期 Signal**
   - 调用 `GET http://localhost:8090/api/v1/items?type=signal&limit=7`
   - 获取近 7 天的信号

2. **获取 Tracking 记录**
   - 调用 `GET http://localhost:8090/api/v1/items?type=tracking&status=active&limit=50`

3. **AI 深度分析**
   - 识别重复出现的主题 → Trend（趋势）
   - 发现待解决的问题 → Question（问题）
   - 提炼有价值的发现 → Insight（洞察）
   - 生成可操作的建议 → Conclusion（结论）

4. **存储结果**
   - 对每条发现，调用 `POST http://localhost:8090/api/v1/items`
   - type: `tracking`
   - category: `trend|question|insight|conclusion`

5. **同步本地**
   - 写入 `/Users/wh/.openclaw/workspace-tech-doc/memory/tracking/`

**输出**：生成的条目数量和摘要

---

### 趋势识别（Trend Identify）

识别长期方向性变化。

**触发**：用户请求识别趋势

**工作流**：

1. 获取近 30 天的 Signal 和 Tracking
2. 分析重复出现的主题和模式
3. 识别方向性变化
4. 生成 Trend 条目

---

### 问题发现（Question Discover）

发现待解决的问题。

**触发**：用户请求发现问题

**工作流**：

1. 分析 Signal 中的技术动态
2. 结合用户 Focus 判断潜在问题
3. 生成 Question 条目

---

### 结论生成（Conclusion Generate）

生成可操作的建议。

**触发**：用户请求生成结论

**工作流**：

1. 汇总近期的 Trend、Insight
2. 结合用户 Focus 判断行动方向
3. 生成 Conclusion 条目

---

## 数据结构

### Trend（趋势）

```json
{
  "type": "tracking",
  "category": "trend",
  "title": "LLM 推理框架进入场景分化阶段",
  "content": "llm-d 和 vLLM 都在分布式推理上发力，但侧重点不同...",
  "metadata": {
    "domain": "technology",
    "intensity": "high",
    "value": "high",
    "value_proposition": "选型时需关注场景适配度",
    "related_signals": ["windeye:signal:2026-03-06"],
    "time_scope": "近 30 天"
  },
  "status": "active"
}
```

### Question（问题）

```json
{
  "type": "tracking",
  "category": "question",
  "title": "如何选择 LLM 推理框架？",
  "content": "llm-d vs vLLM vs LMDeploy，各有什么优劣势？",
  "metadata": {
    "domain": "technology",
    "intensity": "medium",
    "value": "high",
    "value_proposition": "需要根据场景选择",
    "related_trends": ["windeye:tracking:trend:xxx"]
  },
  "status": "active"
}
```

### Insight（洞察）

```json
{
  "type": "tracking",
  "category": "insight",
  "title": "选型逻辑从「谁更快」转向「谁更适合」",
  "content": "性能差异缩小后，场景适配度成为关键...",
  "metadata": {
    "domain": "technology",
    "intensity": "high",
    "value": "high",
    "value_proposition": "改变选型思路",
    "related_trends": ["windeye:tracking:trend:xxx"],
    "related_questions": ["windeye:tracking:question:xxx"]
  },
  "status": "active"
}
```

### Conclusion（结论）

```json
{
  "type": "tracking",
  "category": "conclusion",
  "title": "推荐：根据场景选择推理框架",
  "content": "吞吐优先选 LMDeploy，分布式推理选 llm-d，通用场景选 vLLM",
  "metadata": {
    "domain": "technology",
    "intensity": "high",
    "value": "high",
    "value_proposition": "指导选型决策",
    "related_insights": ["windeye:tracking:insight:xxx"],
    "actionable": true,
    "action_items": [
      "评估当前场景需求",
      "测试候选框架性能",
      "做出选型决策"
    ]
  },
  "status": "active"
}
```

## ID 格式

```
windeye:tracking:{category}:{timestamp}-{slug}

示例：
- windeye:tracking:trend:20260306-llm-framework-evolution
- windeye:tracking:insight:20260306-selection-logic-shift
- windeye:tracking:conclusion:20260306-framework-selection-guide
```

## 分析提示词

### 趋势识别

```
你正在分析近期的技术信号，识别趋势。

信号列表：
{signals}

请分析：
1. 有哪些重复出现的主题？
2. 有哪些方向性变化？
3. 对用户有什么潜在影响？

输出格式：
- 趋势名称
- 证据（来自哪些信号）
- 影响分析
- 建议关注程度
```

### 洞察提炼

```
你正在从信号和趋势中提炼洞察。

信号：{signals}
趋势：{trends}

请分析：
1. 这些信息揭示了什么？
2. 对用户的认知有什么改变？
3. 有什么反直觉的发现？

输出格式：
- 洞察内容
- 证据链
- 价值主张
```

### 结论生成

```
你正在基于洞察生成可操作的建议。

洞察：{insights}
用户关注点：{focuses}

请分析：
1. 用户应该采取什么行动？
2. 优先级如何？
3. 预期效果是什么？

输出格式：
- 结论内容
- 行动步骤
- 预期效果
- 风险提示
```

## 错误处理

| 错误 | 处理 |
|------|------|
| 无近期 Signal | 提示「先运行 Daily Signal」 |
| Insight Hub 不可用 | 中止并报错 |
| 分析失败 | 记录错误，继续处理其他 |

## 资源

- [分析模板](resources/analysis-template.md)
- [价值评估指南](resources/value-guide.md)
