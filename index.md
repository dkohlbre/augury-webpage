---
layout: page
title: Augury
subtitle: Using Data Memory-Dependent Prefetchers to Leak Data at Rest
date: May 2 2022
---

We present a new type of microarchitectural attack that leaks data at
rest: data that is never read into the core architecturally. This
attack technique, Augury, leverages a novel microarchitectural
optimzation present in Apple Silicon: a Data Memory-Dependent
Prefetcher (DMP).

At a high level:
 - We found that Apple processors have a DMP
 - We found that this DMP prefetches an array-of-pointers dereferencing pattern
 - We found that you can use this prefetcher to leak data (pointers)
   that are never read by any instruction, even speculatively!


No logo, but please do use our fun name!

{::options parse_block_html="true" /}
<center>
<a  href="{% link _pages/tools.md %}"><button class="custom-btn btn-11">Tools</button></a>
<a  href="{% link augury.pdf %}"><button class="custom-btn btn-7">Paper</button></a>
<a  href="{% link _pages/about.md %}#citation"><button class="custom-btn btn-11">Cite</button></a>
</center>
{::options parse_block_html="false" /}

# Who found this?

{% include_relative _pages/about_text.md %}

# FAQ

{% include_relative _pages/faq_text.md %}