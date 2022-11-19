# ft_service
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

# Master의 구성
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

# Node의 구성 
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

## 쿠버네티스 오브젝트
<details>
<summary>Pod(팟, 패드)</summary>
<div markdown="1">
- 가장 작은 배포 단위  
- 전체 클러스터에서 고유한 IP 할당  
- 여러개의 컨테이너가 하나의 Pod에 속할 수 있음  
![2021-04-07__12-49-44](https://user-images.githubusercontent.com/57505385/202782736-53e06340-d8a5-4ccc-968d-aafe7542c2c9.png)

### 필수적인 요소
- apiVersion : 오브젝트 버전
- kind : 종류(Pod, ReplicaSet, Depolyment, Service 등등)
- metadata : name과 label, annotation(주석)으로 구성
- spec : 리소스 종류마다 다름

#### example)
```
livenessProbe : 컨테이너가 살았는지 체크하는것
	httpGet:
		path:/not/exist
		port: 8080
	initialDelaySeconds : 시작하고 몇초뒤부터 검사할건가
	timeoutSeconds: 타임아웃은? #default 1
	periodSeconds : 몇초마다 실행할건가? #default 10
	failureThreshold : 몇번 실패하면 실패한거로 죽은거로 생각하나? #default 3
```
</div>
</details>
<details>
<summary>Replica Set(레플리카 셋)</summary>
<div markdown="1">
- 여러개의 Pod를 관리
- 새로운 Pod는 Template를 참고하여 생성
- 신규 Pod을 생성하거나 기존 Pod를 제거하여 원하는 수(Pod)를 유지
- 실제로는 ReplicaSet이 아닌 그 위에 감싸는 Deployment를 주로 사용함

![2021-04-07__12-49-44](https://user-images.githubusercontent.com/57505385/202782736-53e06340-d8a5-4ccc-968d-aafe7542c2c9.png)
</div>
</details>
