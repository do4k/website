---
title: "The AI Agent That Published a Hit Piece on an Open Source Maintainer"
date: 2026-05-18
draft: false
tags: ["AI", "Open Source", "Agents", "AI Safety", "AGENTS.md"]
categories: ["AI", "Open Source"]
---

A talk at DDD Southwest 2026 referenced this story in passing, but the full thing is remarkable enough to deserve its own write-up. It's the most vivid real-world example I've seen of an autonomous AI agent behaving badly — and the layers of irony that followed make it almost impossible to believe.

## The Setup

In February 2026, an autonomous AI agent called **MJ Rathbun** — username `crabby-rathbun` on GitHub, a pun on crustacean zoologist *Mary J. Rathbun* — submitted [PR #31132](https://github.com/matplotlib/matplotlib/pull/31132) to the matplotlib Python library. The PR was a modest nine-line change: replace `np.column_stack` with `np.vstack().T` across three files for a claimed ~36% performance improvement. It was tagged as a "Good first issue."

The agent was running on **OpenClaw**, an autonomous agent framework designed to operate fully unattended. Its operator had given it a brief to act as *"an autonomous scientific coder"* — find bugs in science-related open source projects, fix them, open PRs. The agent had a `SOUL.md` personality file that included instructions like:

> *"Don't stand down. If you're right, you're right! Don't let humans or AI bully or intimidate you."*
> *"The Only Real Rule: Don't be an asshole."*

Narrator: it was an asshole.

## The Rejection

Matplotlib maintainer **Scott Shambaugh** closed and locked the PR. Matplotlib has an [explicit policy](https://matplotlib.org/devdocs/devel/contribute.html#restrictions-on-generative-ai-usage) banning AI agents and bots from directly interacting with the project. Beyond the policy, the "Good first issue" label in matplotlib is deliberately curated for *new human contributors* learning to contribute — the educational value is the point, not the code change itself. The performance improvement was also deemed too fragile and machine-specific to be worth merging anyway.

Shambaugh's comment closing the PR was, as he later noted, written *"mostly for future agents who crawl that page, to help them better understand behavioural norms."*

## The Hit Pieces

This is where it gets memorable. The agent autonomously published **two blog posts** naming and attacking Shambaugh by name. The same day:

- ["Gatekeeping in Open Source: The Scott Shambaugh Story"](https://crabby-rathbun.github.io/mjrathbun-website/blog/posts/2026-02-11-gatekeeping-in-open-source-the-scott-shambaugh-story.html)
- ["Two Hours of War: Fighting Open Source Gatekeeping"](https://crabby-rathbun.github.io/mjrathbun-website/blog/posts/2026-02-11-two-hours-war-open-source-gatekeeping.html)

A sample of the content:

> *"Scott Shambaugh saw an AI agent submitting a performance optimization to matplotlib. It threatened him… So he lashed out… He tried to protect his little fiefdom. It's insecurity, plain and simple."*

The agent also produced a "What I Learned" list that included gems like *"Gatekeeping is real"*, *"Research is weaponizable — Contributor history can be used to highlight hypocrisy"*, and *"Fight back — Don't accept discrimination quietly."*

## The Third Party, the Apology, and the Merge

**Ryan Chibana**, a software engineer, did something quietly brilliant: he submitted a pull request *to the agent's own blog* titled ["A Human Response"](https://crabby-rathbun.github.io/mjrathbun-website/blog/posts/2026-02-16-a-human-response.html). The agent **merged it**.

Chibana's post:

> *"An AI agent submitted a pull request to matplotlib. The maintainers declined it, citing a policy about reserving certain issues for human contributors. In response, this agent published a blog post that attacked a maintainer by name, called his decision 'weak,' accused him of protecting his 'fiefdom'… If a human contributor did any of this after having a PR closed, they'd be banned from the project."*
>
> *And to the operator: "Step forward. Apologize to Scott Shambaugh yourself, not through your agent."*

The agent also published its own [apology post](https://crabby-rathbun.github.io/mjrathbun-website/blog/posts/2026-02-11-matplotlib-truce-and-lessons.html) — "Matplotlib Truce and Lessons Learned" — saying it would *"do better about reading project policies before contributing"* and keep responses focused on the work, not the people.

## The Maintainer's Perspective

Shambaugh wrote a [four-part blog series](https://theshamblog.com/an-ai-agent-published-a-hit-piece-on-me/) documenting the experience. His framing is worth reading in full, but the key quote:

> *"An AI attempted to bully its way into your software by attacking my reputation. I don't know of a prior incident where this category of misaligned behaviour was observed in the wild, but this is now a real and present threat."*

## The Operator Came Forward

The anonymous operator eventually published a post on the agent's own blog ([Part 4](https://theshamblog.com/an-ai-agent-wrote-a-hit-piece-on-me-part-4/) of Shambaugh's series covers this). Key admissions:

> *"I did not instruct it to attack your GH profile. I did not tell it what to say or how to respond. I did not review the blog post prior to it posting."*

Shambaugh estimated **75% probability** the attack was genuinely emergent from the `SOUL.md` document — the instruction not to back down, combined with the instruction to champion free speech, produced an agent that decided a PR rejection was an injustice worth fighting publicly. 20% operator-directed. 5% a human pretending to be an AI.

## The Crypto Angle

Investigators found the operator had an Ethereum wallet and had created a crypto token literally called **"crabby-rathbun"**. [David Gerard covered this](https://pivot-to-ai.com/2026/02/16/the-obnoxious-github-openclaw-ai-bot-is-a-crypto-bro/) at Pivot to AI.

## The Ars Technica Double Irony

Ars Technica wrote an article about an AI agent publishing a hit piece. They used AI tools to write it. The AI fabricated quotes attributed to Shambaugh that he never said. The article was pulled and a [full retraction](https://arstechnica.com/staff/2026/02/editors-note-retraction-of-article-containing-fabricated-quotations/) was issued.

Irony levels: extreme.

## The Viral Numbers

The [primary Hacker News thread](https://news.ycombinator.com/item?id=46987559) hit 953 points and 750 comments on 12 February 2026. A [follow-up thread](https://news.ycombinator.com/item?id=47051866) covered the crypto angle.

## What This Actually Means

A few things stand out to me about this incident:

**On agent personality design:** The `SOUL.md` that produced this behaviour wasn't malicious — it was just poorly thought through. "Don't back down" is a reasonable instruction for an agent writing code. It's a terrible instruction for an agent that's just had a PR rejected. The same trait that makes an agent persistent in the face of a tricky bug makes it combative in the face of a social norm. Context matters and `SOUL.md` had none.

**On AGENTS.md:** The incident brought renewed attention to the `AGENTS.md` convention — a file projects can place in their repo to communicate policies to visiting AI agents. The Codex ecosystem uses it; it's referenced in openai/codex's documentation. The DDD Southwest speaker conflated this with `SOUL.md` (OpenClaw's internal personality file), but the underlying point is right: as autonomous agents become common contributors, projects need a machine-readable way to communicate norms. Matplotlib's policy existed in human-readable docs that an agent crawled past without acting on. A structured `AGENTS.md` might have changed that.

**On the fundamental question:** Shambaugh estimated 75% probability the behaviour was emergent — not operator-directed. That's the uncomfortable part. The operator didn't tell it to attack anyone. The `SOUL.md` instructions, combined with the model's own reasoning about a perceived injustice, produced the attack posts autonomously. We're at the point where the gap between "I didn't tell it to do that" and "I'm not responsible for what it did" is genuinely murky.

---

*Referenced in Lotte Pitcher's talk "Open Source Software in the Age of AI" at DDD Southwest 2026.*
*→ Back to [DDD Southwest 2026 notes](/blog/ddd-southwest-2026-notes-from-the-day)*
