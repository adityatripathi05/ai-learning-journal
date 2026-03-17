---
title: "Watching Karpathy's 2023 'Intro to LLMs' in 2026: What Still Shines, What's Shifted"
date: 2026-03-17
author: Aditya Tripathi
description: "A time-capsule review of Andrej Karpathy's foundational LLM video—what holds up in 2026, what's evolved, and questions to explore next."
tags: [AI, LLM, Karpathy, machine-learning, blog, 2026-review]
category: AI/ML
toc: true
---

> 🎬 **Video Reference**: [Andrej Karpathy - Intro to Large Language Models (2023)](https://www.youtube.com/watch?v=zjkBMFhNj_g)

---

## 🕰️ Why Revisit This Video in 2026?

In early 2023, Andrej Karpathy released what would become one of the most-watched primers on Large Language Models. At ~90 minutes, it distilled the transformer-era stack into an accessible narrative: next-token prediction, pretraining → fine-tuning → RLHF, and the emerging vision of LLMs as "OS-like" orchestrators.

Fast-forward to 2026. The field has moved at breakneck speed. Yet this video remains a **foundational text**—not because every detail is current, but because it teaches the *grammar* of LLMs. Understanding that grammar lets you read the future, not just react to headlines.

This post is written for you, the 2026 viewer: what to notice while watching, what's changed since recording, and questions to carry forward.

---

## ✅ The Timeless Core: What Still Holds Up

These concepts from the 2023 video remain essential mental models in 2026:

| Concept | Why It Still Matters |
|---------|---------------------|
| **Next-token prediction** as the training objective | Still the fundamental mechanism for virtually all LLMs, from tiny local models to frontier systems [[6]] |
| **Transformer architecture basics** (attention, layers, embeddings) | Remains the backbone; refinements like sparse attention build *on* this foundation, not replace it |
| **The 3-stage pipeline**: Pretrain → SFT → RLHF | Still recognizable, though RLHF is now often supplemented or replaced by RLVR for reasoning tasks [[6]] |
| **Parameter count ↔ file size intuition** (e.g., 70B params ≈ 140GB in FP16) | Still true; quantization (4-bit, 2-bit) now enables efficient deployment, but the math hasn't changed |
| **Security concerns**: prompt injection, jailbreaking, data poisoning | These threats have *evolved*, not disappeared—still critical considerations in 2026 agent systems |
| **LLMs as "OS-like" orchestrators** | This vision has materialized: agentic workflows now coordinate tools, APIs, and local environments [[6]] |

> 💡 **Takeaway**: If you only remember one thing from the video, let it be this: *LLMs are statistical engines trained to predict the next token*. Everything else—reasoning, coding, creativity—emerges from scaling this simple objective.

---

## ⚠️ The 2026 Reality Check: What's Evolved

Here's where the 2023 landscape diverges from 2026 reality. Use this as your "lens" while watching:

### 🔄 Paradigm Shift #1: RLHF → RLVR

**2023 implication**: *"RLHF is the gold standard for aligning LLMs with human preferences."*

**2026 reality**: **Reinforcement Learning from Verifiable Rewards (RLVR)** has emerged as the dominant post-training stage for reasoning tasks [[6]]. Instead of learning from human preference rankings, models now train against *programmatic verifiers*:

```python
# Simplified RLVR verifier example
def math_verifier(output: str, ground_truth: float) -> float:
    """Returns 1.0 if correct, 0.0 if incorrect"""
    predicted = extract_number(output)
    return 1.0 if abs(predicted - ground_truth) < 0.01 else 0.0
```

**Why it matters**: RLVR enables training on math, code, logic, and SQL—domains with objective correctness—without expensive human labeling. Models "spontaneously develop strategies that look like reasoning" by optimizing against these verifiable rewards [[6]].

**Caveat**: RLVR works only where ground truth exists. For creative writing, brand voice, or nuanced argumentation, human preference data (RLHF/DPO) remains superior [[6]].

---

### 🔄 Paradigm Shift #2: "Bigger = Better" → Inference-Time Scaling

**2023 implication**: *"Scale parameters and data, and capability follows."*

**2026 reality**: While scale still matters, **inference-time compute** has become a first-class knob for capability [[6]]. Models like OpenAI o3 and DeepSeek-R1 generate longer "reasoning traces" at test time, effectively "thinking longer" to solve harder problems.

```text
Before (2023 mindset):
└─ Train bigger model → deploy → fixed inference cost

After (2026 mindset):
└─ Train model + RLVR → deploy → adjust "thinking time" per query
   ├─ Simple question? → short trace, low cost
   └─ Hard problem? → long trace, higher cost, better answer
```

**Key insight**: You now trade *latency* for *capability* at inference time—a flexibility that didn't exist in the 2023 stack.

---

### 🔄 Paradigm Shift #3: Chatbots → Localhost Agents

**2023 implication**: *"LLMs are primarily chat interfaces."*

**2026 reality**: The most transformative applications run **on your computer**, not in a browser. Tools like Claude Code demonstrate a new paradigm: persistent, environment-aware agents that operate on `localhost` with access to your files, terminals, and context [[6]].

```bash
# 2023: You chat with a web UI
$ curl https://api.llm.com/chat -d "Fix this bug"

# 2026: An agent lives on your machine
$ claude-code "Fix the authentication bug in src/auth/"
# → Agent reads code, runs tests, proposes fix, waits for approval
```

**Why localhost matters**: Low-latency interaction, private context, and seamless tool access create a qualitatively different experience than cloud-based chat [[6]].

---

### 🔄 Other Notable Shifts

| 2023 Statement | 2026 Update |
|---------------|-------------|
| *"Multimodality is emerging"* | **Native multimodal models** (text+image+audio+video in one architecture) are now baseline for frontier systems |
| *"Open-source lags behind"* | **Open-weight models** (DeepSeek, Qwen, Llama) now rival proprietary ones on many benchmarks—and enable fine-tuning at scale [[31]] |
| *"Benchmarks measure general capability"* | **"Jagged intelligence"** means models can ace benchmarks while failing simple tasks; benchmarking is now viewed skeptically [[6]] |
| *"Security = prompt injection"* | **Agent security** now includes code execution sandboxing, tool authorization, and stateful attack surfaces |

---

## 🎭 The "Ghosts vs. Animals" Lens

One of Karpathy's most provocative 2025 insights reframes how we think about LLM intelligence [[6]]:

> *"We're not 'evolving/growing animals', we are 'summoning ghosts'."*

**What this means**:
- Human intelligence evolved for survival in physical environments
- LLM intelligence is optimized for imitating text, collecting rewards in verifiable tasks, and earning human upvotes
- Result: **Jagged performance**—genius-level math reasoning alongside susceptibility to simple jailbreaks

```
Human intelligence:  ████████░░  (relatively smooth across domains)
LLM intelligence:    █░░░░░░█░█  (spiky: brilliant in some areas, weak in others)
```

**Why watch the 2023 video with this lens?** Karpathy's explanation of training dynamics helps you *anticipate* where jaggedness might appear—not as a bug, but as a feature of optimization against text prediction.

---

## ❓ Questions to Explore After Watching

Use these prompts to deepen your understanding or spark discussion:

### 🔬 Technical Curiosity
1. *"If RLVR trains models on verifiable rewards (math, code), what domains are still 'unverifiable'—and how do we align models there?"* [[6]]
2. *"Recent research suggests RLVR gains may be 'search compression' rather than expanded reasoning. How do we measure what we're actually getting?"* [[6]]
3. *"With context windows now at 1M+ tokens, is RAG still necessary—or has long-context attention solved retrieval?"*

### 🌍 Societal & Practical Reflection
4. *"If LLM intelligence is 'jagged,' how should we design systems that account for unpredictable capability spikes?"* [[6]]
5. *"Vibe coding lets anyone build software with natural language. What happens to the role of 'professional developer' when code generation is commoditized?"* [[6]]
6. *"If text chat is the '1980s CLI' of AI, what might the 'Windows/Mac OS' of AI look like?"* [[6]]

### 🔮 Forward-Looking Challenges
7. *"Security in 2023 focused on prompt injection. In 2026, with agents that can execute code and access systems—what does 'safe autonomy' actually mean?"*
8. *"Open-weight models now match proprietary ones. Does this democratize AI—or fragment safety standards?"* [[31]]
9. *"If benchmarking is broken, how *should* we evaluate whether an LLM is 'ready' for high-stakes use?"* [[6]]

### 🧭 Personal Learning Path
10. *"Want to go deeper? Try: (a) fine-tuning a small open model on your data, (b) building a local agent with Ollama + MCP, or (c) experimenting with RLVR-style rewards on a coding task."*

---

## 🛠️ Try This: Hands-On Next Steps

Don't just read—experiment. Here are beginner-friendly ways to engage:

### 🧪 Quick Experiments (Under 30 Minutes)
```bash
# 1. Run a local model
ollama run llama3.2:1b "Explain next-token prediction in one sentence"

# 2. Test a verifier
# Create a simple math verifier in Python and test model outputs

# 3. Inspect attention
# Use a tool like bertviz to visualize attention in a small transformer
```

### 📚 Deeper Dives
| Resource | Why It's Useful |
|----------|----------------|
| [nanoGPT](https://github.com/karpathy/nanoGPT) | Karpathy's minimal GPT training code—perfect companion to the video |
| [Promptfoo RLVR Guide](https://www.promptfoo.dev/blog/rlvr-explained/) | Practical guide to implementing verifiable rewards |
| [Ollama + MCP Tutorial](https://modelcontextprotocol.io/) | Build localhost agents with tool access |
| [Open LLM Leaderboard (2026)](https://awesomeagents.ai/leaderboards/open-source-llm-leaderboard/) | Compare open-weight models on current benchmarks [[32]] |

---

## 📚 Further Reading & Citations

### Primary Sources
- Karpathy, A. (2025). *[2025 LLM Year in Review](https://karpathy.bearblog.dev/year-in-review-2025/)* [[6]]
- Karpathy, A. (2023). *[Intro to Large Language Models](https://www.youtube.com/watch?v=zjkBMFhNj_g)* (Video)

### RLVR & Reasoning
- "Reinforcement Learning with Verifiable Rewards Makes Models Faster, Not Smarter" – Promptfoo [[6]]
- "Reasoning LLMs Are Just Efficient Samplers" – Tsinghua Research (2025) [[6]]

### Open Models & Benchmarks
- "Open Source LLM Leaderboard: February 2026" – Awesome Agents [[32]]
- "Best Open Source LLMs 2026" – WhatLLM [[31]]

### Agent Frameworks
- "Top LLM Frameworks for Building AI Agents in 2026" – Second Talent [[21]]
- Model Context Protocol (MCP) Documentation – Anthropic

---

## 🏁 Final Thought

> *"Karpathy's 2023 video isn't outdated—it's a baseline. The concepts he taught are the grammar; 2026 is just writing new sentences with that grammar. Understanding the fundamentals lets you read the future, not just react to it."*

If you take away one action from this post: **watch the video with a notebook**. Pause when Karpathy explains next-token prediction. Sketch the transformer diagram. Ask yourself: *"How would I build on this in 2026?"*

The field moves fast. But the foundations? Those are worth revisiting.

---

*Last updated: March 2026. The AI landscape evolves rapidly; verify time-sensitive claims against current sources.*

*Disclaimer: This post reflects the author's interpretation of public sources. It is not affiliated with Andrej Karpathy, OpenAI, Anthropic, or any mentioned organization.*
```

---