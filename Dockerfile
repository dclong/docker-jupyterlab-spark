FROM dclong/jupyterhub-jdk

ARG spark=spark-2.4.4
ARG spark_hdp=$spark-bin-hadoop2.7
ARG mirror=http://us.mirrors.quenda.co/apache/spark/
ENV SPARK_HOME=/opt/$spark_hdp

RUN apt-get update \
    && apt-get install -y scala \
    && curl $mirror/$spark/$spark_hdp.tgz -o /$spark_hdp.tgz \
    && tar -zxvf /$spark_hdp.tgz -C /opt/ \
    && ln -svf $SPARK_HOME /opt/spark \
    && rm /$spark_hdp.tgz

RUN pip3 install toree pyspark findspark \
        optimuspyspark \
    && jupyter toree install --spark_home=$SPARK_HOME
