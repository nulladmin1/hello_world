# Python ```hello_world```

## Run it using:
### Poetry:
#### Run the app:
```poetry run hello-world```
#### Test the app:
```poetry run pytest```

### Nix (using ```poetry2nix```):
#### Run the app:
```nix run```

### Using Docker (using ```poetry```):
#### Build the Docker Image
```docker build -t "hello-world" .```
#### Run the app
```docker run -it hello-world```
