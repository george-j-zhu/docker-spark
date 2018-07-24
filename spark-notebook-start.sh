docker container rm spark-notebook
docker container run --name=spark-notebook -it \
       -v ~/workspace:/home/jovyan/workspace:cached \
       -v ~/workspace/python:/opt/pythonlibs/mnt:cached \
       -v ~/.m2:/home/jovyan/.m2:cached \
       -p 8888:8888 \
       georgezhu/spark-notebook start-notebook.sh \
       --ip=* --no-browser --port=8888 --NotebookApp.token='' /home/jovyan/workspace
