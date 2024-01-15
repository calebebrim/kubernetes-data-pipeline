REGISTRY = "k3d-myregistry.localhost:12345"

load('ext://helm_remote', 'helm_remote')
load('ext://namespace', 'namespace_create', 'namespace_inject')

def setup_registry():
    reg = os.environ.get('MY_PERSONAL_REGISTRY', REGISTRY)
    if reg:
        # docker login -u admin -p admin localhost:5000
        default_registry(host_from_cluster=reg, host=REGISTRY)

def cluster_folder():
    PATH = "./1 - cluster"

    cmd = 'cd "{}" && make create'.format(PATH)
    rm = 'cd "{}" && make delete'.format(PATH)
    local(cmd)
    # k8s_custom_deploy(
    #     name='k8s',
    #     apply_cmd=cmd,
    #     delete_cmd=rm,
    #     deps=[])

def monitoring_folder():
    PATH = "./5 - monitoring"
    
    cmd = 'cd "{}" && make add-repo install'.format(PATH)
    
    local_resource(
        name='monitoring-folder',
        cmd=cmd,
        allow_parallel=True)


def grafana(base):
    cmd = 'cd "{}" && make install-kafka-cluster'.format(base)
    
    local_resource(
        name='kafka-cluster',
        cmd=cmd,
        allow_parallel=True)

def prometheus():
    pass


def data_mesh_folder():
    PATH = "./6 - data-mesh"
    kafka(PATH)


def install_strinzi_operator(base = ""):
    cmd = 'cd "{}" && make install-operator-helm'.format(base)
    
    local_resource(
        name='strimzi-operator',
        cmd=cmd,
        allow_parallel=False, 
        deps=["monitoring-folder"])

def install_kafka_cluster(base = ""):
    cmd = 'cd "{}" && make install-kafka-cluster'.format(base)
    rm = 'cd "{}" && make delete-kafka-cluster'.format(base)
    
   
    local_resource(
        name='kafka-cluster',
        cmd=cmd,
        allow_parallel=False, 
        deps=["monitoring-folder", "strimzi-operator"])

def install_kafka_tools(base):
    cmd = 'cd "{}" && make install-kafka-tools'.format(base)
    
    
   
    local_resource(
        name='kafka-tools',
        cmd=cmd,
        allow_parallel=False, 
        deps=["kafka-cluster"])
    
def install_kafka_connect(base):
    image = "{}/kafka-connect".format(REGISTRY)
    context = "{}/connect-custom".format(base)
    docker_file = "{}/Dockerfile".format(context)
    namespace = "data-mesh"
   

    connect_install = read_yaml_stream('{}/configuration/connect/install.yaml'.format(base))
    connect_install[0]["spec"]["image"] = "kafka-connect"
    connect_install[0]["metadata"]["name"] = "kafka-connect"
    for o in connect_install:
        o["metadata"]["namespace"] = namespace
    
  
    k8s_yaml(encode_yaml_stream(connect_install))
    
    # print(encode_yaml_stream(connect_install))
    
    docker_build(
        "kafka-connect",
        context,
        dockerfile=docker_file
    )

    k8s_kind(
        'KafkaConnect', 
        image_json_path='{.spec.image}', 
        pod_readiness='wait', 
        
    )
    

    k8s_resource(
        "kafka-connect",
        "kafka-connect-cluster",
        objects=["connect-metrics:configmap"],
        trigger_mode=TRIGGER_MODE_MANUAL,
        port_forwards=[
            port_forward(8083,8083, name="kafka-connect-api")
        ]

    )
  

def kafka(base):
    install_strinzi_operator(base)
    install_kafka_cluster(base)
    install_kafka_connect(base)
    install_kafka_tools(base)

    

    
def create_namespaces():
    
    namespace_create("strimzi-kafka", labels=[{"monitoring":"prometheus"}])
    namespace_create("data-mesh", labels=[{"monitoring":"prometheus"}])
    
    k8s_resource(
        new_name="namespaces",
        trigger_mode=TRIGGER_MODE_MANUAL,
        objects=[
            "strimzi-kafka:namespace",
            "data-mesh:namespace"
        ]
    )

def main():
    setup_registry()
    create_namespaces()
    monitoring_folder()
    data_mesh_folder()


main()