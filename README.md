# Resume

[![Build Status](https://github.com/adrn/cv/actions/workflows/build.yml/badge.svg)](https://github.com/vcalderon2009/resume/actions/workflows/create_resume.yml)
[![Latest PDF](https://img.shields.io/badge/PDF-latest-orange.svg)](https://vcalderon2009.github.io/resume/Victor_F_Calderon_Resume.pdf)


# Instructions

This repository corresponds to the set of files for creating a custom
*résumé* using LaTeX.

## Table of Contents

1. [Commands](#commands)
    - [Initialize development environment](#initialize-development-environment)
    - [Build Docker image for LaTeX generation](#build-docker-image-for-latex-generation)
    - [Create PDF for the specified user](#create-pdf-for-the-specified-user)
2. [Workflow](#workflow)


## Commands

In order to interact with the repository, one can use the `Makefile` for
easy access to the set of commands and instructions:

```bash
$: make help
Available rules:

build               Function to build the Docker image
clean               Removes artifacts from the build stage, and other common Python artifacts.
clean-build         Remove build artifacts
clean-latex         Clean Latex artifacts
clean-pyc           Removes Python file artifacts
clean-test          Remove test and coverage artifacts
create-environment  Creates the Python environment
create-envrc        Set up the envrc file for the project.
delete-environment  Deletes the Python environment
delete-envrc        Delete the local envrc file of the project
destroy             Remove ALL of the artifacts + Python environments
docker-login        Login to Docker
docker-logout       Logout from Docker
docker-prune        Prune Docker
git-flow-install    Install git-flow
init                Initialize the repository for code development
lint                Run the 'pre-commit' linting step manually
pip-upgrade         Upgrade the version of the 'pip' package
pre-commit-install  Installing the pre-commit Git hook
pre-commit-uninstall Uninstall the pre-commit Git hook
push                Push Docker image to repoisitory
requirements        Install Python dependencies into the Python environment
run                 Function to create PDF of the Latex File
show-params         Show the set of input parameters
sort-requirements   Sort the project packages requirements file
```

These commands can build the Docker images, compile the LaTeX files,
lint the seet of scripts and files in the directory, as well
as deploy the outputs to Github Pages.

### Initialize development environment

In order to first start developing, one must first set up the environment
used for compiling the documents, etc.

To do this, just run:

```bash
make init
```

This command will do the following:

1. Clean any leftover files
2. Create `direnv` file with specified variables.
3. Delete the project Anaconda environment, if it exists.
4. Create a brand new Anaconda (Python) environment
5. Install required Python packages.
6. Install packages use for linting and code-checking tasks.
7. Lint code
8. Install `git-flow`, if applicable.

### Build Docker image for LaTeX generation

In order to create the Docker image that gets used for compiling the
LaTeX files, one can run the following command:

```bash
make push SERVICE_NAME="resume"
```

This will create the Docker image and push the image to `Docker Hub`.

> **Note** :
>
>In order to push to *Docker Hub**, the following environment
> variables must be defined:
>
>- `DOCKER_USERNAME` : Username used in Docker-Hub
>- `DOCKER_TOKEN`: Personal Token used for pushing images to Docker-Hub.

### Create PDF for the specified user

In order to generate a PDF from the set of TeX files, one must run:

```bash
make PERSON_NAME=<PERSON_NAME> run
```
, where `<PERSON_NAME>` corresponds to the name of the user, for which
the PDF will be created.

This command will do the following:

1. Pull the `vcaln/docker-resume:latest` image from Docker-Hub
2. Run the command for the specified user.
3. Generate PDF in the `resume/<PERSON_NAME>` directory
4. Clean directory from leftover files.

Once this command is ran, the user should have a PDF with the set of new
changes.

## Workflow

The repository also comes with a built-in workflow for Github Actions.
The workflow can be found at:
- `.github/workflows/create_resume.yml`

The workflow will perform the following tasks:

1. Check that code can pass automatic linting (via `pre-commit`, etc.)
2. Make sure that the correct version of `docker-compose` is installed.
3. Run `make` command for generating PDF.
4. Copy output `.pdf` file to output directory.
5. Package the output directory and upload it as an artifact.
6. Deploy PDF file to Github Pages.
