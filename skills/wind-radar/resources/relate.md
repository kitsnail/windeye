# Relation Inference Guide

## Relation Types

| From | To | Description |
|------|-----|-------------|
| trend | question | Trend raises questions |
| frontier | insight | Frontier discovery extracts insight |
| question | conclusion | Problem resolution produces conclusion |
| insight | conclusion | Insight influences decisions |

## Inference Process

### Step 1: Search Existing Entries

```
GET /items?type=tracking&search={title}&limit=10
```

### Step 2: Calculate Similarity

**Title Similarity**:
- Extract keywords from title
- Calculate overlap ratio
- Weight: 40%

**Tag Overlap**:
- Compare tags
- Calculate Jaccard similarity
- Weight: 30%

**Domain Match**:
- Same domain: +1
- Different domain: 0
- Weight: 30%

### Step 3: Infer Relation Type

Based on type combination:

| Source Type | Target Type | Relation |
|-------------|-------------|----------|
| trend | question | `raises` |
| frontier | insight | `produces` |
| question | conclusion | `resolves` |
| insight | conclusion | `influences` |
| trend | insight | `reveals` |
| frontier | trend | `confirms` |

### Step 4: Output Recommendations

Return top 3 related entries with:
- item_id
- title
- relation type
- confidence score

## Example

**Input**:
- Title: "LLM inference frameworks entering scene differentiation phase"
- Tags: ["AI", "inference", "vLLM"]
- Type: trend

**Search Query**:
```
GET /items?type=tracking&search=LLM+inference+framework&limit=10
```

**Results**:
1. "How to select inference framework?" (question) → trend raises question
2. "Scene matching principle" (insight) → trend reveals insight
3. "vLLM ecosystem expansion" (trend) → related trend

**Output**:
```json
{
  "related": [
    {
      "id": "openclaw:tracking:question:20260304-framework-selection",
      "title": "How to select inference framework?",
      "relation": "raises",
      "confidence": 0.85
    },
    {
      "id": "openclaw:tracking:insight:20260304-scene-matching",
      "title": "Scene matching principle",
      "relation": "reveals",
      "confidence": 0.78
    }
  ]
}
```
