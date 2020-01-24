# medaka
a container for making medaka work on ONT sequencing hardware

For me:

```
docker build -f cuda9-medaka.Dockerfile -t cuda9-medaka .
docker tag cuda9-medaka samstudio8/cuda9-medaka:test
docker push samstudio8/cuda9-medaka
singularity build medaka-prom-test.sif docker://samstudio8/cuda9-medaka:test
singularity sign medaka-prom-test.sif # sign it with the right bloody key ffs
# singularity remote login
singularity push medaka-prom-test.sif library://samstudio8/default/cuda9-cudnn7-ubuntu1604-prom
```

For you (you're welcome):

```
singularity pull library://samstudio8/default/cuda9-cudnn7-ubuntu1604-prom:sha256.3aaf99eb6e0e53a667b221bb7209616b1d5a614f0bee7b5e5767ada505c58719
```

See also:

https://hub.docker.com/r/samstudio8/cuda9-medaka/tags
https://cloud.sylabs.io/library/_container/5d6e7c39cb093ee1142b8462
