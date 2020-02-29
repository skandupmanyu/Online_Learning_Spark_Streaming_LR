cd $(dirname $0)

for i in `seq 1 10`; do
 sh insert_data_regime_1.sh 
 sleep 12
done > ../Logs/start_data_flow_regime_1.log 2>&1

echo CHANGING REGIME...

while [ true ]; do
 sh insert_data_regime_2.sh 
 sleep 12
done > ../Logs/start_data_flow_regime_2.log 2>&1 &
