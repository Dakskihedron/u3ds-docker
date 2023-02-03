# U3DS Docker Image

This Docker image contains a dedicated server for the free-to-play survival game Unturned. This image uses CM2Walki's [steamcmd](https://github.com/CM2Walki/steamcmd) image as a base.

## Running the Image

Running on the host interface:

```console
$ docker run -d --net=host --name=u3ds dakskihedron/u3ds
```

Running using a bind mount for data persistence on container recreation:

```console
$ mkdir -p $(pwd)/u3ds
$ chmod 777 $(pwd)/u3ds # Makes sure the directory is writable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/u3ds:/home/steam/u3ds/ --name=u3ds dakskihedron/u3ds
```

## Configuration

### Environment Variables

The Dockerfile defines the following environment variables:

```dockerfile
INTERNET_SERVER=false
SERVER_ID="Default"
STEAM_BETA_BRANCH=""
```

- `INTERNET_SERVER` determines whether to run the server locally (default) or on the internet (for publicly-accessible servers). To run the server on the internet, pass the following:

  ```console
  -e INTERNET_SERVER=true
  ```

  **Note:** additional setup is required to make the server visible on the server list. Refer to the official [documentation](https://github.com/SmartlyDressedGames/U3-Docs/blob/master/ServerHosting.md#How-to-Configure-Server) for more details.

- `SERVER_ID` determines the name of the server directory. By default, the server directory will be named `Default`; the level data, config files, etc will be found under `u3ds/Servers/Default`. To change the name, pass the following:

  ```console
  -e SERVER_ID="new_server_name"
  ```

- `STEAM_BETA_BRANCH` allows you to install a beta branch. An empty entry defaults to the release branch. To install a beta branch, pass the following:

  ```console
  -e STEAM_BETA_BRANCH="name_of_branch"
  ```

### Server Files and Configs

To access the dedicated server within the Docker container:

```console
$ docker exec -it -w /home/steam/u3ds u3ds bash
```

This will allow bash access to the dedicated server in container. The level data, config files, etc for the server can be found under `Servers/[SERVER_ID]`.

For ease of access, it may be preferable to run the image with a [bind mount](#running-the-image) instead, so that the dedicated server can be access directly from the filesystem.

If you want to learn more about configuring an Unturned dedicated server, check out the official [documentation](https://github.com/SmartlyDressedGames/U3-Docs/blob/master/ServerHosting.md#How-to-Configure-Server). For a list of commands, check this [wiki page](https://wiki.smartlydressedgames.com/wiki/Console_commands).

## Acknowledgements

[@CM2Walki](https://twitter.com/cm2walki) - For Dockerising SteamCMD and various gameservers, which inspired me to make my own image.
