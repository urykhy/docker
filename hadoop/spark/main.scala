val textFile = spark.read.textFile("/root/task-input/4300-0.txt")
textFile.count()
textFile.filter(line => line.contains("License")).count()

var res = (spark.read.textFile("/root/task-input/*.txt")
          .flatMap(_.split(" "))
          .map((_, 1))
          .rdd
          .reduceByKey(_ + _)
          .sortBy[Int]( (pair:Tuple2[String,Int]) => -pair._2 )
          )
res.saveAsTextFile("spark-result.txt")
