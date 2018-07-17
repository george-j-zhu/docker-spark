FROM jupyter/pyspark-notebook
LABEL MAINTAINER "Jiajun Zhu <george.choo@outlook.com>"

USER root

ENV PYTHON_LIBS=/opt/pythonlibs

RUN mkdir /opt/pythonlibs && \
    chown $NB_USER:$NB_GID $PYTHON_LIBS && \
    fix-permissions $PYTHON_LIBS

# install git tools and emacs25
RUN apt-get update && \
    apt-get install --yes apt-utils software-properties-common git-svn tig && \
    add-apt-repository ppa:kelleyk/emacs && \
    apt-get update && \
    apt-get remove --yes emacs && \
    apt-get install --yes emacs25 graphviz

# install ispell and markdown
RUN apt-get install --yes ispell markdown

# remove trash
RUN apt-get autoremove --yes

# TODO install elasticsearch-hadoop adapter
RUN cd $SPARK_HOME/jars && \
    wget http://central.maven.org/maven2/org/elasticsearch/elasticsearch-hadoop/6.2.4/elasticsearch-hadoop-6.2.4.jar

# install scala and SBT
RUN wget https://downloads.lightbend.com/scala/2.11.12/scala-2.11.12.deb && \
    dpkg -i scala-2.11.12.deb && \
    apt-get install --yes apt-transport-https curl && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
    apt-get update && \
    apt-get install sbt

USER $NB_USER

RUN mkdir $PYTHON_LIBS/mnt && \
    mkdir ~/workspace
ENV PYTHONPATH $PYTHON_LIBS:$PYTHON_LIBS/mnt:$PYTHONPATH

# Install Keras and opencv
RUN conda update conda && conda install --yes tensorflow-gpu keras opencv

# install jupyter scala plugin
RUN cd /tmp && git clone https://github.com/jupyter-scala/jupyter-scala.git && \
    cd jupyter-scala && ./jupyter-scala && cd .. && rm -dr jupyter-scala/

# upgrade pip
# make sure the following pip installations will not overwrite conda packages
RUN pip install --upgrade pip
# libs for distributed keras
RUN pip install -q xgboost elephas py4j spark-sklearn findspark
# Use the latest version of hyperopts (python 3.5 compatibility)
RUN pip install https://github.com/hyperopt/hyperopt/archive/master.zip
# install other packages for personal usage
RUN pip install git+https://github.com/s4w3d0ff/python-poloniex.git && \
    pip install -q tslearn && \
    pip install -q mlxtend
# install nbextentions for jupyter
RUN pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user

# install gcForest into pythonlibs dir
RUN git svn clone https://github.com/kingfengji/gcForest/trunk/lib/gcforest /opt/pythonlibs/gcforest

# install python checkers
RUN pip install -q pylint jedi importmagic autopep8
