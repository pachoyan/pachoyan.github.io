---
title: WSL Series
icon: fas fa-graduation-cap
hidden: true
---

<p style="margin-bottom: 1rem;">
  <a href="{{ '/series' | relative_url }}">← Back to Series</a>
</p>

## WSL Training Series

A comprehensive bootcamp-style guide to mastering Windows Subsystem for Linux (WSL), from initial setup to advanced configurations and development workflows.

### About This Series

This structured learning path will take you through everything you need to know about WSL, whether you're a beginner just getting started or looking to optimize your WSL development environment.

---

### Series Posts

{% assign wsl_posts = site.posts | where_exp: "post", "post.tags contains 'wsl-series'" | sort: 'date' %}
{% for post in wsl_posts %}
<div style="margin-bottom: 2rem;">
  <h4 style="margin-bottom: 0.5rem;">
    <a href="{{ post.url | relative_url }}">{{ forloop.index }}. {{ post.title }}</a>
  </h4>
  <p style="color: gray; font-size: 0.9em; margin-bottom: 0.5rem;">{{ post.date | date: "%B %d, %Y" }}</p>
  <p style="margin-bottom: 0;">{{ post.description }}</p>
</div>
{% endfor %}

---

### What You'll Learn

- ✅ Initial WSL installation and configuration
- 🚀 System optimization and performance tuning
- 💻 Development environment setup
- 🔧 Advanced WSL features and best practices
- 🔗 Integration with Windows tools and workflows

---

<p style="text-align: center; font-style: italic;">More posts coming soon!</p>
