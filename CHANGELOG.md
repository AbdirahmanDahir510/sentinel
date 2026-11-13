#Changelog

## Phase 1 - Health Check (2026-11-12)

###Added
- 'scripts/healthcheck.sh' : checks disk, memory, load, nginx, cloudflared
- PASS/FAIL report with timestamp
- Hourly cron job 

### Decisions
- Runs hourly not every 15 minutes: because its unecessary to run healthcheck of a homelab every 15 min
- Logs in UTC: unecessary also for homelab but making the logs universal time eliminates the local time changes which is good for log timestamp
- Pre-Repo SSH instead of HTTPS Token: deploy key scooped to a single repo is safer for automated deployments

### Leaned
- When creating a homelab its risky and fun at the same time worring about health, security of a server so automating scripts like this makes it easier to run homalab server. 
