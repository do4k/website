---
title: "Stop Burning Tokens: A Practical Guide to AI Coding Efficiency in 2026"
date: 2026-05-18
draft: false
tags: ["AI", "Tokens", "GitHub Copilot", "Claude Code", "Productivity", "RTK", "Caveman", "Serena"]
categories: ["AI", "Development", "Productivity"]
---

Something shifted at DDD Southwest this year. The opening keynote wasn't about architecture patterns or team topologies — it was about surviving the AI transition with your budget, your sanity, and your engineering craft intact.

Andrew Poole opened with a blunt observation: **models and tooling have crossed a threshold**. Productivity gains are now real, expected by the boardroom, and increasingly non-optional. But resources are not infinite. And with GitHub Copilot's pricing model changing significantly from **June 1, 2026**, the way you use your AI tools is about to matter a lot more financially.

This post collects the practical tools and strategies that came out of that talk, with everything I've since researched and verified. The goal is simple: get more out of your AI coding tools while spending less — and ideally, make your agent smarter at the same time.

---

## Why This Matters Now: The Pricing Wake-Up Call

GitHub Copilot is moving from flat request-based billing to **usage-based billing** — cost is now tokens consumed multiplied by a per-model multiplier. For annual plan subscribers staying on their existing plan, the June 1 multiplier changes are significant:

| Model | Current multiplier | From June 1 |
|---|---|---|
| Claude Sonnet 4.5 | 1× | **6×** |
| Claude Sonnet 4.6 | 1× | **9×** |
| Claude Opus 4.5 | 3× | **15×** |
| Claude Opus 4.6 | 3× | **27×** |
| GPT-5.4 | 1× | **6×** |
| GPT-5.4 mini | 0.33× | **6×** |
| GPT-5.3-Codex | 1× | **6×** |

→ [Full table on GitHub Docs](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans)

Claude Sonnet 4.6 going from 1× to 9× means the same session now costs nine times more. GPT-5.4 mini — previously the cheap option — jumps 18×. If you're on an annual plan and doing nothing about this, you will notice it on your bill.

The good news: there's a growing ecosystem of tools designed specifically to reduce token waste. Some attack the input side, some the output side, and some change the fundamental way your agent explores code.

---

## The Token Efficiency Stack

Think of token usage in three buckets:

1. **Input tokens** — what you send into the context window (CLI output, file contents, context files)
2. **Output tokens** — what the model writes back to you
3. **Tool call tokens** — how many round trips your agent makes to explore the codebase

Here's a tool for each.

---

### 1. RTK — Rust Token Killer (Input: CLI Noise)

**What it does:** RTK is a CLI proxy written in Rust that wraps your terminal commands and strips the boilerplate before it reaches the AI's context window. Instead of `cargo test` dumping 300 lines of `... ok` into your context, you get a one-line summary. The substance — failures, errors, stack traces — is preserved in full.

**The numbers:** Self-reported 89% average reduction across 2,900+ real commands. `cargo test` saves 91.8%, `git status` 80.8%, `find` 78.3%, `grep` 49.5%. Worth noting these are measured as `chars/4` (a token approximation, not exact) and come from the author's own telemetry — no independent third-party benchmark exists yet. But the underlying technique is sound: stripping boilerplate is real and the savings on verbose commands are genuine.

**How it integrates:** Run `rtk init --claude-code` once and it installs a `PreToolUse` hook into Claude Code's `settings.json`. Every Bash invocation is transparently rewritten — the agent never needs to know RTK is there.

```bash
brew install rtk
rtk init --claude-code
# verify with: rtk gain
```

⚠️ `cargo install rtk` installs the wrong package (name collision). Use Homebrew or `--git` flag.

→ [rtk-ai.app](https://www.rtk-ai.app/) · [github.com/rtk-ai/rtk](https://github.com/rtk-ai/rtk)

---

### 2. Caveman (Output: Verbose Responses)

**What it does:** Caveman is a skill/plugin for Claude Code (and 30+ other agents) that instructs the model to respond in compressed, telegraphic prose. It only affects output tokens — reasoning and thinking are untouched. The brain stays big. The mouth gets small.

A normal response explaining a React re-render bug: 69 tokens.
The same answer in caveman mode: 19 tokens. Same fix. 72% less.

**The numbers:** Benchmarked at **65% average output token reduction** across 10 real prompts (22–87% range, using actual Claude API counts). Notably, a [March 2026 arXiv paper](https://arxiv.org/abs/2604.00025) found that brevity constraints actually *improved* accuracy by 26 points on certain benchmarks — verbose isn't always better.

Four compression levels:
- `lite` — drop filler phrases only
- `full` — default caveman (recommended starting point)
- `ultra` — telegraphic
- `wenyan` — classical Chinese, shortest possible

Trigger: `/caveman` or just say "talk like caveman". Stop with "normal mode".

**Bonus — `caveman-compress`:** Rewrites your `CLAUDE.md` and project context files into caveman-speak. Saves ~46% on *input* tokens at the start of every session, not just on replies. Run it once on your memory files and the saving compounds forever.

```bash
curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash
# then in your agent: /caveman
# compress your context files: /caveman-compress CLAUDE.md
```

→ [github.com/juliusbrussee/caveman](https://github.com/juliusbrussee/caveman)

---

### 3. Codebase Memory MCP (Tool Calls: File-Reading Loops)

**What it does:** This is the biggest potential saving of the three. When an AI agent explores a codebase, it typically loops through `grep` → read file → read another file → repeat. Each cycle costs tokens. Codebase Memory MCP replaces that pattern entirely by building a **persistent knowledge graph** of your codebase using tree-sitter AST parsing — then letting the agent query the graph instead.

Ask "what calls `ProcessOrder`?" and the agent runs one graph query returning the full call chain in under 1ms, rather than spawning a grep loop that reads a dozen files.

**The numbers:** 5 structural graph queries cost ~3,400 tokens. The equivalent file-by-file search costs ~412,000 tokens — a **99.2% reduction**. This is backed by a peer-reviewed [arXiv paper](https://arxiv.org/abs/2603.27277) (31 real-world repos tested). The paper does note a slight quality tradeoff: 83% answer quality vs 92% for file-reading — but at 10× fewer tokens and 2.1× fewer tool calls, that's usually worth it.

**Practical details:** Single static binary, zero runtime dependencies, 100% local. Supports 155 languages. Indexes the average repo in milliseconds. Includes a 3D interactive graph visualisation at `localhost:9749` if you want to explore the graph yourself.

```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
# restart your agent, then say: "Index this project"
# enable auto-indexing: codebase-memory-mcp config set auto_index true
```

**Team tip:** Commit `.codebase-memory/graph.db.zst` to your repo and teammates skip the reindex entirely when they clone.

→ [github.com/DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp)

---

### 4. Serena (Tool Calls: Smarter Code Understanding)

**What it does:** Serena is "The IDE for Your Coding Agent" — an MCP server that gives your AI agent IDE-level semantic understanding of code via LSP (Language Server Protocol). Instead of the agent doing fragile text search to find where a function is called, it uses the language server to resolve symbols, find all references, rename across the entire codebase atomically, and navigate type hierarchies.

The key insight: agents operating at the symbol level are faster, more accurate, and use fewer tokens because they don't need to grep-and-guess. Claude Code's own self-evaluation described it as: *"cross-file renames that would cost me 8–12 careful, error-prone steps collapse into one atomic call."*

Supports 40+ languages via LSP — for C# it hooks into a Roslyn-backed language server, giving the agent genuine compiler-level understanding. There's also a paid JetBrains plugin if you want the full IntelliJ analysis engine behind it.

```bash
uv tool install -p 3.13 serena-agent@latest --prerelease=allow
serena init
# then configure your MCP client to connect to it
```

→ [github.com/oraios/serena](https://github.com/oraios/serena)

---

### 5. Invest Your Tokens (Context as a Reusable Asset)

This isn't a tool — it's a mental model. Andrew framed it as applying DRY principles to token usage.

Every time you complete a non-trivial task with an AI agent, you've spent tokens generating something useful. If you throw that away, the next session starts from zero and spends those tokens again. If you **invest** them — by writing the outcome into a `CLAUDE.md`, creating a reusable prompt template, or building a new tool — those tokens pay dividends in every future session.

**In practice, this means:**
- After solving a tricky architectural problem: write the decision and rationale into your `CLAUDE.md` or an ADR (Codebase Memory MCP has `manage_adr` for exactly this)
- After establishing code conventions with your agent: commit them to a context file so the next session knows them immediately
- After building something useful: extract it as a reusable tool or skill rather than prompting from scratch next time

The token cost of writing a good context file is small. The saving across hundreds of future sessions is large. Treat your context files like code — they deserve the same care as your `README.md`.

---

### 6. Squad (Persistent Agent Teams)

**What it does:** Squad gives you a team of AI agents that live in your repository as markdown files, persist knowledge across sessions, and run in parallel under your direction. Each agent has a `charter.md` (who they are, what they know) and a `history.md` (what they've learned about *your specific project*). Commit `.squad/` to git and anyone who clones the repo gets the whole team.

The value is that agents accumulate project context over time and stop asking questions they've already answered. Andrew used Squad to refactor a major hot piece of architecture — with a rollback switch — and said the rollback was never needed.

Note: Squad is alpha software. APIs may change.

```bash
npm install -g @bradygaster/squad-cli
squad init
# then: copilot --agent squad --yolo
```

→ [github.com/bradygaster/squad](https://github.com/bradygaster/squad)

---

## The Actionable Checklist

### 🟢 Quick wins (under 5 minutes each)

- [ ] **Install RTK** — `brew install rtk && rtk init --claude-code`. Immediate, transparent CLI noise reduction on every session.
- [ ] **Install Caveman** — `curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash`. Then `/caveman` in your next session. Start with `full` mode.
- [ ] **Check your Copilot billing plan** — [review the June 1 multiplier changes](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans) and decide whether to stay on annual, switch to monthly, or upgrade.

### 🟡 Worth an hour

- [ ] **Install Codebase Memory MCP** — index your project, enable `auto_index true`.
- [ ] **Run `caveman-compress` on your CLAUDE.md** — one command, ~46% input token reduction every session, permanently.
- [ ] **Install Serena** — biggest impact on complex, multi-file refactoring tasks.

### 🔵 Bigger investment, bigger payoff

- [ ] **Audit your context files** — what have you re-explained to your agent multiple times? Invest those tokens once.
- [ ] **Try Squad on a project** — experiment with a small project before rolling out to a larger codebase.
- [ ] **Commit your Codebase Memory graph** — `graph.db.zst` so your team skips reindexing on clone.

---

## The Bigger Picture

What struck me most about Andrew's talk wasn't the individual tools — it was the framing. We're entering a world where the quality of your AI interactions is partly an engineering discipline in its own right.

The same instincts that make a good software engineer — DRY, separation of concerns, invest in reusable abstractions — apply directly to how you work with AI agents. Noisy context produces worse results and costs more. Clean, structured, persistent context produces better results and costs less. The tools above are all expressions of that principle applied to different parts of the token pipeline.

The June pricing changes make this urgent rather than optional. But even without the cost pressure, reducing noise and investing in context makes your agent more capable — and that's worth doing on its own merits.

---

## Quick Reference

| Tool | What it saves | Install |
|---|---|---|
| [RTK](https://github.com/rtk-ai/rtk) | ~89% CLI output noise (input tokens) | `brew install rtk && rtk init --claude-code` |
| [Caveman](https://github.com/juliusbrussee/caveman) | ~65% agent responses (output tokens) | `curl ...install.sh \| bash` |
| [Codebase Memory MCP](https://github.com/DeusData/codebase-memory-mcp) | ~99% vs file-by-file search (tool calls) | `curl ...install.sh \| bash` |
| [Serena](https://github.com/oraios/serena) | Fewer, more accurate tool calls | `uv tool install serena-agent@latest` |
| [Caveman-compress](https://github.com/juliusbrussee/caveman) | ~46% context file input tokens | `/caveman-compress CLAUDE.md` |
| [Squad](https://github.com/bradygaster/squad) | Accumulated knowledge = fewer repeated tokens | `npm i -g @bradygaster/squad-cli` |

---

*Inspired by Andrew Poole's talk "Software engineering is dead. Long live Software engineering!" at DDD Southwest 2026.*
*→ Back to [DDD Southwest 2026 notes](/blog/ddd-southwest-2026-notes-from-the-day)*
