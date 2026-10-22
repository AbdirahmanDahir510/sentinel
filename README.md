# Sentinel

A self-built monitoring, security, and ops toolkit for my public home-lab
server at dahirabdirahman.com.

## The problem
I have to log in to the server to manually run commands and check the 
security of the server. Sometimes delays and not knowing the state of the server
will be risky; that's why I need to build a dashboard that I can easily track what's going on. 

## What it does (so far)
- [ ] Health checks — disk, memory, load, nginx, cloudflared (Phase 1)

## Roadmap
| Phase | Component | Stack |
|-------|-----------|-------|
| 1 | Health check | Bash, cron |
| 2 | Log watcher + Discord digest | Bash, awk |
| 3 | Backups + tested restore | tar, cron |
| 4 | Attack & detect report | Kali, nmap, Fail2Ban |
| 5 | Sentinel API | Python, FastAPI |
| 6 | API gateway | Node.js, Express |
| 7 | Status dashboard | React |
| 8 | Containers + CI/CD | Docker, GitHub Actions |

## Environment
Ubuntu Server 24.04 · Cloudflare Tunnel → Nginx · <anything else>

## Why I built this
I want to learn more about system engineering and have the ability to run 
my own server at home. It's a skill that will put me ahead, learning more as I push.

## Status
Phase 1 — in progress# sentinel
