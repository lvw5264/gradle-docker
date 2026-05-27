# Groovy Docker Example

This is a fixed version of https://oneuptime.com/blog/post/2026-02-08-how-to-containerize-a-groovy-application-with-docker/view , which needed some small tweaks to compile due to some missing files. 

The writer made a very good example of how to run Groovy as a microservice with docker.

## Build

To build, run the following command, or substitute docker with podman.

```
docker build -t yourgroovydockertag
```

## Usage

To expose on port 8080 and use -it to display logs, run the following command.

```bash
docker run -p 8080:8080 -it yourgroovydockertag
```

Then you can curl the following API endpoints.

```bash
$ curl http://localhost:8080/
Hello from Groovy in Docker!

$ curl http://localhost:8080/compute/16
{"limit":16,"primeCount":4,"largestPrime":13}
```
