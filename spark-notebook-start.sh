docker container rm spark-notebook
docker container run --name=spark-notebook -it \
       -v /home/j-zhu/workspace:/home/jovyan/workspace:cached \
       -v /home/j-zhu/workspace/python:/opt/pythonlibs/mnt:cached \
       -p 8888:8888 \
       georgezhu/spark-notebook start-notebook.sh \
       --ip=* --no-browser --port=8888 --NotebookApp.token='' /home/jovyan/workspace
