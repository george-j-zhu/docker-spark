# Personal Dockerfile for Machine Learning and BigData processing

This is my first attempt to move my jupyter notebook developement environment into Docker.<br>
If you reached out here for exploring Jupyter Docker images, I recommend you to check the following repository.<br>
[https://github.com/jupyter/docker-stacks](https://github.com/jupyter/docker-stacks)<br>

## What it provides
- pyspark(Spark for python)
- conda python3
- scikit-learn and spark-sklearn
- keras
- Elephas
- spark
- matplotlib, pandas, jupyter notebook

## Building

```
docker image build -t [docker image name] .
```

## How to use
After building the Dockerfile as a Docker image, run the following command to start a new docker container for Jupyter Notebook.<br>

```
docker container run --name=[docker container name] -it -v [host folder]:/home/jupyter/workspace -p [host port]:8888 [docker image name]
```

* --name&nbsp;&nbsp;[docker container name]<br>
* -it&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run container in iteractive mode using tty connection.<br>
* -v&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mount a [host folder] as /home/jupyter/workspace in the container. workspace folder is the root directory of jupyter notebook.<br>
* -p&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bind container port 8888 to the [host port].<br>

or you can use spark-notebook-start.sh to run a container instance.<br>
Please note that spark-notebook-start.sh will start a jupyter notebook server without any authentification.

## PYTHONPATH
As I use personal libraries in my daily work, I mount the my libraries onto a PYTHONPATH volume in the docker container.

```
-v [host PYTHONPATH folder]:/opt/pythonlibs
```

## Connect to Spark Cluster
Move to the dir where docker-compose.yml locates.
Bring up a spark cluster by the following command
```
docker-compose up
```

Remember to modify docker-compose to fit your needs. In addition, if you'd like to use Jupyter Notebook, just 'docker exec' your master container and start a notebook server.
