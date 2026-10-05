---
title: "From Two to Three to One: Unifying Sponsored Listings Platforms at Just Eat Takeaway.com"
date: 2025-10-08
draft: false
tags: ["Architecture", ".NET", "C#", "System Design", "Microservices", "AWS", "Migration"]
categories: ["Architecture", "Engineering"]
description: "How we retired legacy PHP and CPC platforms to build Unified TopRank: a scalable, CPO-driven sponsored listings engine built with C# and .NET 10 on AWS."
---

## Introduction: The Challenge of a Post-Merger Landscape

Engineering teams at large organizations often face the unique challenge of post-merger technical consolidation. When Just Eat and Takeaway.com merged in 2020, it brought together two mature, high-scale engineering ecosystems with distinct platforms serving the same fundamental business objective: **enabling restaurant partners to boost their visibility in search results**.

We found ourselves responsible for two disparate products:

1. **Promoted Placement:** Just Eat's C# / .NET-based system running a traditional **Cost-Per-Click (CPC)** auction model.
2. **Legacy TopRank:** Takeaway.com's **Cost-Per-Order (CPO)** sponsored listing product, written in PHP using the Laravel framework.

Our backend team is composed of C# engineers. While Promoted Placement sat comfortably within our core technical domain, Legacy TopRank was largely a black box. Juggling both systems resulted in duplicated operational overhead, split engineering capacity, and a fragmented experience for restaurant partners across European markets. 

We needed a unified, modern solution.

---

## A Tale of Two Systems

### Legacy TopRank: The Uncharted Waters of PHP
Legacy TopRank represented a classic engineering dilemma: owning a revenue-critical service without in-house expertise in its underlying stack. 

Without dedicated PHP or Laravel engineers on the team, every support ticket or bug investigation required deep dives into unfamiliar territory. The service remained in "keep the lights on" maintenance mode, accumulating technical debt. Furthermore, it ran on an older deployment platform (Marathon) that was slated for deprecation across the organization.

### Promoted Placement: Retiring the CPC Model
Promoted Placement was on familiar ground technically (.NET / C#), but operated on a **Cost-Per-Click (CPC)** model where restaurants bid for clicks when users viewed their menu. 

While CPC is an industry-standard ad model, it has notable limitations in food delivery:
* **Misaligned Incentives:** A restaurant pays for customer engagement (clicks), regardless of whether that traffic converts into actual orders.
* **Peak-Hour Bottlenecks:** Under a fixed budget model, high-performing restaurants could burn through their daily budget during off-peak hours, losing promoted visibility during peak dinner rushes.
* **Slot Constraints:** Only the top 5 bids received sponsored visibility, restricting market liquidity.

---

## The Vision: Building "Unified TopRank"

Rather than choosing one legacy platform over the other or attempting a fragile line-by-line port of PHP code, we chose to architect a greenfield platform: **Unified TopRank**.

We designed the platform around four core pillars:

1. **A Consolidated, Modern Tech Stack:** Standardized on our team's core competency—**C#, the .NET ecosystem, and AWS EKS**—to maximize developer velocity, long-term maintainability, and horizontal scalability.
2. **Modern CI/CD:** Replaced legacy Concourse and Marathon setups with standardized, unified **GitHub Actions** release pipelines.
3. **Robust Data & Access Governance:** Enforced granular identity and access control through Okta permission groups rather than ad-hoc credential vaults.
4. **An Aligned Business Model:** Replaced CPC with a predictable **Cost-Per-Order (CPO)** model.

---

## Business Impact: Why Cost-Per-Order (CPO) Wins

The biggest product shift in Unified TopRank is the pricing model. We wanted our commercial incentives to align directly with the revenue growth of our restaurant partners.

Under the CPO model:
* A restaurant partner bids a fixed fee they are willing to pay for an actual order (e.g. £3.20).
* If a customer discovers the restaurant via a sponsored listing and places an order of any value, the partner pays that flat £3.20 fee.
* Higher bids gain higher relative placement within the search auction, bounded by dynamic minimum and maximum bid thresholds.

### Why Partners Prefer This Model:
* **Direct ROI:** Partners only pay when a real, revenue-generating transaction occurs.
* **Zero Risk on Bounces:** No wasted ad spend on accidental clicks or non-converting menu views.
* **Budget Predictability:** Marketing costs scale proportionally with sales revenue.
* **Real-time Performance Transparency:** Clear visibility into conversion rates and return on investment.

---

## The Technical Journey & Architecture

Building Unified TopRank required a multi-phase strategy:

1. **Domain Discovery & Deconstruction:** Reverse-engineering the legacy business rules and edge cases buried in Legacy TopRank to guarantee domain parity.
2. **Microservices on Kubernetes:** Designing independent services for **Bidding**, **Ad Serving / Auctioning**, **Attribution**, and **Billing**, each capable of scaling independently to handle high-traffic spikes.
3. **Market-by-Market Migration:** Running live revenue-critical migrations with parallel validation and feature flags.

---

## Why We Chose Market-by-Market "Big Bang" Releases

Replacing live ad platforms is often compared to rebuilding an aircraft engine in mid-flight. While gradual user-level rollout is standard for many features, we deliberately chose a **market-by-market "big bang" cutover**:

### 1. Avoiding Pricing & Data Chaos for CPC Markets
In markets transitioning from CPC to CPO, running both systems concurrently within the same geography would have forced competing restaurants into two different auction economies. This would have caused severe confusion around ROI reporting, fragmented attribution data, and operational complexity for our commercial account managers.

### 2. Eliminating Cross-Stack Distributed Synchronization
For markets already on CPO, maintaining real-time data sync and state consistency between a legacy PHP/Marathon cluster and the new .NET/Kubernetes engine during a partial rollout would have introduced fragile cross-platform bridges and increased the risk of double-billing or dropped attributions.

A clean, market-by-market cutover allowed us to cleanly decommission the legacy stack in each region with verified data integrity.

---

## What’s Next?

Unified TopRank is now actively powering sponsored listings across multiple Just Eat Takeaway markets. 

With the unified platform in place and the legacy PHP footprint retired, our focus shifts to next-generation advertising features: **automated bid optimization algorithms**, **deep real-time analytics dashboards**, and **intelligent placement targeting**.

Consolidating disparate systems into a single, high-performance .NET architecture has not only reduced technical debt—it has given us a foundation built for long-term scalability.
