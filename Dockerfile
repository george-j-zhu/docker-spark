FROM jupyter/pyspark-notebook
LABEL MAINTAINER "Jiajun Zhu <george.choo@outlook.com>"

USER root
ENV PYJ_LIB_VERSION py4j-0.10.1-src.zip

RUN mkdir /opt/pythonlibs
ENV PYTHONPATH /opt/pytonlibs:$SPARK_HOME/python/lib/$PYJ_LIB_VERSION:$PYTHONPATH
RUN apt-get install -yq --no-install-recommends git

USER $NB_USER

RUN pip install spark-sklearn && pip install findspark
# Install Keras
RUN conda install --yes 'tensorflow=1.3*'
RUN conda install --yes 'keras=2.0*'
# Use the latest version of hyperopts (python 3.5 compatibility)
RUN pip install https://github.com/hyperopt/hyperopt/archive/master.zip
# Elephas for distributed keras
RUN pip install elephas

RUN mkdir ~/workspace

# install dependent packages for personal usage
RUN pip install chainer && \
    pip install --upgrade --no-deps statsmodels && \
    pip install git+https://github.com/s4w3d0ff/python-poloniex.git
