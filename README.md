# devops-bootcamp-project
DevOps Bootcamp Final Project

## GitHub Copilot and LocalStack MCP

This repository includes MCP configuration for both the HashiCorp Terraform MCP
server and the LocalStack MCP server in `.vscode/mcp.json`. The LocalStack
server lets Copilot inspect and operate the LocalStack environment through
natural-language requests, including checking service status, querying AWS
resources, analyzing logs, and deploying or destroying local infrastructure.

### Configure the LocalStack token

The token is intentionally read from the `LOCALSTACK_AUTH_TOKEN` environment
variable and is not stored in this repository.

```bash
export LOCALSTACK_AUTH_TOKEN='your-token'
```

Start LocalStack on its normal endpoint before using the server:

```bash
curl http://localhost:4566/_localstack/health
```

In VS Code, reload the window after setting the variable and confirm that the
LocalStack MCP server is enabled in the Copilot/MCP tools view. In Copilot CLI,
use `/mcp` to inspect the configured MCP servers and make sure the LocalStack
server is available.

### Example Copilot requests

Use specific, bounded requests so it is clear which environment Copilot may
change:

```text
Check the LocalStack service health and report the status of EC2, IAM, SSM, and VPC.
```

```text
Inspect the LocalStack EC2 instances and show their instance IDs, private IPs,
Docker-reachable addresses, and states. Do not modify resources.
```

```text
Deploy the Terraform configuration in iac/localstack using LocalStack. Show the
plan first and do not apply changes until I confirm.
```

```text
Analyze recent LocalStack logs for failed EC2, VPC, or IAM requests.
```

The LocalStack MCP server uses `http://localhost:4566` by default. If the
LocalStack endpoint is elsewhere, change `LOCALSTACK_HOSTNAME` and
`LOCALSTACK_PORT` in `.vscode/mcp.json` or configure those variables in the
client's MCP environment.

Never commit the authentication token. Before committing changes, check:

```bash
git grep -n -I -E 'LOCALSTACK_AUTH_TOKEN|ls-ci' HEAD -- . || true
```
