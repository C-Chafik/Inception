# Inception


## About the project

Subject : [en.subject.pdf](https://github.com/C-Chafik/Inception/files/9983179/en.subject.pdf)

The goal is to construct a webserver with handmade images, including a data-base, an https server, and a wordpress, in order to learn docker, docker-compose.

The infrastructure must be a look-like of this picture.


![Infrastructure](https://user-images.githubusercontent.com/76008303/201163220-f5534702-cc4d-444b-9764-ccec1bc861f9.png)


You can access the infrastructure from the port 443 only.

## Usage

You will need root privilege to run this project

Edit the envfiles with the right HOST_USER you are currently using

You will also need to add the hostname ```cmarouf.42.fr``` to ```127.0.0.1```
or just ```sudo make domain``` Optionnal.

----

Run the project

```
make
```

Pause the containers
```
make stop
```

Resume the containers
```
make resume
```

Wiping the project (This will delete the data-base and delete images)
```
make remove
```

Debugging
```
make debug (Will launch docker-compose without the detached mode)
make rebuild (Will rebuild the images without deleting the data-base)
```
