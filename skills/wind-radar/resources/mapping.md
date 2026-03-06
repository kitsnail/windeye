# Insight Hub Field Mapping

## Windeye Data Types

| Type | Chinese | Description |
|------|---------|-------------|
| `focus` | 关注点 | 追踪主题 |
| `signal` | 信号 | 每日简报 |
| `tracking` | 追踪记录 | 趋势/前沿/问题/洞察/结论 |

---

## Focus (关注点) Mapping

| Windeye Field | Insight Hub Field | Notes |
|---------------|-------------------|-------|
| title | `title` | 关注点标题 |
| content | `content` | 关注点描述 |
| source_url | `source_url` | 信息来源 URL |
| status | `status` | active/paused/archived |

**Required Fields**:

| Field | Required | Default |
|-------|----------|---------|
| `type` | ✅ | "focus" |
| `title` | ✅ | - |
| `source_system` | ✅ | "windeye" |
| `source_agent` | ✅ | "wind-radar" |
| `status` | ✅ | "active" |

**Example Focus Item**:
```json
{
  "id": "windeye:focus:20260306-llm-d-dynamics",
  "type": "focus",
  "source_system": "windeye",
  "source_agent": "wind-radar",
  "title": "llm-d 发展动态",
  "content": "持续关注 llm-d 分布式推理项目的发展动态",
  "source_url": "https://github.com/llm-d/llm-d/releases",
  "status": "active",
  "created_at": "2026-03-06T06:00:00Z"
}
```

---

## Signal (信号) Mapping

| Windeye Field | Insight Hub Field | Notes |
|---------------|-------------------|-------|
| date | `occurred_at` | 简报日期 |
| title | `title` | 简报标题 |
| content | `content` | 简报内容 |
| focus_ids | `metadata.focus_ids` | 相关关注点 ID |

**Required Fields**:

| Field | Required | Default |
|-------|----------|---------|
| `type` | ✅ | "signal" |
| `occurred_at` | ✅ | - |
| `source_system` | ✅ | "windeye" |
| `source_agent` | ✅ | "daily-signal" |

**Example Signal Item**:
```json
{
  "id": "windeye:signal:2026-03-06",
  "type": "signal",
  "source_system": "windeye",
  "source_agent": "daily-signal",
  "title": "2026-03-06 技术信号",
  "content": "今日发现：llm-d v0.5.1 发布...",
  "occurred_at": "2026-03-06T00:00:00Z",
  "metadata": {
    "focus_ids": ["windeye:focus:20260306-llm-d-dynamics"]
  }
}
```

---

## Tracking (追踪记录) Mapping

| Windeye Field | Insight Hub Field | Notes |
|---------------|-------------------|-------|
| category | `category` | trend/frontier/question/insight/conclusion |
| title | `title` | 标题 |
| content | `content` | 内容摘要（≤200字） |
| domain | `metadata.domain` | technology/society/economy |
| intensity | `metadata.intensity` | high/medium/low |
| value | `metadata.value` | high/medium/low |
| value_proposition | `metadata.value_proposition` | 价值主张 |
| status | `status` | active/verified/archived |

**Required Fields**:

| Field | Required | Default |
|-------|----------|---------|
| `type` | ✅ | "tracking" |
| `category` | ✅ | - |
| `source_system` | ✅ | "windeye" |

**ID Format**:
```
windeye:tracking:{category}:{timestamp}-{slug}

Examples:
- windeye:tracking:trend:20260304-llm-framework-evolution
- windeye:tracking:frontier:20260305-llm-d-v0.5.0
```

---

## API Endpoints

| Action | Method | Endpoint |
|--------|--------|----------|
| Create | POST | `http://localhost:8090/api/v1/items` |
| Read | GET | `http://localhost:8090/api/v1/items/{id}` |
| List | GET | `http://localhost:8090/api/v1/items` |
| Update | PUT | `http://localhost:8090/api/v1/items/{id}` |
| Delete | DELETE | `http://localhost:8090/api/v1/items/{id}` |
| Check Duplicate | POST | `http://localhost:8090/api/v1/items/check-duplicate` |
