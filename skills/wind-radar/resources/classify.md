# Classification Decision Tree

Use this decision tree to determine the tracking type.

## Flow

```
Is this a long-term directional change?
├── YES → type: trend
└── NO ↓

Is this a latest development or breakthrough?
├── YES → type: frontier
└── NO ↓

Is this a problem to be solved or researched?
├── YES → type: question
└── NO ↓

Is this a valuable discovery extracted from information?
├── YES → type: insight
└── NO ↓

Is this an actionable recommendation?
├── YES → type: conclusion
└── NO ↓

→ Not suitable for tracking
```

## Type Definitions

| Type | Definition | Example |
|------|------------|---------|
| **trend** | Long-term, directional changes | "AI inference frameworks entering scene differentiation phase" |
| **frontier** | Latest developments, breakthroughs | "llm-d v0.5.0 released, vLLM upgraded to 0.14.1" |
| **question** | Problems to be solved or researched | "How to select inference framework?" |
| **insight** | Valuable discoveries from information | "Selection logic shifts from 'who is faster' to 'who fits better'" |
| **conclusion** | Actionable recommendations | "Recommend: Select framework by scene, throughput-first choose LMDeploy" |

## Domain Classification

| Domain | Scope |
|--------|-------|
| **technology** | AI, cloud-native, infrastructure |
| **society** | Population, policy, culture |
| **economy** | Market, investment, industry |

## Intensity Assessment

| Level | Criteria |
|-------|----------|
| **high** | Strong signal, clear impact, immediate relevance |
| **medium** | Moderate signal, potential impact, worth watching |
| **low** | Weak signal, uncertain impact, needs observation |

## Value Assessment

| Level | Criteria |
|-------|----------|
| **high** | Directly affects decisions, requires immediate attention |
| **medium** | Triggers action or insight, worth continued attention |
| **low** | Potential value, needs observation |
