# Setup instructions from http://blog.cloudera.com/blog/2014/08/how-to-use-ipython-notebook-with-apache-spark/
import os
import sys
 
spark_home = os.environ.get('SPARK_HOME', None)
if not spark_home:
    raise ValueError('SPARK_HOME environment variable is not set')
pyspark_submit_args = "--master spark://spark-master:7077"
if not "pyspark-shell" in pyspark_submit_args: pyspark_submit_args += " pyspark-shell"
os.environ["PYSPARK_SUBMIT_ARGS"] = pyspark_submit_args
sys.path.insert(0, os.path.join(spark_home, 'python'))
sys.path.insert(0, os.path.join(spark_home, 'python/lib/py4j-0.8.2.1-src.zip'))
execfile(os.path.join(spark_home, 'python/pyspark/shell.py'))
