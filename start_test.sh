#!/usr/bin/env bash
#Script created to launch Jmeter tests directly from the current terminal without accessing the jmeter master pod.
#It requires that you supply the path to the jmx file
#After execution, test script jmx file may be deleted from the pod itself but not locally.

working_dir="`pwd`"

#Get namesapce variable
tenant=`awk '{print $NF}' "$working_dir/tenant_export" 2>/dev/null`

if [ ! -n "$tenant" ];
then
	read -p "Enter the name of the pod namespace, this will be used to run the test: " tenant
	echo namespace = $tenant > "$working_dir/tenant_export"
fi

jmx="$1"
[ -n "$jmx" ] || read -p 'Enter path to the jmx file ' jmx

if [ ! -f "$jmx" ];
then
    echo "Test script file was not found in PATH"
    echo "Kindly check and input the correct file path"
    exit
fi

test_name="$(basename "$jmx")"

#Get Master pod details

master_pod=`kubectl get po -n $tenant | grep jmeter-master | awk '{print $1}'`

kubectl cp "$jmx" -n $tenant "$master_pod:/$test_name"

## Echo Starting Jmeter load test

test_report="$test_name $(date '+%Y-%m-%d %H:%M:%S')"

kubectl exec -ti -n $tenant $master_pod -- mkdir -p "/tmp/reports/${test_report}"
kubectl exec -ti -n $tenant $master_pod -- /bin/bash /load_test "$test_name" -l "/tmp/reports/${test_report}/result.jtl" -e -o "/tmp/reports/${test_report}/web"

mkdir -p "./reports/${test_report}" && cd "./reports/${test_report}"
kubectl cp -n $tenant "$master_pod:tmp/reports/${test_report}" .
