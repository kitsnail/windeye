# Focus 处理指南

## 处理流程

```
Focus 条目
    ↓
检查 source_url
    ↓
获取内容
    ↓
AI 分析
    ↓
提取发现
    ↓
生成信号片段
```

---

## 内容获取策略

### 1. GitHub Releases（优先使用 GitHub API）

**URL 模式**: `https://github.com/{org}/{repo}/releases`

**⚠️ 重要**：`web_fetch` 对 GitHub 有 SSRF 限制，必须使用 curl + GitHub API

**获取方法（优先级排序）**:

1. **GitHub API（推荐）**：
   ```bash
   curl -s 'https://api.github.com/repos/{org}/{repo}/releases/latest'
   ```
   返回 JSON，包含 `tag_name`, `name`, `body`, `published_at` 等字段

2. **Web Search（备用）**：
   ```
   web_search: "{repo} releases latest 2026"
   ```
   注意：web_search 信息可能有延迟，优先使用 API

**分析重点**:
- 新版本发布（检查 `tag_name` 和 `published_at`）
- 破坏性变更（检查 `body` 内容）
- 新功能
- 废弃通知

### 2. GitHub 仓库

**URL 模式**: `https://github.com/{org}/{repo}`

**获取方法**:
- GitHub API: `curl -s 'https://api.github.com/repos/{org}/{repo}'`
- Web Search: `{repo} latest updates 2026`

**分析重点**:
- 最近提交
- 新版本发布
- 文档更新

### 3. 博客 / 文档

**URL 模式**: 各种

**获取方法**:
- web_fetch 获取内容
- 或 web_search 搜索最近提及

**分析重点**:
- 新文章
- 内容更新
- 公告

### 4. 通用 URL

**获取方法**:
- 优先 web_fetch
- 失败则 web_search

---

## AI 分析提示词

分析 Focus 内容时：

```
你正在检查关注点「{focus_title}」的最新动态。

关注点描述：{focus_content}
来源：{source_url}

请分析以下内容，判断是否有新的发现：

{content}

判断标准：
1. 是否有版本更新？（最近 2 天）
2. 是否有重要功能变化？
3. 是否有影响用户的公告？
4. 是否值得用户关注？

如果有新发现，请生成：
- 发现标题（简洁明了）
- 内容摘要（≤200字）
- 影响分析（对用户的潜在影响）

如果没有新发现，请返回「无新发现」。
```

---

## 发现判断标准

| 标准 | 是否生成信号？ |
|------|:-------------:|
| 新版本发布（≤2天） | ✅ 是 |
| 破坏性变更公告 | ✅ 是 |
| 新功能发布 | ✅ 是 |
| 废弃通知 | ✅ 是 |
| 常规更新（>2天） | ❌ 否 |
| 小 bug 修复 | ⚠️ 视情况 |
| 文档更新 | ⚠️ 视情况 |

---

## 错误处理

### URL 无法访问

```
1. 尝试 GitHub API（如适用）
2. 失败则尝试 web_fetch
3. 失败则尝试 web_search
4. 都失败则标记为 "⚠️ 访问失败"
5. 继续处理下一个 Focus
```

### 速率限制

```
1. 等待后重试一次
2. 仍被限制则跳过该 Focus
3. 在信号中注明："部分关注点因访问限制未检查"
```

### 内容解析错误

```
1. 尝试替代方法
2. 都失败则标记为 "⚠️ 解析失败"
3. 继续处理下一个 Focus
```

---

## 质量检查清单

生成信号前：

- [ ] 所有活跃 Focus 都检查了？
- [ ] 发现已从来源验证？
- [ ] 内容准确简洁？
- [ ] 提供了影响分析？
- [ ] 包含来源链接？
