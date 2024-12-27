# Python Template 🐍
[![PyPI version](https://img.shields.io/pypi/v/python-template-zuppif)](https://pypi.org/project/python-template-zuppif/)

A template for a python project for 2025

Features:
- [x] 🛠️ configuration in a single file [`pyproject.toml`](pyproject.toml)
- [x] 📦 [`uv`](https://docs.astral.sh/uv/) as package manager
- [x] 💅 [`ruff`](https://docs.astral.sh/ruff/) for linting and formatting
- [x] 🧪 [`pytest`](https://docs.pytest.org/en/stable/) 
- [x] 🧹 [`Makefile`](Makefile) with code quality checks
- [ ] 📚 auto doc generation
- [x] 🐳 CI/CD Optimized Docker Image runs when a new *release* is created pushing to gh registry
- [x] 🦾 GitHub actions:
    - [x] auto publish to [`pypi`](https://pypi.org/) on push on `main`
    - [ ] auto creating a new tag on push on `main`, sync versions
    - [x] run `tests` and `lint` on `dev` and `main` when a PR is open

## Getting started

### Installation

To set it up and run

```bash
uv venv
uv sync
```
Then

```bash
python main.py
```

Will output a random joke

```
Why did the cow in the pasture get promoted at work? ...  Because he is OUT-STANDING in his field!
```

### Development

You can install in `editable` mode the library

```bash
uv pip install -e .
```

You can now run, for example, a function defined as `scripts` in the [`pyproject.toml`](pyproject.toml)

```bash
make_me_laugh
```

### Linting

```
ruff check
```


### Formatting

```
ruff format
```

## CI/CD

### Tests
Tests inside `/tests` are run using [`pytest`](https://docs.pytest.org/en/stable/) on PR both on `dev` and `main`

### Publish Package
 In order to publish to [pypi](https://pypi.org/) you need to create a secret called `UV_PUBLISH_TOKEN` with your [pypi access token](https://pypi.org/manage/account/) under **API tokens**.


### Docker
[`Dockerfile`](Dockerfile) contains a multi stage build that uses `--compile-bytecode` to compite your package. For this example, the resulting image is just

```bash
docker build -t python-template .
```

```
REPOSITORY        TAG       IMAGE ID       CREATED          SIZE
python-template   latest    1ded7d260b1c   58 seconds ago   55.4MB
```

The image is build using the [`build`](.github/workflows/build.yml) workflow when a new *relaese* is created
