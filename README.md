# ft_service

## 목적
- 다양한 서비스 인프라를 Kubernetes를 이용하여 구성
- 다중 서비스 클러스터를 설정
- 각 컨테이너는 성능상의 이유로 Alpine Linux를 사용하여 빌드
- setup.sh에서 호출되는 Dockerfile이 작성되어 있어야함
- 사용할 이미지는 직접 구축해야함. 이미 빌드된 이미지를 가져오거나 DockerHub 사용금지

## 필수 구현부
- Kubernetes 웹 대시 보드. 이렇게하면 클러스터를 관리하는 데 도움이됩니다.
- 서비스의 외부 액세스를 관리하는 로드 밸런서.  클러스터의 유일한 진입 점입니다. 
다음과 관련된 포트를 유지해야합니다.
서비스 (Grafana의 경우 IP : 3000 등). Load Balancer는 단일 IP를 갖습니다.
- MySQL 데이터베이스에서 작동하는 포트 5050에서 수신하는 WordPress 웹 사이트.
두 서비스 모두 별도의 컨테이너에서 실행되어야합니다.
WordPress 웹 사이트에는 여러 사용자와 관리자가 있습니다. 
Wordpress에는 자체 nginx 서버가 필요합니다.
로드 밸런서는이 서비스로 직접 리디렉션 할 수 있어야합니다.
- phpMyAdmin, 포트 5000에서 수신 대기하고 MySQL 데이터베이스와 연결됩니다.
PhpMyAdmin에는 자체 nginx 서버가 필요합니다.
로드 밸런서는이 서비스로 직접 리디렉션 할 수 있어야합니다.
- 포트 21에서 수신 대기하는 FTPS 서버.
- InfluxDB 데이터베이스와 연결된 포트 3000에서 수신 대기하는 Grafana 플랫폼.
Grafana는 모든 컨테이너를 모니터링합니다.
서비스 당 하나의 대시 보드를 만들어야합니다.
InfluxDB와 grafana는 두 개의 별개 컨테이너에 있습니다.
- 모든 컨테이너는 구성 요소 중 하나가 충돌하거나 중지되는 경우 다시 시작해야합니다.
- 서비스에 대한 각 리디렉션이로드 밸런서를 사용하여 수행되는지 확인하십시오.
FTPS, Grafana, Wordpress, PhpMyAdmin 및 nginx의 종류는 "LoadBalancer"여야합니다.
Influxdb 및 MySQL의 종류는 "ClusterIP"여야합니다. 다른 항목이있을 수 있지만 해당 항목은 없습니다.
"NodePort"종류 일 수 있습니다.
- 노드 포트 서비스 사용,
Ingress Controller 객체 또는 kubectl port-forward 명령은 금지됩니다.
Load Balancer는 클러스터의 유일한 진입 점이어야합니다.


## What is Kubernetes?
- 쿠버네티스는 컨테이너 오케스트레이션
- 컨테이너 오케스트레이션은 컨테이너의 배포, 관리, 확장, 네트워킹을 자동화합니다 (컨테이너 관리 도구입니다)
- 현재 서비스는 수많은 컨테이너들로 이루어져있고 서비스가 커지다보면 컨테이너도 많아지는데 이를 관리할 도구가 필요해서 나왔습니다

## 쿠버네티스가 제공하는것
- **서비스 디스커버리와 로드 밸런싱** 쿠버네티스는 DNS 이름을 사용하거나 자체 IP 주소를 사용하여 컨테이너를 노출할 수 있다. 컨테이너에 대한 트래픽이 많으면, 쿠버네티스는 네트워크 트래픽을 로드밸런싱하고 배포하여 배포가 안정적으로 이루어질 수 있다.
- **스토리지 오케스트레이션** 쿠버네티스를 사용하면 로컬 저장소, 공용 클라우드 공급자 등과 같이 원하는 저장소 시스템을 자동으로 탑재 할 수 있다.
- **자동화된 롤아웃과 롤백** 쿠버네티스를 사용하여 배포된 컨테이너의 원하는 상태를 서술할 수 있으며 현재 상태를 원하는 상태로 설정한 속도에 따라 변경할 수 있다. 예를 들어 쿠버네티스를 자동화해서 배포용 새 컨테이너를 만들고, 기존 컨테이너를 제거하고, 모든 리소스를 새 컨테이너에 적용할 수 있다.
- **자동화된 빈 패킹(bin packing)** 컨테이너화된 작업을 실행하는데 사용할 수 있는 쿠버네티스 클러스터 노드를 제공한다. 각 컨테이너가 필요로 하는 CPU와 메모리(RAM)를 쿠버네티스에게 지시한다. 쿠버네티스는 컨테이너를 노드에 맞추어서 리소스를 가장 잘 사용할 수 있도록 해준다.
- **자동화된 복구(self-healing)** 쿠버네티스는 실패한 컨테이너를 다시 시작하고, 컨테이너를 교체하며, '사용자 정의 상태 검사'에 응답하지 않는 컨테이너를 죽이고, 서비스 준비가 끝날 때까지 그러한 과정을 클라이언트에 보여주지 않는다.
- **시크릿과 구성 관리** 쿠버네티스를 사용하면 암호, OAuth 토큰 및 SSH 키와 같은 중요한 정보를 저장하고 관리 할 수 있다. 컨테이너 이미지를 재구성하지 않고 스택 구성에 시크릿을 노출하지 않고도 시크릿 및 애플리케이션 구성을 배포 및 업데이트 할 수 있다

## 쿠버네티스 아키텍처
- 구조도  
![2021-04-06__9-44-08](https://user-images.githubusercontent.com/57505385/202781127-8ec95f0b-586b-4f0e-881f-b8bad8638061.png)
<details>
<summary>쿠버네티스 아키텍처 (접기/펼치기)</summary>
<div markdown="1">

## Master의 구성
### 1. 스케줄러
- 새로 생성된 Pod를 감지하고 실행할 노드를 선택함
- 노드의 현재 상태와 Pod의 요구사항을 체크함
- ex)Pot이 요구하는 사항을 체크하여 노드를 할당해줌

### 2. 컨트롤러
- 논리적으로 다양한 컨트롤러가 존재
- ex) 복제 컨트롤러, 노드 컨트롤러, 엔드포인트 컨트롤러 .. 등등
- 끊임 없이 상태를 체크하고 원하는 상태를 유지
- 복잡성을 낮추기 위해 하나의 프로세스로 실행

### 3. API 서버
- 상태를 바꾸거나 조회
- etcd와 유일하게 통신하는 모듈
- REST API형태로 제공
- 권한을 체크하여 적절한 권한이 없을 경우 요청을 차단
- 관리자 요청 뿐 아니라 다양한 내부 모듈과 통신
- 수평으로 확장되도록 디자인

### 4. etcd
- 모든 상태와 데이터를 저장.
- 분산 시스템으로 구성하여 안전성을 높임 (하나가 뻗어도 괜찮도록)
- 가볍고 빠르면서 정확하게 설계 (일관성, 동시에 데이터를 변경해도 하나의 값을 일치하게 가짐)
- Key - Value 형태로 되어있음
- TTL (Time to live), Watch같은 부가기능 제공
- 백업은 필수

## Node의 구성 
### 1. kubelet
- 각 노드에서 실행됨.
- Pod을 실행/중지하고 상태를 체크
- CRI (Container Runtime Interface)
- ex) docker, containerd, CRIO-O 등등

### 2. Proxy
- 네트워크 프록시와 부하분산역할
- 성능상의 이유로 별도의 프록시 프로그램을 실행하지 않고 iptables 또는 IPVS를 사용

</div>
</details>

## 쿠버네티스 오브젝트 구성과 설명
- Pod
- Replica Set
- Deployment
- Service
- Wordload
- Volume
- ConfigMap
- Secret 
- 각 구성에 대한 설명과 정리 : https://enocent.notion.site/11d6bd9ec06d419c882092913a61e098

## 흐름
1. 사용자가 Pod을 API Server에 요청
2. API Server가 etcd에 Pod을 요청 (etcd에서 pod - 생성요청 으로 적어둠)
3. Controller에서 새 Pod이 있는지 요청확인중 생성요청이 확인되면 API Server가 Controller에 Pod할당한 후 etcd에 'pod-할당요청' 으로 바꿈.
4. Scheduler는 '새로운 Pod할당'이 있는지 체크하다 새 할당요청이 있었으면 'Pod를 node에 할당'
5. API Server는 스케줄러의 요청을 들어준 후 etcd에 노드 할당되었다고 알림( etcd에서는 'pod- 노드할당 / 미실행' 으로 변경)
6. Kubelet은 Node에 미실행 된 Pod이 있는지 체크하고 (API Server를 통해) 미실행된 Pod이 있으면 Pod 생성
7. Kubelet이 Pod을 생성한 후 API Server는 etcd에 Pod생성이라고 알려줌 (etcd는 node 할당/실행중) 으로 바꿈.

## yaml문법
- key : value로 구성
- 기본적으로 2칸 들여쓰기
- 배열은 - 로 표시

```c
apiVersion: v1
kind: Pod
metadata: 
  lable: kk
```

- 주석은 #으로 표시

```c
#commnet
awefawfe #comment
```

- 참 거짓은 true, false, yes, no
- 숫자와 . 로 표현된것은 정수 또는 실수로 표현 가능
- 문자열로만 쓰고싶은건 "1.2" 이렇게 가능
- 줄바꿈 |
- 줄바꿈 마지막줄 제외 |-
- 줄바꿈 중간빈줄 제외 >

- 문자열에 : 가 들어가는건 무조건 ""로 묶어줘야함.
- 한 yaml에 여러개를 넣고싶을때 - - -를 사용함 (- 3개)

## 쿠버네티스 명령어
| - | 명령어 | 
| --- | --- |
| 버전확인 | minikube version |
| 가상머신 시작 | minikube start —driver=docker | 
| 특정 k8s버전 실행 | minikube start —kubernetes-version=v1.20.0 |
| 상태 확인 | minikube status |
| 정지 | minikube stop |
| 삭제 | minikube delete |
| ssh 접속 | minikube ssh | 
(접속한뒤 docker ps 명령어로 쿠버네티스에 필요한 모듈들이 실행된걸 볼수있음)
| ip 확인 | minikube ip |


## kubectl 명령어
※ kubectl api-resources → kubectl에서 사용할 수있는 명령어들이 쭉 나옴

- apply : 원하는 상태를 적용. 보통 -f 옵션으로 파일과 함께 사용

```c
kubectl apply -f [파일명 또는 URL]
URL을 입력시 해당 URL에서 파일을 내려받아서 적용함
```

- get : 리소스 목록을 보여줍니다

```c
kubectl get [TYPE]
`,`를 이용해서 여러개 볼 수 있음.
all = pod, service, deployment, replicaset, job을 보여줌 (대표적인 리소스)
-o wide = 출력형식 
-o yaml = yaml로 자세히
-o json = json으로 자세히
kubectl get pod --show-lables = lable도 표현
```

- describe : 리소스의 상태를 자세하게 보여줍니다.

```c
kubectl describe [type]/[name] 또는 [type] [name]
특정 리소스의 상태가 궁금하거나 
생성이 실패한 이유를 확인할 때 주로 사용
event 탭이 중요
```

- delete : 리소스를 제거합니다

```c
kubectl delete [type]/[name] 또는 [type] [name]
```

- logs : 컨테이너의 로그를 봅니다.

```c
kubectl logs [pod_name]
실시간 로그를 보기 -f 옵션
하나의 Pod에 여러개의 컨테이너가 있다면 -c 옵션으로 컨테이너 지정
```

- exec : 컨테이너에 명령어를 전달합니다. 컨테이너에 접근할때 주로 사용합니다

```c
kubectl exec [-it] [pod_name] -- [command]

컨테이너 접속
: kubectl exec -it wordpress-5~~~ -- bash
```

- config : kubectl 설정을 관리합니다

```c
# 현재 컨텍스트 확인
kubectl config current-context

# 컨텍스트 설정
kubectl config use-context minikube
```

- 특정  오브젝트 설명 보기 ( kubectl explain pod )

echo "alias k=`kubectl` > ~./bashrc

source ~./bashrc

-------------------

## livenessProbe (서비스가 살아있는지 체크)
### 3가지 방법 제공
```
3가지 방식 제공
1. Command probe

livenessProbe:
  exec:
    command:
    - pgrep
    - vsftpd
$? = 0 정상
   = 1 비정상

2. HTTP probe

readinessProbe:
  httpGet:
    path: /readiness
    port: 8080
200 ~ 300 사이 응답 = 정상
나머지 = 비정상

3. TCP probe
livenessProbe:
  tcpSocket: 
    port: 8080
    initialDelaySeconds: 5
    periodSeconds: 5
연결성공 = 정상
연결실패 = 비정상
```
- 참조 : https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
------------------

## 진행하면서 어려웠던(?), 잘 진행이 되지 않았던 부분
### 1. Dockerfile 구성부분
https://enocent.notion.site/ea2db116a61249a9aa9b61f0a3cdf2f8
### 2. ftps 설정 
https://enocent.notion.site/ftps-3d39a9a1108e46dc9f085f9df1c02a2e
### 3. grafana provisioning
참조 : https://ichi.pro/ko/ganpyeonhan-grafana-mich-docker-compose-seoljeong-229759174634515

------------------------------

