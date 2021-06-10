# QUick revision 


## PYthon flask and JSP based application 

<img src="rev.png">

## Webapp info 

<img src="webinfo.png">

## Python Flask application build 

```
❯ ls
Dockerfile       README.md        demo.py          requirements.txt static
❯ docker  build  -t  dockerashu/ciscoflask:appv1  .
Sending build context to Docker daemon  87.04kB
Step 1/7 : FROM python
 ---> 5b3b4504ff1f
Step 2/7 : COPY . /app
 ---> f26780fe5180
Step 3/7 : WORKDIR /app
 ---> Running in 3fa5ad4fc454
Removing intermediate container 3fa5ad4fc454
 ---> 1f887d6748b9
Step 4/7 : RUN pip install -r requirements.txt
 ---> Running in 2dd4d5970afb
 
 
 ```

### Image got push to dockerhub 

## switching to k8s cluster 

```
❯ kubectl  config  get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
*         minikube                      minikube     minikube           default
❯ kubectl  config  use-context  kubernetes-admin@kubernetes
Switched to context "kubernetes-admin@kubernetes".
❯ 
❯ kubectl  get  nodes
NAME                           STATUS   ROLES                  AGE   VERSION
ip-172-31-82-89.ec2.internal   Ready    control-plane,master   25h   v1.21.1
ip-172-31-85-18.ec2.internal   Ready    <none>                 25h   v1.21.1
ip-172-31-86-48.ec2.internal   Ready    <none>                 25h   v1.21.1
ip-172-31-89-48.ec2.internal   Ready    <none>                 25h   v1.21.1
❯ kubectl  get  po
NAME           READY   STATUS    RESTARTS   AGE
ashupod3       1/1     Running   1          18h
derpaulpod3    1/1     Running   1          18h
khalidpod111   1/1     Running   1          18h
khalidpod3     1/1     Running   1          17h
manishapod3    1/1     Running   1          17h
sushilpod1     1/1     Running   1          18h
varunpod2      1/1     Running   1          18h
vishnupod-1    1/1     Running   1          17h
vishnupod111   1/1     Running   1          18h
❯ kubectl  delete  pods --all
pod "ashupod3" deleted
pod "derpaulpod3" deleted
pod "khalidpod111" deleted
pod "khalidpod3" deleted
pod "manishapod3" deleted
pod "sushilpod1" deleted
pod "varunpod2" deleted


```


### Generating YAML file 

```
 kubectl   run  ashuflaskpod1   --image=dockerashu/ciscoflask:appv2  --port 5000 --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashuflaskpod1
  name: ashuflaskpod1
spec:
  containers:
  - image: dockerashu/ciscoflask:appv2
    name: ashuflaskpod1
    ports:
    - containerPort: 5000
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
❯ kubectl   run  ashuflaskpod1   --image=dockerashu/ciscoflask:appv2  --port 5000 --dry-run=client -o yaml  >flask.yaml

```

### Deploying POD 

```
❯ ls
ashupod1.yaml flask.yaml    mypod.yml     webpo.yml
❯ kubectl  apply -f   flask.yaml --dry-run=client
pod/ashuflaskpod1 created (dry run)
❯ kubectl  apply -f   flask.yaml
pod/ashuflaskpod1 created

```

### checking label of POds 

```
❯ kubectl  get   po --show-labels
NAME               READY   STATUS    RESTARTS   AGE     LABELS
ashuflaskpod1      1/1     Running   0          9m41s   run=ashuflaskpod1
derpaulflaskpod1   1/1     Running   0          8m15s   run=derpaulflaskpod1
khalidflaskpod1    1/1     Running   0          3m42s   run=khalidflaskpod1
manishaflaskpod1   1/1     Running   0          11m     run=manishaflaskpod1
sushil-flask-pod   1/1     Running   0          3m3s    run=sushil-flask-pod
varunflaskpod1     1/1     Running   0          13m     run=varunflaskpod1
vishnuflaskpod1    1/1     Running   0          8m53s   run=vishnuflaskpod1


❯ kubectl  get   po   ashuflaskpod1   --show-labels
NAME            READY   STATUS    RESTARTS   AGE     LABELS
ashuflaskpod1   1/1     Running   0          9m53s   run=ashuflaskpod1

```

### Nodeport service 

<img src="np.png">

### nodeport service understanding 

<img src="nps.png">

### creating nodeport service 

<img src="createnp.png">


```
❯ kubectl  create  service   nodeport  ashusvc1   --tcp   1234:5000  --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashusvc1
  name: ashusvc1
spec:
  ports:
  - name: 1234-5000
    port: 1234
    protocol: TCP
    targetPort: 5000
  selector:
    app: ashusvc1
  type: NodePort
status:
  loadBalancer: {}
❯ kubectl  create  service   nodeport  ashusvc1   --tcp   1234:5000  --dry-run=client -o yaml  >flaskappsvc.yml

```

### deploy service 

```
❯ kubectl  apply -f  flaskappsvc.yml  --dry-run=client
service/ashusvc1 created (dry run)
❯ kubectl  apply -f  flaskappsvc.yml
service/ashusvc1 created
❯ 
❯ kubectl   get  service
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
ashusvc1     NodePort    10.98.145.129    <none>        1234:30698/TCP   7s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP          25h
manishsvc1   NodePort    10.110.245.199   <none>        1234:30234/TCP   79s
sushilsvc1   NodePort    10.108.146.240   <none>        1234:30536/TCP   7s


```


