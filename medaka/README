# medaka
a container for making medaka work on ONT sequencing hardware

For me:

```
docker build -f cuda9-medaka.Dockerfile -t cuda9-medaka .
docker tag <hash> samstudio8/cuda9-medaka:test
docker push samstudio8/cuda9-medaka
singularity build medaka-prom-test.sif docker://samstudio8/cuda9-medaka:test
singularity sign medaka-prom-test.sif
singularity push medaka-prom-test.sif library://samstudio8/default/cuda9-cudnn7-ubuntu1604-prom
```

For you (you're welcome):

```
singularity pull library://samstudio8/default/cuda9-cudnn7-ubuntu1604-prom:sha256.8ac4caaca73117601ac984ab59f431e272dba127a49319a8d9e727b973bb99db
```
