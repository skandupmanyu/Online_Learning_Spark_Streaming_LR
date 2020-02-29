kill -9 $(ps aux | grep '[o]nline-learning_2.11-1.0.jar' | awk '{print $2}')
kill -9 $(ps aux | grep '[s]tart_data_flow.sh' | awk '{print $2}')
kill -9 $(ps aux | grep '[f]lume-mysql-kafka.conf' | awk '{print $2}')
