---
name: wind-radar
description: |
  Wind Radar (风雷达) - Focus tracking component of Windeye system. Use when user wants to create focus (追踪主题), query focus, update or delete focus entries. Triggers: "追踪", "创建关注点", "查一下关注", "风雷达里有什么", "更新追踪", "删除追踪".
version: 1.1.0
---

# Wind Radar (风雷达)

Wind Radar is the focus tracking component of Windeye system. It helps capture and manage what the user wants to pay attention to.

## Core Concepts

| Concept | Chinese | Description |
|---------|---------|-------------|
| **Focus** | 关注点 | What the user wants to track |
| **Signal** | 信号 | Daily briefing output |
| **Tracking** | 追踪记录 | Trend/Frontier/Question/Insight/Conclusion |

## Commands

### Focus Add

Create a new focus entry.

**Trigger**: User provides information to track

**Workflow**:

1. **Understand Intent** - What does the user want to track?
2. **Create Focus** - Generate focus entry
   - title: What to track
   - content: Description of the focus
   - source_url: Where to check for updates
   - status: active
3. **Store** - Write to Insight Hub API
   - Endpoint: `POST http://localhost:8090/api/v1/items`
   - type: `focus`
4. **Sync** - Append to local file
   - Path: `/Users/wh/.openclaw/workspace-tech-doc/memory/tracking/focus.md`

**Output**: Confirm with item_id

**Example Request**:
```json
{
  "type": "focus",
  "title": "llm-d 发展动态",
  "content": "持续关注 llm-d 分布式推理项目的发展动态",
  "source_url": "https://github.com/llm-d/llm-d/releases",
  "status": "active"
}
```

---

### Focus List

Query focus entries.

**Trigger**: User asks about tracked focus

**Workflow**:

1. Build query parameters from user request
2. Call `GET http://localhost:8090/api/v1/items?type=focus&...`
3. Format output as table or detail view

**Query Parameters**:

| Parameter | Description |
|-----------|-------------|
| `status` | active/paused/archived |
| `tags` | Comma-separated tags |
| `search` | Full-text search |

---

### Focus Get

Get single focus entry by ID.

**Workflow**:
1. Call `GET http://localhost:8090/api/v1/items/{id}`
2. Format as detail view

---

### Focus Update

Update existing focus entry.

**Trigger**: User wants to modify focus

**Workflow**:

1. Get current data: `GET /items/{id}`
2. Merge updates
3. Update Insight Hub: `PUT /items/{id}`
4. Sync local file

---

### Focus Delete

Delete focus entry.

**Trigger**: User wants to remove focus

**Workflow**:

1. Delete from Insight Hub: `DELETE /items/{id}`
2. Remove from local file
3. Confirm deletion

**Note**: This is a hard delete (permanent removal)

---

### Focus Sync

Sync local file from Insight Hub.

**Trigger**: Manual or scheduled

**Workflow**:

1. Fetch all: `GET /items?type=focus&limit=1000`
2. Generate `focus.md` file

---

## ID Format

```
windeye:focus:{timestamp}-{slug}

Examples:
- windeye:focus:20260306-llm-d-dynamics
- windeye:focus:20260306-kv-cache-optimization
```

## Error Handling

| Error | Action |
|-------|--------|
| Insight Hub unavailable | Write local only, mark for sync |
| Local write fails | Rollback Insight Hub |
| Duplicate detected | Prompt user to update or skip |

## Resources

- [Classification decision tree](resources/classify.md)
- [Relation inference guide](resources/relate.md)
- [Insight Hub field mapping](resources/mapping.md)
- [Value assessment guide](resources/value.md)
