<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Papermerge, verified and packaged by Elestio

[Papermerge](https://github.com/papermerge/docker) is a open source document management system designed to work with scanned documents (also called digital archives).

<img src="https://github.com/elestio-examples/papermerge/raw/main/papermerge.png" alt="Papermerge" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/papermerge">fully managed papermerge</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/papermerge/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/papermerge)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/papermerge.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./pgdata
    chown -R 1000:1000 ./pgdata

Run the project with the following command

    ./scripts/preInstall.sh
    docker-compose up -d

You can access the Web UI at: `http://your-domain:12000`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.9"

    x-backend: &common
    image: papermerge/papermerge:${SOFTWARE_VERSION_TAG}
    restart: always
    environment:
        PAPERMERGE__SECURITY__SECRET_KEY: ${PAPERMERGE__SECURITY__SECRET_KEY}
        PAPERMERGE__AUTH__USERNAME: ${PAPERMERGE__AUTH__USERNAME}
        PAPERMERGE__AUTH__PASSWORD: ${PAPERMERGE__AUTH__PASSWORD}
        PAPERMERGE__AUTH__EMAIL: ${ADMIN_EMAIL}
        PAPERMERGE__DATABASE__URL: postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}
        PAPERMERGE__REDIS__URL: redis://redis:6379/0
        PAPERMERGE__OCR__DEFAULT_LANGUAGE: ${PAPERMERGE__OCR__DEFAULT_LANGUAGE}
    volumes:
        - ./storage/index_db:/core_app/index_db
        - ./storage/media:/core_app/media
    services:
    web:
        <<: *common
        ports:
            - "172.17.0.1:12000:8000"
        depends_on:
            - redis
            - db
    worker:
        <<: *common
        command: worker
    redis:
        restart: always
        image: elestio/redis:6.0
    db:
        restart: always
        image: elestio/postgres:15
        environment:
            POSTGRES_USER: ${POSTGRES_USER}
            POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
            POSTGRES_DB: ${POSTGRES_DB}
        ports:
            - 172.17.0.1:56225:5432
        volumes:
            - ./storage/postgres_data:/var/lib/postgresql/data/

### Environment variables

|               Variable                |   Value (example)    |
| :-----------------------------------: | :------------------: |
|         SOFTWARE_VERSION_TAG          |        latest        |
| PAPERMERGE\_\_SECURITY\_\_SECRET_KEY  | your-strong-password |
|   PAPERMERGE\_\_MAIN\_\_SECRET_KEY    | your-strong-password |
|       DJANGO_SUPERUSER_PASSWORD       |    your-password     |
|       DJANGO_SUPERUSER_USERNAME       |    your@email.com    |
|    PAPERMERGE\_\_AUTH\_\_USERNAME     |        admin         |
|    PAPERMERGE\_\_AUTH\_\_PASSWORD     |    your-password     |
|             POSTGRES_USER             |       postgres       |
|           POSTGRES_PASSWORD           |    your-password     |
|              POSTGRES_DB              |      papermerge      |
|            ADMIN_PASSWORD             |    your-password     |
|              ADMIN_EMAIL              |   admin@email.com    |
| PAPERMERGE\_\_OCR\_\_DEFAULT_LANGUAGE |         eng          |

# Maintenance

## Logging

The Elestio papermerge Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://docs.papermerge.io/3.0/">Papermerge documentation</a>

- <a target="_blank" href="https://github.com/papermerge/docker">Papermerge Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/papermerge">Elestio/Papermerge Github repository</a>
