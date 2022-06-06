#CONFIGURE CLUSTER
cd cluster-config

#CREATE CLUSTER
sudo kind create cluster --config=kind-config.yaml

#ADD METRIC SERVER
sudo kubectl apply -f metric-server-3.8.2.yaml

#ADD DASHBOARD
sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
sudo kubectl apply -f dashboard.yaml
sudo kubectl -n kubernetes-dashboard create token admin-user > output.txt

#EXIT
cd ..



#CONFIGURE DATABASE
cd mssql-config
sudo kubectl apply -f mssql.yaml

#EXIT
cd ..



#CONFIGURE EFAPP
cd efapp-config
sudo kubectl apply -f efapp.yaml

#EXIT
cd ..



echo 'DONE'