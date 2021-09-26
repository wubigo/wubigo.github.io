---
layout: post
title: web testing automation
date: 2018-01-07
tag: [web, testing]
---

# Puppeteer vs Selenium/WebDriver

* Selenium/WebDriver focuses on cross-browser automation; its value proposition is a single standard API that works across all major browsers.
* Puppeteer focuses on Chromium; its value proposition is richer functionality and higher reliability.

That said, you can use Puppeteer to run tests against Chromium, e.g. using the community-driven jest-puppeteer. While this probably shouldn’t be your only testing solution, it does have a few good points compared to WebDriver:
* Puppeteer requires zero setup and comes bundled with the Chromium version it works best with, making it very easy to start with. At the end of the day, it’s better to have a few tests running chromium-only, than no tests at all.
* Puppeteer has event-driven architecture, which removes a lot of potential flakiness. There’s no need for evil “sleep(1000)” calls in puppeteer scripts.
* Puppeteer runs headless by default, which makes it fast to run. Puppeteer v1.5.0 also exposes browser contexts, making it possible to efficiently parallelize test execution.
* Puppeteer shines when it comes to debugging: flip the “headless” bit to false, add “slowMo”, and you’ll see what the browser is doing. You can even open Chrome DevTools to inspect the test environment.


# 爬虫

为了爬取js渲染的html页面，我们需要用浏览器来解析js后生成html。
在scrapy中可以利用pyppeteer来实现对应功能


