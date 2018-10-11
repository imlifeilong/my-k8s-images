#!/bin/bash
libname=imlifelong
dk=/usr/bin/docker
images=(k8s.gcr.io/kube-apiserver:v1.12.1 k8s.gcr.io/kube-controller-manager:v1.12.1 k8s.gcr.io/kube-scheduler:v1.12.1 k8s.gcr.io/kube-proxy:v1.12.1 k8s.gcr.io/pause:3.1 k8s.gcr.io/etcd:3.2.24 k8s.gcr.io/coredns:1.2.2)

for im in ${images[@]};do
    name=${libname}/`echo $im | awk -F '/' '{print $2}' | awk -F ':' '{print $1}'`
    $dk pull $name
    $dk tag $name $im
    $dk rmi $name
done

kubeadm join 192.168.137.200:6443 --token cl60h7.y4o6vpizk64j5cz6 --discovery-token-ca-cert-hash sha256:1fda5b34ecd3abb044ff137e5e74afbeea95cfdb881038ed78961b8d2ef00017
