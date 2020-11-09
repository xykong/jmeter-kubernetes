build :
	./dockerimages.sh ccr.ccs.tencentyun.com/dockcross

create :
	./jmeter_cluster_create.sh jmeter
	./dashboard.sh

delete :
	./jmeter_cluster_delete.sh jmeter

reload : delete create
	@echo done
