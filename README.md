# Puppet development environemnt for Virtual Studio Code - Remote Containers

Docker image to be used as Puppet development environemt with Virtual Studio Code - Remote Containers.

## Usage

### 1. Pull the Docker image from Docker hub

```bash
docker pull dbarahona/vscode-puppet-dev:latest
```

### 2. Add or edit the following line on the `devcontainer.json` file

```json
{
    // ...

	"image": "dbarahona/vscode-puppet-dev:latest",

    // ...
}
```

## Run Litmus acceptance tests

In order to provision Docker containers for Litmus acceptance tests you need to install Docker in your OS and mount its socket to the remote container
by adding the following line to the `devcontainer.json` file.

```json
{
    // ...

	"mounts": [
		"source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
	]

    // ...
}
```

## Persist bash history

To persist the bash history between runs you need to add the following line to the `devcontainer.json` file.

```json
{
    // ...

	"mounts": [
		"source=<project-name>-bashhistory,target=/commandhistory,type=volume"
	]

    // ...
}
```

This will create a volume and mount it to the contaier.
