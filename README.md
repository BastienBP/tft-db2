graphdb in Docker
===

Run
---

```bash
docker run -it --privileged --name grapphdb -p 80:80  esgi/graphdb:latest
```

Build
---

```bash
docker build --rm --no-cache -t esgi/graphdb .
```

