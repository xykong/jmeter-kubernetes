build :
	./dockerimages.sh ccr.ccs.tencentyun.com/dockcross


create :
	./jmeter_cluster_create.sh jmeter


delete :
	./jmeter_cluster_delete.sh jmeter


reload : delete create
	@echo done


# debug :
# 	sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# 	apt-get update
# 	apt-get install -y procps


kill-slaves :
	@kubectl get po -n $$(awk '{print $$NF}' tenant_export) | \
		grep jmeter-slaves | awk '{print $$1}' | \
		xargs -I{} kubectl -n $$(awk '{print $$NF}' tenant_export) exec -ti {} -- bash -c \
		'cd /proc && shopt -s extglob && echo $$(echo +([0-9])) | xargs -I{}  bash -c "kill {}"' ||\
		true >/dev/null 2>&1
	@echo done
