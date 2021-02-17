#run execute.sh to build and start jenkins_master- and slave-container

#login to jenkins on http://localhost:8080, user: admin, password: 123

#create a freestyle-project 

#configure slave-container:
add new node under localhost:8080/computer/new
configure like in configure_agent-1.png
get IP-adress of slave to set for Hostname: docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' agent-1
add credentials: user:test, password: test

#configure project to be built on agent-1
in your freestyle-projects configuration -> "Restrict where this project can be run" -> agent-1 (the name, you gave your node)


