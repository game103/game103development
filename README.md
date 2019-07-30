# Game 103 Development Environment
This is a development environment for the [Game 103 repository](https://github.com/game103/game103).

This will allow you to create a docker container based on debian strech to run Game 103. The database schema will be applied, but there will be no data by default.

# Prerequisites
1. Make sure you have [Docker](https://www.docker.com/get-started) installed
2. Make sure you are connected to the internet

# Instructions
1. Clone this repository
2. `cd` to this repository
3. Run `git submodule update --init game103` (this will make sure you have all the files for Game 103)
    a. If you would like to initialize all of the submodules in Game 103, `cd game103` and then run `git submodule update --init --recursive`
4. `cd game103` and run `git pull`
5. `cd ..`
4. Run `docker build -t game103 .` to build the image
5. Run `docker run -itd -p 80:80 -p 443:443 --name game103-instance game103 bash` to build the container
6. Run `docker cp game103-instance:/var/www/game103 .` to make sure the host's game103 directory matches that of the docker container's.
7. Now we will have to recreate the container, but this time with the host's game103 directory mounted.
    a. Stop the current container by running `docker stop game103-instance`
    b. Remove the container by running `docker rm game103-instance`
    c. Create the container again with the following command `docker run -itd -p 80:80 -p 443:443 -v $(pwd)/game103:/var/www/game103 --name game103-instance game103 bash`
6. Run `docker exec -d game103-instance /bin/sh -c "/var/www/game103/setup/restart.sh"` to make sure all the programs are started properly in the container
    a. If you would like to use the Instagram Poster submodule, run `docker exec -d game103-instance /bin/sh -c "cd /var/www/game103/scripts/instagram-poster; npm install"` to install the necessary npm modules
7. Visit localhost in your web browser, and you should be all set!
8. Any changes you make on disk should be reflected in the docker container.

# What's Missing?
1. This development environment uses a self-generated ssl certificate, but production uses Lets-Encrypt.
2. `/var/www/game103/modules/Constants.class.php` has several values that don't have values. Feel free to fill them out if you would like.
3. There is no data by default. You can either update `/var/www/game103/modules/Constants.class.php` to point to the production database if you know the credentials, or you can use the admins to generate your own data.
4. The submodules in the Game 103 repo are not automatically downloaded
5. The npm modules for the Instagram Poster submodule are also not included
6. If you connect to the production database, you won't have the webp images. To generate them, run `docker exec -d game103-instance /bin/sh -c "/var/www/game103/scripts/webp_maker.sh"`;

# Useful Commands
* `docker exec -it game103-instance bash` - gives you shell access to the docker container
* `docker start game103-instance` - starts the container
* `docker stop game103-instance` - stops the container

# Updating Game 103
If you update one of the files on Game 103 distributed out in `setup/distribute.sh` (including editing the database schema), you should be sure to run `setup/update.sh`, which will add your changes to the setup folder. Then, commit your changes.