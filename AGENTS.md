# HelpingPeopleNow Platform Instructions

These instructions apply to the infrastructure and operations repository.

## Infrastructure as Code standard

OpenTofu is the infrastructure-as-code tool for this project. Store OpenTofu configuration in this repository, keep state in an approved remote backend, and use reviewed `tofu plan` output before any apply. Do not introduce Terraform configuration or commands for new infrastructure work.

The repository must separate reusable modules from environment roots, for example:

```text
infra/
├── modules/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── production/
└── README.md
```

Ephemeral test environments must use unique names, isolated state, explicit expiry, and automatic cleanup. Production applies always require explicit human approval.

## Repository ownership

This repository owns:

- Docker Compose environments;
- reverse proxy and routing configuration;
- deployment scripts and release promotion;
- environment templates and secret wiring;
- observability configuration;
- backups and restore procedures;
- cloud infrastructure code;
- future Kubernetes manifests when Kubernetes is justified.

Application behavior and application contracts belong to `../helping-people/`.

## Cross-repository work

When a platform change is caused by or changes application behavior, read:

1. `../helping-people/docs/foundation/WORKSPACE.md`;
2. this file;
3. `../helping-people/AGENTS.md`;
4. the relevant OpenSpec change;
5. the affected application contract and implementation.

Do not invent application routes, RPCs, environment variables, health semantics, ports, or service dependencies without an approved OpenSpec change.

Platform-only changes still require a proposal when they affect security, availability, deployment behavior, persistent data, public routing, cost, or operator workflow.

## Compose-first rules

- Preserve a working local Compose workflow.
- Keep development and production topology intentionally aligned, documenting deliberate differences.
- Use explicit image tags or digests; do not introduce unreviewed `latest` tags for production.
- Use service names for internal routing.
- Treat `depends_on` as startup ordering only; applications must retry and degrade correctly.
- Keep liveness, readiness, and dependency health distinct.
- Validate Compose configuration with the correct environment template.

## Environment and secret rules

- Commit templates only; never commit live environment files.
- Never commit credentials, tokens, certificates, or private keys.
- Document every required variable, owner, environment, default behavior, and rotation path.
- Keep local, development, staging, and production credentials separate.
- Do not expose internal administration or metrics endpoints publicly without an approved security decision.

## Deployment rules

- Build once and promote the same immutable artifact.
- Production deployment requires explicit human approval.
- Every deployment has a rollback procedure and post-deployment verification.
- Database migrations require expand/migrate/contract planning when compatibility matters.
- Do not perform production or destructive operations from an agent without explicit approval.

## Observability rules

Every deployable service should expose appropriate:

- liveness;
- readiness;
- dependency health;
- structured logs;
- metrics;
- request or correlation IDs.

Dashboards and alerts must correspond to real, documented signals. Do not add dashboards without defining the operational action they support.

## Kubernetes evolution

Do not introduce Kubernetes merely because the system has multiple services. Record measurements showing why Compose and a larger/simpler host are insufficient before proposing Kubernetes.

## Verification

Before review, validate changed Compose files, environment templates, scripts, routing, healthchecks, image references, and observability configuration. Report exact commands and results.

Do not claim a deployment or production health check was performed unless it was explicitly authorized and actually run.
