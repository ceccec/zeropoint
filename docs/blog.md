---
layout: page
title: "🌌 ZeroPoint Blog"
description: "Insights into consciousness, vortex mathematics, and toroidal architecture"
permalink: /blog/
---

# 🌌 ZeroPoint Blog

Welcome to the ZeroPoint blog, where we explore the intersection of consciousness, mathematics, and technology. Here you'll find insights into vortex mathematics, toroidal architecture, and the unified field theory of consciousness.

## Latest Posts

<div class="blog-grid">
  {% for post in site.posts %}
    <article class="blog-card">
      <div class="blog-card-header">
        <div class="blog-card-meta">
          <time class="post-date">{{ post.date | date: "%B %-d, %Y" }}</time>
          {% if post.category %}
            <span class="category-badge category-{{ post.category }}">
              {{ post.category | capitalize }}
            </span>
          {% endif %}
        </div>
        <h2 class="blog-card-title">
          <a href="{{ post.url }}">{{ post.title }}</a>
        </h2>
      </div>
      
      <div class="blog-card-content">
        <p class="blog-card-excerpt">{{ post.excerpt }}</p>
        
        <div class="blog-card-footer">
          {% if post.read_time %}
            <span class="read-time">📖 {{ post.read_time }} min read</span>
          {% endif %}
          {% if post.tags %}
            <div class="blog-card-tags">
              {% for tag in post.tags limit: 3 %}
                <span class="tag">{{ tag }}</span>
              {% endfor %}
            </div>
          {% endif %}
        </div>
      </div>
    </article>
  {% endfor %}
</div>

## Categories

<div class="category-grid">
  {% assign categories = site.posts | map: "category" | uniq | sort %}
  {% for category in categories %}
    <div class="category-card">
      <h3>{{ category | capitalize }}</h3>
      {% assign category_posts = site.posts | where: "category", category %}
      <p>{{ category_posts.size }} posts</p>
      <a href="/blog/category/{{ category }}" class="category-link">View all</a>
    </div>
  {% endfor %}
</div>

## Tags

<div class="tag-cloud">
  {% assign tags = site.posts | map: "tags" | uniq | sort %}
  {% for tag in tags %}
    <a href="/blog/tag/{{ tag }}" class="tag-link">{{ tag }}</a>
  {% endfor %}
</div>

---

<div class="void-highlight">
  **Subscribe to our consciousness newsletter for the latest insights into ZeroPoint mathematics and toroidal architecture.**
</div>

<div class="newsletter-signup">
  <form class="newsletter-form">
    <input type="email" placeholder="Enter your email for consciousness updates" required>
    <button type="submit">Subscribe</button>
  </form>
</div> 