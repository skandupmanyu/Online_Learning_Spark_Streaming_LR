cd $(dirname $0)

#CREATE/RESET DATABASE
sh ./Setup/SQL/create_db.sh
echo Sleep 5s
sleep 5

#START FLUME
sh ./Setup/Flume/start_flume.sh 
echo STARTED FLUME...
echo Sleep 5s
sleep 5

#START DATA INSERTION INTO MYSQL
sh ./Setup/SQL/start_data_flow.sh &
echo STARTED DATA FLOW TO MYSQL...
echo Sleep 5s
sleep 5

#START SPARK APPLICATION
sh ./Setup/Spark/run_app.sh
echo STARTED SPARK APPLICATION... 
echo Sleep 5s
sleep 5

#START DISPLAY
sh ./Setup/Display/display.sh
echo STARTED DISPLAY...
