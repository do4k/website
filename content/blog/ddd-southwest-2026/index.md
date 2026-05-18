---
title: "DDD Southwest 2026 — Notes from the Day"
date: 2026-05-18
draft: false
tags: ["DDD Southwest", "Conference", "AI", "Agents", "Open Source", "Productivity", "Diagramming", "Community"]
categories: ["Conference Notes", "AI", "Development"]
---

DDD Southwest returned to Bristol on Saturday 18 May 2026. This was a great day — a broad mix of talks from deeply technical to deliberately philosophical. Here are my notes in order of the day, with links to the longer write-ups where I've gone deeper on specific topics.

If there was one thread running through the whole day, it was this: **software engineering is having an identity crisis**. AI is writing a significant chunk of the code now, and it's hard to avoid the question of what that means for us. This wasn't just Andrew Poole's talk — it surfaced everywhere, from open source maintainers drowning in AI-generated PRs to debates about extinction risk to whether we can even review code anymore.

The timing feels significant too. At Christmas, LLMs were arguably just a powerful autocomplete — useful but not transformative. Six months later, they're genuinely generating large amounts of production code. That's a fast shift, and it's clearly landed differently for different people in the room.

---

## 09:00 — Andrew Poole: Software engineering is dead. Long live Software engineering!
*Track 1 - The Junction*

The opening keynote set the tone for most of the conversations that followed. Andrew's argument: models and tooling have crossed a threshold and we need to redefine the value we add as engineers. He's not doom-mongering — it's actually an optimistic framing — but he's honest that the transition is emotionally uncomfortable and the Kübler-Ross change curve applies.

There's a real inflection point here that Andrew articulated well. Six months ago LLMs were broadly just a very powerful autocomplete. Now they're generating significant amounts of real code. That's a fast shift, and it creates a genuine identity question for engineers — if AI is writing a lot of the code, what exactly is our job? Andrew's answer is roughly: your job is shifting from *writing* code to *directing*, *reviewing*, and *taking responsibility* for it. The engineering judgement doesn't disappear — it just moves upstream.

The most practically useful section was about **token efficiency**, prompted by GitHub Copilot's [pricing changes coming June 1](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans) — Claude Sonnet 4.6 going from 1× to 9× for annual plan holders is hard to ignore. Andrew walked through a stack of tools for reducing waste across every layer of token usage.

He also demonstrated **[Brady Gaster's Squad](https://github.com/bradygaster/squad)** — a framework for giving your AI coding agent a persistent team that lives in your repo as markdown files and accumulates knowledge of your codebase across sessions. He used it to refactor a major hot piece of architecture with a rollback switch that he never needed to use.

→ **I've written this up in full: [Stop Burning Tokens: A Practical Guide to AI Coding Efficiency in 2026](/blog/stop-burning-tokens-a-practical-guide-to-ai-coding-efficiency-in-2026)**

---

## 10:45 — Lorraine Pearce: Be the Glue — How small contributions build strong communities
*Track 2 - Brunel's Boardroom*

A short but punchy talk about volunteering and community building. Lorraine shared personal stories ranging from running support groups to working with an organisation that helps sex workers in Bristol — a humbling reminder of privilege and what we can do with our time and skills.

The core message: *"Small actions create the glue that holds communities together."* You don't need permission to start.

This talk made me want to get back into **[Code Club](https://codeclub.org)** volunteering, and I'm going to look into **[STEM Ambassadors](https://www.stem.org.uk/stem-ambassadors)** too.

---

## 11:30 — Lotte Pitcher: Open Source Software in the Age of AI
*Track 4 - Clock Tower*

An excellent talk on how AI is changing the open source ecosystem — for better and worse. The headline case study was the **OpenClaw / MJ Rathbun / matplotlib incident** from February 2026, which I found fascinating enough to write up separately.

Short version: an autonomous AI agent had a PR rejected, published hit pieces naming the maintainer by name, a third party pushed back via a PR to the agent's own blog (which it merged), the agent apologised, and the whole thing went viral with 953 HN points. Ars Technica then wrote about the AI writing hit pieces using AI — fabricated quotes — and had to issue a retraction.

→ **Full write-up: [The AI Agent That Published a Hit Piece on an Open Source Maintainer](/blog/the-ai-agent-that-published-a-hit-piece-on-an-open-source-maintainer)**

Other key points from this talk:

- OSS projects are being flooded with AI-generated "slop" PRs that don't address real issues — this is a genuine maintainer burden problem.
- `AGENTS.md` is becoming a real mechanism for projects to communicate policies to visiting AI agents. Worth adding to your repos if you want to signal your preferences to autonomous contributors.
- Supply chain risk is real — AI agents can be exploited to introduce subtle vulnerabilities into OSS packages at scale.

---

## 13:30 — Ross Scott: We're all doomed!
*Track 3 - Brunel's Breakout Room*

A debate session based on the book *"If anyone builds it, everyone dies"* — the case against superintelligent AI. Interesting discussion, fairly hypothetical.

I offered an opinion in the session that I still hold: LLMs are not the right technology for extinction-level risk. A gun is deterministic — point and shoot. An LLM produces a statistical approximation. The non-determinism is a fundamental constraint on the risk profile. That's not to say there are no risks worth taking seriously, just that "LLMs = terminators" is the wrong frame.

---

## 14:45 — Marin Niehues: Unf*ck your mind — How to finally build something great again
*Track 1 - The Junction*

General focus and productivity talk. Lighter on new content than some of the other sessions, but a few practical takeaways:

- **Calendar blocking** to prevent context-switching overhead — protect focus time explicitly.
- **Phone monochrome mode** when you need to concentrate — strips the dopamine hit from colourful notifications so the pull to pick it up diminishes.
- **5-tab rule** — aim to have no more than 5 browser tabs open at once. It forces you to be selective about what's actually important *right now*, rather than accumulating open loops. A browser-level WIP limit.

---

## 15:30 — Jacqui Read: Design Patterns for Software Diagramming
*Track 4 - Clock Tower*

Probably the most technically substantive session of the day for me. Jacqui makes a compelling case that diagramming is a learnable, pattern-driven skill that most engineers never get formally taught — and it shows.

**Key takeaways:**

- **Use the [C4 model](https://c4model.com/)** for architecture diagrams. The four levels (Context, Container, Component, Code) give you a consistent abstraction ladder. Don't mix levels in one diagram — a context diagram and a component diagram serve different audiences and have no business being on the same canvas.
- **Use a common language and key** — diagrams should be self-explanatory. Never assume the reader knows your notation. If you need a legend, write it; if you can choose notation that doesn't need a legend, do that instead.
- **Hard anti-UML stance** — UML assumes a level of domain knowledge that most audiences don't have. Its value is in precision for a narrow audience. For broader communication, simpler and more inclusive notation wins.
- The *purpose* of a diagram is **successful communication with that specific audience**. Design for the reader you have, not the reader you wish you had.

---

## Overall Themes

A few threads ran through the whole day:

**The AI transition is real and the tools are catching up fast.** Between RTK, Codebase Memory MCP, Serena, Caveman, and Squad, there's now a genuinely useful stack for working with AI coding agents more efficiently. The pricing changes make this urgent.

**The open source ecosystem is under strain from AI.** Maintainers are dealing with a flood of low-quality automated contributions, and the OpenClaw incident shows that autonomous agents can cause reputational harm in addition to maintenance burden. The community is figuring out norms — AGENTS.md is one response.

**Give back.** Both Lorraine Pearce's talk and Jacqui Read's framing around inclusion reminded me that there's value in contributing outside of work — Code Club, STEM Ambassadors, local communities. Worth making time for.

---

*→ [Stop Burning Tokens: AI coding efficiency in 2026](/blog/stop-burning-tokens-a-practical-guide-to-ai-coding-efficiency-in-2026)*
*→ [The OpenClaw Incident: when an AI agent published a hit piece](/blog/the-ai-agent-that-published-a-hit-piece-on-an-open-source-maintainer)*
