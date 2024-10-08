FROM python:3.12.5-bullseye

RUN pip install poetry==1.8.3

WORKDIR /app

COPY poetry.lock pyproject.toml ./
COPY hello_world ./hello_world

RUN poetry install

ENTRYPOINT [ "poetry", "run", "hello-world" ]
